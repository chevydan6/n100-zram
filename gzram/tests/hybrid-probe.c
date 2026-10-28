// SPDX-License-Identifier: GPL-2.0-only
/* Device-API correctness only; this client produces no performance results. */
#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/syscall.h>
#include <unistd.h>
#include "../kernel/hybrid-probe.h"
#define BYTES (GHY_PROBE_PAGES * GHY_PROBE_PAGE_BYTES)
static unsigned checks;
#define CHECK(x) do { checks++; if (!(x)) { fprintf(stderr,"probe test line %d: %s (errno=%d)\n",__LINE__,#x,errno); exit(1); } } while(0)
static const char *device = "/dev/n100-ghy-probe";
struct task { int fd; unsigned seed; int result; };
static void *concurrent(void *opaque)
{
 struct task *t = opaque;
 unsigned i;
 for (i = 0; i < 512; i++) {
  unsigned codec = (i + t->seed) % GHY_PROBE_CODECS;
  int packed = ioctl(t->fd, GHY_PROBE_COMP(codec), 0UL);
  if (packed <= 0 || packed > 4352 || ioctl(t->fd, GHY_PROBE_DEC(codec), 0UL) != GHY_PROBE_PAGE_BYTES ||
      ioctl(t->fd, GHY_PROBE_FPU_NOP, 0UL) != 0) {
   t->result = 1; break;
  }
  packed = ioctl(t->fd, GHY_PROBE_COMP_FPU(codec), 0UL);
  if (packed <= 0 || packed > 4352 || ioctl(t->fd, GHY_PROBE_DEC_FPU(codec), 0UL) != GHY_PROBE_PAGE_BYTES) {
   t->result = 1; break;
  }
 }
 return NULL;
}
static void threads(int shared, const unsigned char *input)
{
 pthread_t ids[4]; struct task jobs[4]; unsigned i;
 for (i = 0; i < 4; i++) {
  int fd = shared >= 0 ? shared : open(device, O_RDWR | O_CLOEXEC);
  CHECK(fd >= 0);
  if (shared < 0) CHECK(write(fd, input, BYTES) == BYTES);
  jobs[i] = (struct task){.fd=fd,.seed=i,.result=0};
  CHECK(pthread_create(&ids[i], NULL, concurrent, &jobs[i]) == 0);
 }
 for (i = 0; i < 4; i++) {
  CHECK(pthread_join(ids[i], NULL) == 0); CHECK(!jobs[i].result);
  CHECK(ioctl(jobs[i].fd, GHY_PROBE_VALIDATE, 0UL) == 0);
  if (shared < 0) CHECK(close(jobs[i].fd) == 0);
 }
}
int main(int argc, char **argv)
{
 unsigned char *input = malloc(BYTES);
 uint32_t sizes[GHY_PROBE_CODECS][GHY_PROBE_PAGES], after[GHY_PROBE_CODECS][GHY_PROBE_PAGES];
 int fd = open(device, O_RDWR | O_CLOEXEC), corpus;
 CHECK(argc > 1 && input && fd >= 0);
 CHECK(lseek(fd, 0, SEEK_SET) == -1 && errno == ESPIPE);
 CHECK(ioctl(fd, GHY_PROBE_NOP, 0UL) == 0);
 CHECK(ioctl(fd, GHY_PROBE_FPU_NOP, 0UL) == 0);
 CHECK(ioctl(fd, GHY_PROBE_FPU_NOP, 1UL) == -1 && errno == EINVAL);
 CHECK(ioctl(fd, GHY_PROBE_VALIDATE, 0UL) == -1 && errno == EINVAL);
 CHECK(ioctl(fd, GHY_PROBE_COMP(0), 0UL) == -1 && errno == EINVAL);
 CHECK(ioctl(fd, _IO('G', 255), 0UL) == -1 && errno == ENOTTY);
 CHECK(ioctl(fd, GHY_PROBE_NOP, 1UL) == -1 && errno == EINVAL);
 CHECK(write(fd, input, 1) == -1 && errno == EINVAL);
 CHECK(read(fd, sizes, 1) == -1 && errno == EINVAL);
 CHECK(read(fd, sizes, sizeof(sizes)) == -1 && errno == EINVAL);
 for (corpus = 1; corpus < argc; corpus++) {
  FILE *source = fopen(argv[corpus], "rb"); unsigned codec, i;
  CHECK(source && fread(input, 1, BYTES, source) == BYTES);
  CHECK(fgetc(source) == EOF); CHECK(fclose(source) == 0);
  CHECK(write(fd, input, BYTES) == BYTES);
  CHECK(ioctl(fd, GHY_PROBE_VALIDATE, 0UL) == 0);
  CHECK(read(fd, sizes, sizeof(sizes)) == sizeof(sizes));
  for (codec = 0; codec < GHY_PROBE_CODECS; codec++) {
   for (i = 0; i < GHY_PROBE_PAGES; i++) CHECK(sizes[codec][i] > 0 && sizes[codec][i] <= 4352);
   for (i = 0; i < 512; i++) {
    CHECK(ioctl(fd, GHY_PROBE_COMP(codec), 0UL) == (int)sizes[codec][i % GHY_PROBE_PAGES]);
    CHECK(ioctl(fd, GHY_PROBE_DEC(codec), 0UL) == GHY_PROBE_PAGE_BYTES);
    CHECK(ioctl(fd, GHY_PROBE_NOP, 0UL) == 0);
   }
   for (i = 0; i < 512; i++) {
    CHECK(ioctl(fd, GHY_PROBE_COMP_FPU(codec), 0UL) == (int)sizes[codec][i % GHY_PROBE_PAGES]);
    CHECK(ioctl(fd, GHY_PROBE_DEC_FPU(codec), 0UL) == GHY_PROBE_PAGE_BYTES);
   }
  }
  CHECK(ioctl(fd, GHY_PROBE_VALIDATE, 0UL) == 0);
  CHECK(read(fd, after, sizeof(after)) == sizeof(after) && !memcmp(sizes, after, sizeof(sizes)));
  threads(fd, input); threads(-1, input);
  /* Raw syscall avoids compiler object-size diagnostics for intentional EFAULT. */
  CHECK(syscall(SYS_write, fd, (void *)1, BYTES) == -1 && errno == EFAULT);
  CHECK(ioctl(fd, GHY_PROBE_VALIDATE, 0UL) == -1 && errno == EINVAL);
  CHECK(write(fd, input, BYTES) == BYTES);
  CHECK(syscall(SYS_read, fd, (void *)1, sizeof(sizes)) == -1 && errno == EFAULT);
  CHECK(ioctl(fd, GHY_PROBE_VALIDATE, 0UL) == 0);
 }
 CHECK(close(fd) == 0); free(input);
 printf("GHY_PROBE_CLIENT_PASS corpora=%d checks=%u\n",argc-1,checks);
 return 0;
}
