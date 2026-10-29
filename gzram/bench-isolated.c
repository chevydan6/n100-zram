/* SPDX-License-Identifier: GPL-2.0-only */
/* Reuse fixture/PMU definitions, preserving the legacy timing entry intact. */
#define main gzram_legacy_benchmark_main
#include "bench.c"
#undef main
#ifndef SHARED_DECODE
#define SHARED_DECODE 0
#endif
_Static_assert(SHARED_DECODE>=0&&SHARED_DECODE<=2,"Invalid shared decoder mode");
struct frame_bank { unsigned char data[PAGES][BOUND];int lengths[PAGES];long total;int modes[3]; };
static void *load_library(const char *directory,const char *name)
{
 char path[4096];int length=snprintf(path,sizeof(path),"%s/%s",directory,name);
 if(length<0||(size_t)length>=sizeof(path)){fprintf(stderr,"Library path too long\n");exit(2);}
 void *h=dlopen(path,RTLD_NOW|RTLD_LOCAL);if(!h){fprintf(stderr,"%s\n",dlerror());exit(4);}return h;
}
int main(int argc,char **argv)
{
 if(argc!=2&&argc!=3)return 2;
 int validate=argc==3&&!strcmp(argv[2],"--validate-only");
 int list_variants=argc==3&&!strcmp(argv[2],"--list-variants"),list_corpora=argc==3&&!strcmp(argv[2],"--list-corpora");
 int calls=argc==3&&!strcmp(argv[2],"--calls-per-batch"),dump=argc==3&&!strncmp(argv[2],"--dump-corpus=",14);
 if(argc==3&&!validate&&!list_variants&&!list_corpora&&!calls&&!dump)return 2;
 const char *selection=getenv("GZRAM_VARIANT_LIST"),*corpus_selection=getenv("GZRAM_CORPUS_LIST"),*order=getenv("GZRAM_ORDER_SEED");
 if(order){char *end;errno=0;order_seed=strtoull(order,&end,10);if(errno||!*order||*end||!order_seed)return 2;}
 if(getenv("GZRAM_HYBRID_SCREEN")){fprintf(stderr,"Supply an explicit isolated variant list\n");return 2;}
 if(dump){for(unsigned c=0;c<sizeof(corpora)/sizeof(*corpora);c++)if(corpus_visible(c)&&!strcmp(argv[2]+14,corpora[c])){fill(c);return fwrite(input,1,sizeof(input),stdout)==sizeof(input)?0:14;}return 2;}
 if(list_corpora){for(unsigned c=0;c<sizeof(corpora)/sizeof(*corpora);c++)if(corpus_visible(c)&&(!corpus_selection||selected_name(corpus_selection,corpora[c])))puts(corpora[c]);return 0;}
 if(calls){printf("%d\n",OPS);return 0;}
 void *baseline=load_library(argv[1],"lz4-small.so"),*shared=load_library(argv[1],"libgzram-hybrid-bitdirect.so");
 baseline_enc=(lz_enc)dlsym(baseline,"LZ4_compress_default");baseline_dec=(lz_dec)dlsym(baseline,"LZ4_decompress_safe");
 int (*available)(void)=dlsym(shared,"gzram_avx2_available");
 gz_enc canonical_encoder=dlsym(shared,"gzram_encode_scalar");
 gz_dec common[2]={dlsym(shared,"gzram_decode_scalar"),dlsym(shared,"gzram_decode_avx2")};
 if(!baseline_enc||!baseline_dec||!available||!available()||!canonical_encoder||!common[0]||!common[1])return 5;
 struct codec variants[CODEC_CAPACITY]={0};int count=0;
 if(!selection||selected_name(selection,"lz4-small-scalar")){strcpy(variants[count].name,"lz4-small-scalar");variants[count++].lz4=1;}
 for(unsigned policy=0;policy<sizeof(policies)/sizeof(*policies);policy++){
  void *handle=NULL;
  for(unsigned isa=0;isa<2;isa++)for(unsigned log=5;log<=12;log++){
   char name[64];snprintf(name,sizeof(name),"ghy-%s-%s-%u",policies[policy],isa?"avx2":"scalar",1U<<log);
   if(selection&&!selected_name(selection,name))continue;
   if(!handle){char library[128];snprintf(library,sizeof(library),"libgzram-hybrid-%s.so",policies[policy]);handle=load_library(argv[1],library);}
   struct codec *v=&variants[count++];strcpy(v->name,name);v->log=log;
   v->comp=(gz_enc)dlsym(handle,isa?"gzram_encode_avx2":"gzram_encode_scalar");
   v->dec=SHARED_DECODE==1?common[isa]:(gz_dec)dlsym(handle,isa?"gzram_decode_avx2":"gzram_decode_scalar");
   if(!v->comp||!v->dec)return 5;
  }
 }
 if(SHARED_DECODE==2){
  /* Requested aliases keep the same encoder and frames, but select the exact
   * same bitdirect decoder address in this process. The base variant must be
   * requested too. Bitdirect's own alias is an identical-entry negative control. */
  int originals=count;
  for(int i=0;i<originals;i++)if(!variants[i].lz4){
   const char *split=strchr(variants[i].name+4,'-');if(!split)return 2;
   char alias[64];int length=snprintf(alias,sizeof(alias),"%.*sshared%s",(int)(split-variants[i].name),variants[i].name,split);
   if(length<0||(size_t)length>=sizeof(alias))return 2;
   if(selection&&selected_name(selection,alias)){
    if(count>=CODEC_CAPACITY)return 2;
    variants[count]=variants[i];strcpy(variants[count].name,alias);
    variants[count++].dec=common[strstr(split,"-avx2-")!=NULL];
   }
  }
 }
 if(list_variants){for(int i=0;i<count;i++)puts(variants[i].name);return 0;}
 if(count<1||count>64){fprintf(stderr,"Choose 1..64 variants for bounded frame-bank memory\n");return 2;}
 cpu_set_t allowed,chosen;if(sched_getaffinity(0,sizeof(allowed),&allowed))return 3;
 int cpu=0;for(;cpu<CPU_SETSIZE;cpu++)if(CPU_ISSET(cpu,&allowed))break;if(cpu==CPU_SETSIZE)return 3;
 CPU_ZERO(&chosen);CPU_SET(cpu,&chosen);if(sched_setaffinity(0,sizeof(chosen),&chosen))return 3;
 const char *energy_text=getenv("GZRAM_ENERGY_FD");if(energy_text){char *end;errno=0;long fd=strtol(energy_text,&end,10);if(errno||!*energy_text||*end||fd<3||fd>2147483647)return 16;energy_fd=fd;}
 setup_perf();if(!read_counter("/sys/class/powercap/intel-rapl:0/max_energy_range_uj",&energy_range))energy_range=0;
 uint64_t initial;if(!energy(&initial))energy_range=0;
 struct frame_bank *banks=calloc((size_t)count,sizeof(*banks));if(!banks)return 17;
 fprintf(stderr,"Isolated benchmark: shared_decoder=%d; randomized operation tasks; immutable frames; CPU %d; frame-bank bytes=%zu; RAPL %s\n",SHARED_DECODE,cpu,(size_t)count*sizeof(*banks),energy_range?"available":"unavailable");
 for(int i=0;i<count;i++)fprintf(stderr,"Entry %s encoder=%p decoder=%p\n",variants[i].name,variants[i].lz4?(void *)baseline_enc:(void *)variants[i].comp,variants[i].lz4?(void *)baseline_dec:(void *)variants[i].dec);
 puts("corpus,round,variant,operation,ns_per_page,compressed_bytes,cycles,instructions,branch_misses,cache_misses,pmu_running_fraction,package_uj_per_page,hybrid_raw_pages,hybrid_gzram_pages,hybrid_lz4_pages,cpu_ns_per_page,cpu_utilization_percent");
 unsigned seen=0;
 for(unsigned corpus=0;corpus<sizeof(corpora)/sizeof(*corpora);corpus++){
  if(!corpus_visible(corpus)||(corpus_selection&&!selected_name(corpus_selection,corpora[corpus])))continue;
  seen++;fill(corpus);
  /* Setup is outside every timed task. The whole-codec tests independently
   * validate these frames first. Here each selected library must also decode
   * each page, and promised bitdirect encodings match the canonical bytes. */
  for(int i=0;i<count;i++){
   struct codec *v=&variants[i];struct frame_bank *b=&banks[i];b->total=0;memset(b->modes,0,sizeof(b->modes));
   for(unsigned p=0;p<PAGES;p++){
    int got=encode(v,p,b->data[p]);if(got<=0||got>BOUND)return 6;b->lengths[p]=got;b->total+=got;
    if(!v->lz4){if(b->data[p][6]>2)return 13;b->modes[b->data[p][6]]++;}
    memcpy(packed[p],b->data[p],(size_t)got);sizes[p]=got;
    if(decode(v,p)!=SIZE||memcmp(output,input[p],SIZE))return 7;
    if(!strncmp(v->name,"ghy-bitdirect",13)&&!strstr(v->name,"sample")){
     int canonical=canonical_encoder(input[p],SIZE,expected[p],BOUND,v->log);
     if(canonical!=got||memcmp(expected[p],b->data[p],(size_t)got)){fprintf(stderr,"Byte identity failed: %s\n",v->name);return 18;}
    }
   }
  }
  /* Equal streams also share the source of the pre-task restore. This removes
   * differing frame-bank addresses as a conditioning difference for aliases. */
  int bank_index[CODEC_CAPACITY];
  for(int i=0;i<count;i++){
   bank_index[i]=i;
   for(int j=0;j<i;j++){
    if(variants[i].lz4!=variants[j].lz4)continue;
    if(memcmp(banks[i].lengths,banks[j].lengths,sizeof(sizes)))continue;
    unsigned p=0;for(;p<PAGES;p++)if(memcmp(banks[i].data[p],banks[j].data[p],(size_t)banks[i].lengths[p]))break;
    if(p==PAGES){bank_index[i]=bank_index[j];break;}
   }
   fprintf(stderr,"Frames %s %s source=%s\n",corpora[corpus],variants[i].name,variants[bank_index[i]].name);
  }
  if(validate){fprintf(stderr,"Validated isolated %s: %d variants, 128 pages\n",corpora[corpus],count);continue;}
  for(int round=-2;round<9;round++){
   int tasks[2*CODEC_CAPACITY];for(int i=0;i<2*count;i++)tasks[i]=i;
   for(int i=2*count-1;i>0;i--){int j=order_random()%(i+1),tmp=tasks[i];tasks[i]=tasks[j];tasks[j]=tmp;}
   for(int t=0;t<2*count;t++){
    int index=tasks[t]/2,operation=tasks[t]%2;struct codec *v=&variants[index];struct frame_bank *b=&banks[bank_index[index]];
    /* All timed decoders see the same addresses; matched variants also see
     * byte-identical input. No candidate encoder is invoked in this setup. */
    memcpy(packed,b->data,sizeof(packed));memcpy(sizes,b->lengths,sizeof(sizes));memset(output,0,sizeof(output));
    uint64_t before=0,after=0;int rapl=energy(&before);begin();uint64_t cpu_start=cpu_now(),start=now();
    for(int i=0;i<OPS;i++){unsigned p=(unsigned)i%PAGES;int got=operation?decode(v,p):encode(v,p,packed[p]);if(got!=(operation?SIZE:sizes[p]))return 8;}
    uint64_t elapsed=now()-start,cpu_elapsed=cpu_now()-cpu_start;double counters[4],fraction;end(counters,&fraction);rapl=rapl&&energy(&after);
    if(operation){if(memcmp(output,input[(OPS-1)%PAGES],SIZE))return 9;}
    else for(unsigned p=0;p<PAGES;p++)if(memcmp(packed[p],b->data[p],(size_t)sizes[p]))return 10;
    if(round>=0){double uj=rapl?(double)((after+energy_range-before)%energy_range)/OPS:-1;
     printf("%s,%d,%s,%s,%.3f,%.3f,%.3f,%.3f,%.6f,%.6f,%.6f,%.6f,%d,%d,%d,%.3f,%.3f\n",corpora[corpus],round,v->name,operation?"decompress":"compress",(double)elapsed/OPS,(double)b->total/PAGES,counters[0],counters[1],counters[2],counters[3],fraction,uj,v->lz4?-1:b->modes[0],v->lz4?-1:b->modes[1],v->lz4?-1:b->modes[2],(double)cpu_elapsed/OPS,100.0*(double)cpu_elapsed/(double)elapsed);
     fprintf(stderr,"Task %s %d %d %s %s\n",corpora[corpus],round,t,v->name,operation?"decompress":"compress");
    }
   }
   fflush(stdout);
  }
 }
 free(banks);return seen?0:2;
}
