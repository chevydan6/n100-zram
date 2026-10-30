/* SPDX-License-Identifier: GPL-2.0-only */
/* Matched scalar LZ4 tables and GHY1 hybrid; randomized operations. */
#define main gzram_legacy_benchmark_main
#include "../gzram/bench.c"
#undef main
struct table_codec { char name[64]; void *handle,*work; int (*enc)(const char *,char *,int,int,void *); gz_enc genc; gz_dec gdec; };
struct bank { unsigned char frame[PAGES][BOUND]; int length[PAGES]; long total; };
static int (*table_decode)(const char *,char *,int,int);
static int encode_entry(struct table_codec *v,unsigned p,void *dst)
{ return v->genc?v->genc(input[p],SIZE,dst,BOUND,10):v->enc((const char *)input[p],dst,SIZE,BOUND,v->work); }
static int decode_entry(struct table_codec *v,const void *src,int size,void *dst)
{ return v->gdec?v->gdec(src,size,dst,SIZE):table_decode(src,dst,size,SIZE); }

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
 struct table_codec v[6]={0}; const int bits[]={14,13,12,11};
 for(int j=0;j<4;j++){
  char path[4096];snprintf(v[j].name,sizeof(v[j].name),"table%d-scalar",bits[j]);snprintf(path,sizeof(path),"%s/%s.so",argv[1],v[j].name);
  v[j].handle=dlopen(path,RTLD_NOW|RTLD_LOCAL);if(!v[j].handle){fprintf(stderr,"%s\n",dlerror());return 4;}
  v[j].enc=dlsym(v[j].handle,"n100_reuse_compress");unsigned long (*worksize)(void)=dlsym(v[j].handle,"n100_reuse_worksize");void (*init)(void *)=dlsym(v[j].handle,"n100_reuse_init");
  if(!v[j].enc||!worksize||!init||worksize()!=(1UL<<bits[j])+32)return 5;
  v[j].work=calloc(1,worksize());if(!v[j].work)return 5;init(v[j].work);
 }
 table_decode=dlsym(v[0].handle,"n100_reuse_decompress");if(!table_decode)return 5;
 char path[4096];snprintf(path,sizeof(path),"%s/libgzram-hybrid-bitdirectblock2avxbits4bounded.so",argv[1]);
 void *hybrid=dlopen(path,RTLD_NOW|RTLD_LOCAL);if(!hybrid){fprintf(stderr,"%s\n",dlerror());return 4;}
 int (*available)(void)=dlsym(hybrid,"gzram_avx2_available");if(!available||!available()){fprintf(stderr,"AVX2 and OS state support required\n");return 5;}
 for(int j=4;j<6;j++){
  snprintf(v[j].name,sizeof(v[j].name),"ghy-combined-%s",j==4?"scalar":"avx2");
  v[j].genc=dlsym(hybrid,j==4?"gzram_encode_scalar":"gzram_encode_avx2");
  v[j].gdec=dlsym(hybrid,j==4?"gzram_decode_scalar":"gzram_decode_avx2");
  if(!v[j].genc||!v[j].gdec)return 5;
 }
 if(listv){for(int j=0;j<6;j++)puts(v[j].name);return 0;}
 const char *et=getenv("GZRAM_ENERGY_FD");if(et){char *end;errno=0;long fd=strtol(et,&end,10);if(errno||!*et||*end||fd<3||fd>2147483647)return 16;energy_fd=(int)fd;}
 setup_perf();if(!read_counter("/sys/class/powercap/intel-rapl:0/max_energy_range_uj",&energy_range))energy_range=0;uint64_t initial;if(!energy(&initial))energy_range=0;
 struct bank *banks=calloc(6,sizeof(*banks));if(!banks)return 17;
 fprintf(stderr,"Matched codec families: common LZ4 decoder=%p, separate GHY decoder entries, random task order, RAPL %s\n",(void *)table_decode,energy_range?"available":"unavailable");
 puts("corpus,round,variant,operation,ns_per_page,compressed_bytes,cycles,instructions,branch_misses,cache_misses,pmu_running_fraction,package_uj_per_page,hybrid_raw_pages,hybrid_gzram_pages,hybrid_lz4_pages,cpu_ns_per_page,cpu_utilization_percent");
 unsigned seen=0;
 for(unsigned c=0;c<sizeof(corpora)/sizeof(*corpora);c++){
  if(!corpus_visible(c)||(selected&&!selected_name(selected,corpora[c])))continue;
  seen++;fill(c);
  memset(banks,0,6*sizeof(*banks));
  for(int j=0;j<6;j++)for(unsigned p=0;p<PAGES;p++){
   int n=encode_entry(&v[j],p,banks[j].frame[p]);if(n<=0||n>BOUND)return 6;
   banks[j].length[p]=n;banks[j].total+=n;
   if(decode_entry(&v[j],banks[j].frame[p],n,output)!=SIZE||memcmp(output,input[p],SIZE))return 7;
  }
  if(validate){fprintf(stderr,"Validated %s: four scalar tables and two hybrid entries, 128 pages\n",corpora[c]);continue;}
  for(int round=-2;round<9;round++){
   int tasks[12]={0,1,2,3,4,5,6,7,8,9,10,11};for(int j=11;j>0;j--){int k=order_random()%(j+1),t=tasks[j];tasks[j]=tasks[k];tasks[k]=t;}
   for(int t=0;t<12;t++){
    int j=tasks[t]/2,op=tasks[t]%2;memcpy(packed,banks[j].frame,sizeof(packed));memcpy(sizes,banks[j].length,sizeof(sizes));memset(output,0,sizeof(output));
    uint64_t before=0,after=0;int rapl=energy(&before);begin();uint64_t cpu=cpu_now(),start=now();
    for(int n=0;n<OPS;n++){int p=n%PAGES;int got=op?decode_entry(&v[j],packed[p],sizes[p],output):encode_entry(&v[j],p,packed[p]);if(got!=(op?SIZE:sizes[p]))return 8;}
    uint64_t elapsed=now()-start,cpu_elapsed=cpu_now()-cpu;double counters[4],fraction;end(counters,&fraction);rapl=rapl&&energy(&after);
    if(op){if(memcmp(output,input[(OPS-1)%PAGES],SIZE))return 9;}else for(unsigned p=0;p<PAGES;p++)if(memcmp(packed[p],banks[j].frame[p],(size_t)sizes[p]))return 10;
    if(round>=0){double uj=rapl?(double)((after+energy_range-before)%energy_range)/OPS:-1;
     printf("%s,%d,%s,%s,%.3f,%.3f,%.3f,%.3f,%.6f,%.6f,%.6f,%.6f,-1,-1,-1,%.3f,%.3f\n",corpora[c],round,v[j].name,op?"decompress":"compress",(double)elapsed/OPS,(double)banks[j].total/PAGES,counters[0],counters[1],counters[2],counters[3],fraction,uj,(double)cpu_elapsed/OPS,100.0*(double)cpu_elapsed/(double)elapsed);
     fprintf(stderr,"Task %s %d %d %s %s\n",corpora[c],round,t,v[j].name,op?"decompress":"compress");}
   }fflush(stdout);
  }
 }
 free(banks);for(int j=0;j<4;j++){free(v[j].work);dlclose(v[j].handle);}dlclose(hybrid);return seen?0:2;
}
