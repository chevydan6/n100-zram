/* SPDX-License-Identifier: GPL-2.0-only */
/* Scalar LZ4 matched tables; randomized operations and common decoder. */
#define main gzram_legacy_benchmark_main
#include "../gzram/bench.c"
#undef main
struct table_codec { char name[32]; void *handle,*work; int (*enc)(const char *,char *,int,int,void *); };
struct bank { unsigned char frame[PAGES][BOUND]; int length[PAGES]; long total; };
int main(int argc,char **argv)
{
 if(argc<2||argc>3)return 2;
 int validate=argc==3&&!strcmp(argv[2],"--validate-only");
 int listv=argc==3&&!strcmp(argv[2],"--list-variants"),listc=argc==3&&!strcmp(argv[2],"--list-corpora");
 int calls=argc==3&&!strcmp(argv[2],"--calls-per-batch"),dump=argc==3&&!strncmp(argv[2],"--dump-corpus=",14);
 if(argc==3&&!validate&&!listv&&!listc&&!calls&&!dump)return 2;
 const char *selected=getenv("GZRAM_CORPUS_LIST"),*order=getenv("GZRAM_ORDER_SEED");
 if(order){char *end;errno=0;order_seed=strtoull(order,&end,10);if(errno||!*order||*end||!order_seed)return 2;}
 if(listc){for(unsigned c=0;c<sizeof(corpora)/sizeof(*corpora);c++)if(corpus_visible(c)&&(!selected||selected_name(selected,corpora[c])))puts(corpora[c]);return 0;}
 if(dump){for(unsigned c=0;c<sizeof(corpora)/sizeof(*corpora);c++)if(corpus_visible(c)&&!strcmp(argv[2]+14,corpora[c])){fill(c);return fwrite(input,1,sizeof(input),stdout)==sizeof(input)?0:14;}return 2;}
 if(calls){printf("%d\n",OPS);return 0;}
 struct table_codec v[4]={0}; const int bits[]={14,13,12,11};
 for(int j=0;j<4;j++){
  char path[4096];snprintf(v[j].name,sizeof(v[j].name),"table%d-scalar",bits[j]);snprintf(path,sizeof(path),"%s/%s.so",argv[1],v[j].name);
  v[j].handle=dlopen(path,RTLD_NOW|RTLD_LOCAL);if(!v[j].handle){fprintf(stderr,"%s\n",dlerror());return 4;}
  v[j].enc=dlsym(v[j].handle,"n100_reuse_compress");unsigned long (*worksize)(void)=dlsym(v[j].handle,"n100_reuse_worksize");void (*init)(void *)=dlsym(v[j].handle,"n100_reuse_init");
  if(!v[j].enc||!worksize||!init||worksize()!=(1UL<<bits[j])+32)return 5;
  v[j].work=calloc(1,worksize());if(!v[j].work)return 5;init(v[j].work);
 }
 int (*dec)(const char *,char *,int,int)=dlsym(v[0].handle,"n100_reuse_decompress");if(!dec)return 5;
 if(listv){for(int j=0;j<4;j++)puts(v[j].name);return 0;}
 const char *et=getenv("GZRAM_ENERGY_FD");if(et){char *end;errno=0;long fd=strtol(et,&end,10);if(errno||!*et||*end||fd<3||fd>2147483647)return 16;energy_fd=(int)fd;}
 setup_perf();if(!read_counter("/sys/class/powercap/intel-rapl:0/max_energy_range_uj",&energy_range))energy_range=0;uint64_t initial;if(!energy(&initial))energy_range=0;
 struct bank *banks=calloc(4,sizeof(*banks));if(!banks)return 17;
 fprintf(stderr,"Scalar table benchmark: common decoder=%p, random operation order, RAPL %s\n",(void *)dec,energy_range?"available":"unavailable");
 puts("corpus,round,variant,operation,ns_per_page,compressed_bytes,cycles,instructions,branch_misses,cache_misses,pmu_running_fraction,package_uj_per_page,hybrid_raw_pages,hybrid_gzram_pages,hybrid_lz4_pages,cpu_ns_per_page,cpu_utilization_percent");
 unsigned seen=0;
 for(unsigned c=0;c<sizeof(corpora)/sizeof(*corpora);c++){
  if(!corpus_visible(c)||(selected&&!selected_name(selected,corpora[c])))continue;
  seen++;fill(c);
  memset(banks,0,4*sizeof(*banks));
  for(int j=0;j<4;j++)for(unsigned p=0;p<PAGES;p++){
   int n=v[j].enc((const char *)input[p],(char *)banks[j].frame[p],SIZE,BOUND,v[j].work);if(n<=0||n>BOUND)return 6;
   banks[j].length[p]=n;banks[j].total+=n;
   if(dec((const char *)banks[j].frame[p],(char *)output,n,SIZE)!=SIZE||memcmp(output,input[p],SIZE))return 7;
  }
  if(validate){fprintf(stderr,"Validated %s: four scalar tables, 128 pages\n",corpora[c]);continue;}
  for(int round=-2;round<9;round++){
   int tasks[8]={0,1,2,3,4,5,6,7};for(int j=7;j>0;j--){int k=order_random()%(j+1),t=tasks[j];tasks[j]=tasks[k];tasks[k]=t;}
   for(int t=0;t<8;t++){
    int j=tasks[t]/2,op=tasks[t]%2;memcpy(packed,banks[j].frame,sizeof(packed));memcpy(sizes,banks[j].length,sizeof(sizes));memset(output,0,sizeof(output));
    uint64_t before=0,after=0;int rapl=energy(&before);begin();uint64_t cpu=cpu_now(),start=now();
    for(int n=0;n<OPS;n++){int p=n%PAGES;int got=op?dec((const char *)packed[p],(char *)output,sizes[p],SIZE):v[j].enc((const char *)input[p],(char *)packed[p],SIZE,BOUND,v[j].work);if(got!=(op?SIZE:sizes[p]))return 8;}
    uint64_t elapsed=now()-start,cpu_elapsed=cpu_now()-cpu;double counters[4],fraction;end(counters,&fraction);rapl=rapl&&energy(&after);
    if(op){if(memcmp(output,input[(OPS-1)%PAGES],SIZE))return 9;}else for(unsigned p=0;p<PAGES;p++)if(memcmp(packed[p],banks[j].frame[p],(size_t)sizes[p]))return 10;
    if(round>=0){double uj=rapl?(double)((after+energy_range-before)%energy_range)/OPS:-1;
     printf("%s,%d,%s,%s,%.3f,%.3f,%.3f,%.3f,%.6f,%.6f,%.6f,%.6f,-1,-1,-1,%.3f,%.3f\n",corpora[c],round,v[j].name,op?"decompress":"compress",(double)elapsed/OPS,(double)banks[j].total/PAGES,counters[0],counters[1],counters[2],counters[3],fraction,uj,(double)cpu_elapsed/OPS,100.0*(double)cpu_elapsed/(double)elapsed);
     fprintf(stderr,"Task %s %d %d %s %s\n",corpora[c],round,t,v[j].name,op?"decompress":"compress");}
   }fflush(stdout);
  }
 }
 free(banks);for(int j=0;j<4;j++){free(v[j].work);dlclose(v[j].handle);}return seen?0:2;
}
