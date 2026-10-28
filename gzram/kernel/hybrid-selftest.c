// SPDX-License-Identifier: GPL-2.0-only
/* Isolated GHY1 workspace correctness module. No codec registration or ZRAM access. */
#include <linux/module.h>
#include <linux/slab.h>
#include <linux/kthread.h>
#include <linux/completion.h>
#include <linux/sched.h>
#include <linux/string.h>

#define PAGE_BYTES 4096
#define ROOM (PAGE_BYTES + 40)
#define WORK_BYTES 4128
#define GUARD 16
#define WORKERS 4
#define DECLARE_CODEC(prefix) \
 int prefix##_encode_scalar(const void *, size_t, void *, size_t, unsigned, void *, size_t); \
 size_t prefix##_workspace_size(void); \
 size_t prefix##_workspace_alignment(void); \
 int prefix##_decode_scalar(const void *, size_t, void *, size_t)
DECLARE_CODEC(control);
DECLARE_CODEC(candidate);
typedef int (*encoder)(const void *, size_t, void *, size_t, unsigned, void *, size_t);
typedef int (*decoder)(const void *, size_t, void *, size_t);
static const encoder encoders[] = {control_encode_scalar, candidate_encode_scalar};
static const decoder decoders[] = {control_decode_scalar, candidate_decode_scalar};
struct worker { struct completion done; unsigned seed; int result; unsigned long checks; unsigned modes; };
struct workspace { u64 before[2], data[WORK_BYTES / 8], after[2]; };
struct buffers {
 u8 source[PAGE_BYTES], encoded[2][ROOM + 2 * GUARD], decoded[2][ROOM + 2 * GUARD];
 struct workspace work[2];
};
static u32 next_random(u32 *state)
{
 u32 x = *state; x ^= x << 13; x ^= x >> 17; x ^= x << 5; return *state = x;
}
static bool intact(const u8 *b, size_t cap)
{
 return !memchr_inv(b, 0xa5, GUARD) && !memchr_inv(b + GUARD + cap, 0xa5, ROOM + GUARD - cap);
}
#define CHECK(condition) do { w->checks++; if (!(condition)) { \
 pr_err("gzram-hybrid-selftest: seed=%u line=%d check=%lu failed\n", w->seed, __LINE__, w->checks); \
 result = -EINVAL; goto out; } } while (0)
