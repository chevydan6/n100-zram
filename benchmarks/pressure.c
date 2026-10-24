/* SPDX-License-Identifier: GPL-2.0-only */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/resource.h>
#define BYTES (768UL*1024*1024)
#define PAGES (BYTES/4096)
static uint64_t now(void){struct timespec t;clock_gettime(CLOCK_MONOTONIC_RAW,&t);return (uint64_t)t.tv_sec*1000000000+t.tv_nsec;}
static uint32_t step(uint32_t *r){*r^=*r<<13;*r^=*r>>17;*r^=*r<<5;return *r;}
static int mixed_pages;
static void fill(uint32_t *p,unsigned page){
 uint32_t r=page+100;unsigned kind=mixed_pages?page%4:0;
 for(int i=0;i<1024;i++){
  if(kind==3 || i<512)p[i]=step(&r);
  else if(kind==1)p[i]=0;
  else if(kind==2)p[i]=(i%127)*37+page;
  else p[i]=(i%16)*37+page;
 }
}
static int compare(const void *a,const void *b){uint64_t x=*(const uint64_t*)a,y=*(const uint64_t*)b;return (x>y)-(x<y);}
static void stats(const char *label){struct rusage r;getrusage(RUSAGE_SELF,&r);printf("{\"phase\":\"%s\",\"major_faults\":%ld,\"minor_faults\":%ld,\"user_us\":%ld,\"system_us\":%ld,\"max_rss_kib\":%ld}\n",label,r.ru_majflt,r.ru_minflt,r.ru_utime.tv_sec*1000000L+r.ru_utime.tv_usec,r.ru_stime.tv_sec*1000000L+r.ru_stime.tv_usec,r.ru_maxrss);fflush(stdout);}
static char cgroup_path[8192];
static int limits(void){
 FILE *f=fopen("/proc/self/cgroup","r");char line[4096],path[8192];unsigned long long max=0,swap=0;if(!f)return 0;
 if(!fgets(line,sizeof(line),f)){fclose(f);return 0;}fclose(f);
 char *group=strchr(line,':');if(!group||group[1]!=':')return 0;group+=2;group[strcspn(group,"\n")]=0;
 snprintf(cgroup_path,sizeof(cgroup_path),"/sys/fs/cgroup%s",group);
 snprintf(path,sizeof(path),"/sys/fs/cgroup%s/memory.max",group);f=fopen(path,"r");if(!f)return 0;int ok=fscanf(f,"%llu",&max)==1;fclose(f);
 snprintf(path,sizeof(path),"/sys/fs/cgroup%s/memory.swap.max",group);f=fopen(path,"r");if(!f)return 0;ok=ok&&fscanf(f,"%llu",&swap)==1;fclose(f);
 return ok&&max<=384UL*1024*1024&&max>=256UL*1024*1024&&swap>=BYTES&&swap<=1024UL*1024*1024;
}
static int health(void){
 char path[8300],key[128];unsigned long long value;int ok=1;
 snprintf(path,sizeof(path),"%s/memory.events",cgroup_path);
 FILE *f=fopen(path,"r");if(!f)return 0;
 printf("{\"phase\":\"cgroup_health\",\"memory_events\":{");int first=1;
 while(fscanf(f,"%127s %llu",key,&value)==2){
  printf("%s\"%s\":%llu",first?"":",",key,value);first=0;
  if((!strcmp(key,"oom")||!strcmp(key,"oom_kill")||!strcmp(key,"oom_group_kill"))&&value)ok=0;
 }
 fclose(f);printf("}");
 const char *files[]={"memory.peak","memory.swap.peak"};
 for(unsigned i=0;i<2;i++){
  snprintf(path,sizeof(path),"%s/%s",cgroup_path,files[i]);f=fopen(path,"r");
  if(!f)return 0;
  if(fscanf(f,"%llu",&value)!=1){fclose(f);return 0;}fclose(f);
  printf(",\"%s\":%llu",files[i],value);
 }
 puts("}");return ok;
}
int main(int argc,char **argv){
 if(argc==2 && !strcmp(argv[1],"--mixed-pages"))mixed_pages=1;
 else if(argc!=1){fprintf(stderr,"usage: pressure [--mixed-pages]\n");return 2;}
 printf("{\"corpus\":\"%s\"}\n",mixed_pages?"mixed-pages-v1":"period-tail-v1");
 if(!limits()){fprintf(stderr,"Required bounded cgroup memory/swap limits are absent\n");return 2;}
 uint32_t *data=mmap(NULL,BYTES,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0);if(data==MAP_FAILED){perror("mmap");return 3;}
 madvise(data,BYTES,MADV_NOHUGEPAGE);
 uint64_t *latency=malloc(PAGES*sizeof(*latency));if(!latency)return 4;
 stats("start");uint64_t begin=now();
 for(unsigned p=0;p<PAGES;p++)fill(data+p*1024,p);
 printf("{\"phase\":\"initial_fill\",\"pages\":%lu,\"elapsed_ns\":%llu}\n",PAGES,(unsigned long long)(now()-begin));stats("filled");
 for(int pass=0;pass<3;pass++){
  uint32_t expected[1024];begin=now();
  for(unsigned n=0;n<PAGES;n++){
   /* A full-cycle page permutation reduces sequential swap readahead. */
   unsigned p=(n*104729UL)%PAGES;fill(expected,p);uint64_t start=now();
   if(memcmp(data+p*1024,expected,4096)){fprintf(stderr,"Data mismatch pass=%d page=%u\n",pass,p);return 5;}
   latency[n]=now()-start;
  }
  uint64_t elapsed=now()-begin;qsort(latency,PAGES,sizeof(*latency),compare);
  printf("{\"phase\":\"verify\",\"pass\":%d,\"pages\":%lu,\"elapsed_ns\":%llu,\"page_compare_p50_ns\":%llu,\"page_compare_p95_ns\":%llu,\"page_compare_p99_ns\":%llu}\n",pass,PAGES,(unsigned long long)elapsed,(unsigned long long)latency[PAGES/2],(unsigned long long)latency[PAGES*95/100],(unsigned long long)latency[PAGES*99/100]);stats("verified");
 }
 if(!health()){fprintf(stderr,"Cgroup health check failed\n");return 6;}
 munmap(data,BYTES);free(latency);puts("{\"status\":\"passed\"}");return 0;
}
