/* SPDX-License-Identifier: GPL-2.0-only */
/* Isolated guest ZRAM device correctness. Never a timing or host-swap tool. */
#define _GNU_SOURCE
#include <errno.h>
#include <cpuid.h>
#include <fcntl.h>
#include <linux/fs.h>
#include <pthread.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <unistd.h>
#define PAGE 4096
#define PAGES 128
#define WORKERS 4
static unsigned char *corpora;
static size_t corpus_bytes;
static unsigned long checks;
#define CHECK(c) do { checks++; if (!(c)) { fprintf(stderr,"zram-roundtrip line=%d errno=%d\n",__LINE__,errno); exit(2); } } while (0)
struct worker { const char *device;unsigned number;int failed;unsigned long checks; };
static void *exercise(void *opaque)
{
 struct worker *w=opaque;unsigned char *page=NULL,*expected=NULL;
 int fd=open(w->device,O_RDWR|O_DIRECT|O_CLOEXEC);
 if(fd<0||posix_memalign((void **)&page,PAGE,PAGE)||posix_memalign((void **)&expected,PAGE,PAGE)){w->failed=1;goto out;}
 /* Each worker owns disjoint pages. Patterns alternate through zero, same-word,
  * compressed and incompressible states; every later read must be independent. */
 for(unsigned pass=0;pass<4&&!w->failed;pass++){
  for(size_t index=w->number;index<corpus_bytes/PAGE;index+=WORKERS){
   off_t offset=(off_t)index*PAGE;
   if(pass==0)memset(expected,0,PAGE);
   else if(pass==1)for(unsigned at=0;at<PAGE;at+=8){uint64_t value=0x1020304050607080ULL+index;memcpy(expected+at,&value,8);}
   else memcpy(expected,corpora+((index+pass-2)%(corpus_bytes/PAGE))*PAGE,PAGE);
   if(pwrite(fd,expected,PAGE,offset)!=PAGE){w->failed=1;break;}
   memset(page,0xa5,PAGE);
   if(pread(fd,page,PAGE,offset)!=PAGE||memcmp(page,expected,PAGE)){w->failed=1;break;}
   w->checks++;
  }
 }
out:
 if(fd>=0)close(fd);
 free(page);free(expected);return NULL;
}
int main(int argc,char **argv)
{
 if(argc<3){fprintf(stderr,"usage: zram-roundtrip /dev/zram0 corpus.bin ...\n");return 2;}
 unsigned eax,ebx,ecx,edx;
 if(!__get_cpuid(1,&eax,&ebx,&ecx,&edx)||!(ecx&(1U<<31))||access("/gzram-diskless-guest",R_OK)){
  fprintf(stderr,"Refusing device writes outside the explicitly marked isolated guest\n");return 3;
 }
 FILE *swaps=fopen("/proc/swaps","r");char line[4096];CHECK(swaps);
 CHECK(fgets(line,sizeof(line),swaps));CHECK(!fgets(line,sizeof(line),swaps));CHECK(feof(swaps)&&!ferror(swaps));CHECK(!fclose(swaps));

 /* Require an explicit block device. The VM launcher supplies only its own
  * diskless guest's device; no sysfs mutation or swapping is done by this client. */
 struct stat st;CHECK(!stat(argv[1],&st)&&S_ISBLK(st.st_mode));
 size_t count=(size_t)argc-2;CHECK(count<=64);corpus_bytes=count*PAGES*PAGE;
 CHECK(!posix_memalign((void **)&corpora,PAGE,corpus_bytes));
 for(size_t i=0;i<count;i++){
  int fd=open(argv[i+2],O_RDONLY|O_CLOEXEC);CHECK(fd>=0);
  size_t done=0;while(done<PAGES*PAGE){ssize_t got=read(fd,corpora+i*PAGES*PAGE+done,PAGES*PAGE-done);CHECK(got>0);done+=(size_t)got;}
  unsigned char extra;CHECK(read(fd,&extra,1)==0);CHECK(!close(fd));
 }
 int fd=open(argv[1],O_RDWR|O_DIRECT|O_CLOEXEC);CHECK(fd>=0);
 uint64_t bytes;CHECK(!ioctl(fd,BLKGETSIZE64,&bytes));CHECK(bytes>=corpus_bytes&&bytes<=128ULL*1024*1024);
 pthread_t threads[WORKERS];struct worker workers[WORKERS]={0};
 for(unsigned i=0;i<WORKERS;i++){workers[i].device=argv[1];workers[i].number=i;CHECK(!pthread_create(&threads[i],NULL,exercise,&workers[i]));}
 for(unsigned i=0;i<WORKERS;i++){CHECK(!pthread_join(threads[i],NULL));CHECK(!workers[i].failed);checks+=workers[i].checks;}
 unsigned char *page;CHECK(!posix_memalign((void **)&page,PAGE,PAGE));
 /* After all writers finish, verify the final generation in a full-cycle
  * nonsequential order. This catches state leaking between compression streams. */
 size_t pages=corpus_bytes/PAGE;
 for(size_t n=0;n<pages;n++){
  size_t index=(n*104729UL)%pages;
  CHECK(pread(fd,page,PAGE,(off_t)index*PAGE)==PAGE);
  CHECK(!memcmp(page,corpora+((index+1)%pages)*PAGE,PAGE));
 }
 /* Discard a written page and verify zero-fill without altering adjacent data. */
 uint64_t range[2]={PAGE,PAGE};CHECK(!ioctl(fd,BLKDISCARD,range));
 memset(page,0xa5,PAGE);CHECK(pread(fd,page,PAGE,PAGE)==PAGE);
 for(unsigned i=0;i<PAGE;i++)CHECK(page[i]==0);
 CHECK(pread(fd,page,PAGE,0)==PAGE);CHECK(!memcmp(page,corpora+PAGE,PAGE));
 free(page);CHECK(!close(fd));free(corpora);
 printf("GZRAM_ZRAM_ROUNDTRIP_PASS corpora=%zu workers=%u checks=%lu\n",count,WORKERS,checks);
 return 0;
}