static int exercise(void *opaque)
{
 struct worker *w = opaque;
 struct buffers *b = kmalloc(sizeof(*b), GFP_KERNEL);
 u32 random = w->seed;
 unsigned iteration, codec, other, mask;
 int result = 0;
 if (!b) { result = -ENOMEM; goto out; }
 CHECK(control_workspace_size() == WORK_BYTES && candidate_workspace_size() == WORK_BYTES);
 CHECK(control_workspace_alignment() == 8 && candidate_workspace_alignment() == 8);
 memset(b->work, 0xa5, sizeof(b->work));
 for (codec = 0; codec < 2; codec++) {
  memset(b->encoded[codec], 0xa5, sizeof(b->encoded[codec]));
  CHECK(encoders[codec](b->source, 0, b->encoded[codec] + GUARD, 8, 10, NULL, WORK_BYTES) == 0);
  CHECK(encoders[codec](b->source, 0, b->encoded[codec] + GUARD, 8, 10, b->work[codec].data, WORK_BYTES - 1) == 0);
  CHECK(encoders[codec](b->source, 0, b->encoded[codec] + GUARD, 8, 10, (u8 *)b->work[codec].data + 1, WORK_BYTES) == 0);
  CHECK(!memchr_inv(b->encoded[codec], 0xa5, sizeof(b->encoded[codec])));
  CHECK(!memchr_inv(&b->work[codec], 0xa5, sizeof(b->work[codec])));
 }
 /* Independent raw and LZ4 literal-only GHY1 frames. These deliberately
  * exercise decoding independently of either encoder's selection decisions. */
 for (mask = 0; mask < 2; mask++) {
  u8 frame[43] = {'G','H','Y','1',32,0,0,0};
  size_t payload = mask ? 10 : 8, size = payload + 32, n;
  frame[6] = mask ? 2 : 0;
  if (mask) { frame[8] = 0xf0; frame[9] = 17; }
  for (n = 0; n < 32; n++) b->source[n] = frame[payload + n] = n + 1;
  for (codec = 0; codec < 2; codec++) for (n = 0; n <= size + 1; n++) {
   int got;
   memset(b->decoded[codec], 0xa5, sizeof(b->decoded[codec]));
   got = decoders[codec](frame, n, b->decoded[codec] + GUARD, 32);
   CHECK(got == (n == size ? 32 : -1));
   CHECK(intact(b->decoded[codec], 32));
   if (n == size) CHECK(!memcmp(b->source, b->decoded[codec] + GUARD, 32));
  }
 }
 /* Independently constructed nested MASK32 frames cover every lane mask, all
  * truncated lengths, and output caps immediately below/at the requirement. */
 for (mask = 0; mask < 256; mask++) {
  u8 frame[50] = {'G','H','Y','1',32,0,1,0,'G','Z','R','1',32,0,5,0,4};
  size_t size = 18, n;
  memset(b->source, 0, 32); frame[17] = mask;
  for (n = 0; n < 8; n++) if (mask & (1U << n)) {
   u32 value = 0x12340000U + n;
   memcpy(frame + size, &value, 4); memcpy(b->source + n * 4, &value, 4); size += 4;
  }
  for (codec = 0; codec < 2; codec++) for (n = 0; n <= size; n++) {
   int got;
   memset(b->decoded[codec], 0xa5, sizeof(b->decoded[codec]));
   got = decoders[codec](frame, n, b->decoded[codec] + GUARD, 32);
   CHECK(got == (n == size ? 32 : -1));
   CHECK(intact(b->decoded[codec], 32));
   if (n == size) CHECK(!memcmp(b->source, b->decoded[codec] + GUARD, 32));
  }
  for (codec = 0; codec < 2; codec++) {
   memset(b->decoded[codec], 0xa5, sizeof(b->decoded[codec]));
   CHECK(decoders[codec](frame, size, b->decoded[codec] + GUARD, 31) == -1);
   CHECK(intact(b->decoded[codec], 31));
  }
 }
 /* Independent one-block repeat frames exercise the direct scalar shortcut,
  * tails, truncations and mutations without relying on either encoder. */
 for (mask = 0; mask < 4; mask++) {
  const unsigned periods[] = {4, 8, 16, 32}, tags[] = {2, 3, 5, 6};
  const unsigned lengths[] = {4, 8, 16, 32, 36, 40, 48, 64, 96, 128,
                             1024, 1028, 1032, 1040, 1056, 2048, 4080, 4096};
  unsigned period = periods[mask], length;
  u8 frame[50] = {'G','H','Y','1',0,0,1,0,'G','Z','R','1',0,0,12,0};
  size_t size = 17 + period, at;
  frame[16] = tags[mask];
  for (at = 0; at < period; at++) frame[17 + at] = at + 1;
  for (length = 0; length < ARRAY_SIZE(lengths); length++) {
   size_t n = lengths[length], cut;
   if (n % period) continue;
   frame[4] = frame[12] = n & 255; frame[5] = frame[13] = n >> 8;
   for (at = 0; at < n; at++) b->source[at] = frame[17 + at % period];
   for (codec = 0; codec < 2; codec++) {
    for (cut = 0; cut <= size + 1; cut++) {
     int got;
     memset(b->decoded[codec], 0xa5, sizeof(b->decoded[codec]));
     got = decoders[codec](frame, cut, b->decoded[codec] + GUARD, n);
     CHECK(got == (cut == size ? (int)n : -1));
     CHECK(intact(b->decoded[codec], n));
     if (cut == size) CHECK(!memcmp(b->source, b->decoded[codec] + GUARD, n));
    }
    memset(b->decoded[codec], 0xa5, sizeof(b->decoded[codec]));
    CHECK(decoders[codec](frame, size, b->decoded[codec] + GUARD, n - 1) == -1);
    CHECK(intact(b->decoded[codec], n - 1));
   }
   for (at = 0; at < 17; at++) {
    int got[2]; unsigned bit;
    for (bit = 0; bit < 8; bit++) {
     frame[at] ^= 1U << bit;
     for (codec = 0; codec < 2; codec++) {
      memset(b->decoded[codec], 0xa5, sizeof(b->decoded[codec]));
      got[codec] = decoders[codec](frame, size, b->decoded[codec] + GUARD, PAGE_BYTES);
      CHECK(intact(b->decoded[codec], PAGE_BYTES));
     }
     CHECK(got[0] == got[1]);
     if (got[0] >= 0) CHECK(!memcmp(b->decoded[0] + GUARD, b->decoded[1] + GUARD, got[0]));
     frame[at] ^= 1U << bit;
    }
   }
   cond_resched();
  }
 }
 for (iteration = 0; iteration < 512; iteration++) {
  size_t n = iteration < 64 ? iteration : (iteration & 1 ? PAGE_BYTES : next_random(&random) % (PAGE_BYTES + 1));
  unsigned log = 5 + iteration % 8;
  int sizes[2], frame_size; size_t at;
  for (at = 0; at < n; at++) {
   u8 value = next_random(&random);
   switch (iteration % 8) {
   case 0: value = 0; break;
   case 1: value = at % 4; break;
   case 2: value = at % 16; break;
   case 3: value = at % 32; break;
   case 4: if (at < n / 2) value = 0; break;
   case 5: if (at % 32 >= 4) value = 0; break;
   case 6: if ((at / 32) & 1) value = 0; break;
   }
   b->source[at] = value;
  }
  for (codec = 0; codec < 2; codec++) {
   memset(b->encoded[codec], 0xa5, sizeof(b->encoded[codec]));
   sizes[codec] = encoders[codec](b->source, n, b->encoded[codec] + GUARD, n + 8, log, b->work[codec].data, WORK_BYTES);
   CHECK(sizes[codec] > 0 && sizes[codec] <= n + 8);
   CHECK(intact(b->encoded[codec], n + 8));
   CHECK(!memchr_inv(b->work[codec].before, 0xa5, sizeof(b->work[codec].before)));
   CHECK(!memchr_inv(b->work[codec].after, 0xa5, sizeof(b->work[codec].after)));
   CHECK(b->encoded[codec][GUARD + 6] <= 2);
   w->modes |= 1U << b->encoded[codec][GUARD + 6];
   for (other = 0; other < 2; other++) {
    memset(b->decoded[other], 0xa5, sizeof(b->decoded[other]));
    CHECK(decoders[other](b->encoded[codec] + GUARD, sizes[codec], b->decoded[other] + GUARD, n) == n);
    CHECK(intact(b->decoded[other], n));
    CHECK(!memcmp(b->source, b->decoded[other] + GUARD, n));
   }
  }
  CHECK(sizes[0] == sizes[1]);
  CHECK(!memcmp(b->encoded[0] + GUARD, b->encoded[1] + GUARD, sizes[0]));
  /* Mutation differential: failures may alter a bounded output prefix. */
  frame_size = sizes[0];
  b->encoded[0][GUARD + next_random(&random) % sizes[0]] ^= 1U << (iteration % 8);
  for (codec = 0; codec < 2; codec++) {
   memset(b->decoded[codec], 0xa5, sizeof(b->decoded[codec]));
   sizes[codec] = decoders[codec](b->encoded[0] + GUARD, frame_size, b->decoded[codec] + GUARD, PAGE_BYTES);
   CHECK(intact(b->decoded[codec], PAGE_BYTES));
  }
  CHECK(sizes[0] == sizes[1]);
  if (sizes[0] >= 0) CHECK(!memcmp(b->decoded[0] + GUARD, b->decoded[1] + GUARD, sizes[0]));
  cond_resched();
 }
 CHECK(w->modes == 7);
 out:
 kfree(b); w->result = result; complete(&w->done);
 /* Keep the task alive until init joins it; no worker can execute this module
  * after a successful init is followed immediately by rmmod. */
 while (!kthread_should_stop()) {
  set_current_state(TASK_INTERRUPTIBLE);
  if (!kthread_should_stop()) schedule();
 }
 __set_current_state(TASK_RUNNING); return result;
}
static int __init hybrid_selftest_init(void)
{
 struct worker workers[WORKERS];
 struct task_struct *tasks[WORKERS];
 unsigned i, launched = 0; int result = 0; unsigned long checks = 0;
 for (i = 0; i < WORKERS; i++) {
  struct task_struct *task;
  workers[i] = (struct worker){.seed = 100 + i}; init_completion(&workers[i].done);
  task = kthread_run(exercise, &workers[i], "gzram-check/%u", i);
  if (IS_ERR(task)) { result = PTR_ERR(task); break; }
  tasks[i] = task; launched++;
 }
 for (i = 0; i < launched; i++) {
  wait_for_completion(&workers[i].done);
  kthread_stop(tasks[i]);
  if (workers[i].result) result = workers[i].result;
  checks += workers[i].checks;
 }
 if (!result) pr_info("GZRAM_HYBRID_SELFTEST_PASS workers=%u checks=%lu\n", launched, checks);
 return result;
}
static void __exit hybrid_selftest_exit(void) {}
module_init(hybrid_selftest_init);
module_exit(hybrid_selftest_exit);
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Experimental GHY1 scalar workspace correctness only; no ZRAM registration");
