#include <linux/types.h>
int n100_simd_check_paths(void);
int n100_vector_trial(const void *,size_t,void *,size_t,unsigned);
int n100_lz4_fallback(const void *,size_t,void *,size_t,void *);
size_t control_workspace_size(void);
size_t control_workspace_alignment(void);
int control_encode_scalar(const void *,size_t,void *,size_t,unsigned,void *,size_t);
int control_decode_scalar(const void *,size_t,void *,size_t);
size_t candidate_workspace_size(void);
size_t candidate_workspace_alignment(void);
int candidate_encode_scalar(const void *,size_t,void *,size_t,unsigned,void *,size_t);
int candidate_decode_scalar(const void *,size_t,void *,size_t);
int n100_vector_encoder_decode_mixed(const void *,size_t,void *,size_t);
int n100_vector_encoder_encode_hint_avx2(const void *,size_t,void *,size_t,unsigned,unsigned *);
int n100_vector_decoder_decode_mixed(const void *,size_t,void *,size_t);
int n100_vector_decoder_encode_hint_avx2(const void *,size_t,void *,size_t,unsigned,unsigned *);
