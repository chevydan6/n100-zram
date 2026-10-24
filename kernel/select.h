/* SPDX-License-Identifier: GPL-2.0-only */
#ifndef N100_SELECT_H
#define N100_SELECT_H
/* A bounded hint, never a format validator. The chosen full decoder still
 * validates the entire block. Read only the first sequence's length metadata. */
static inline int n100_first_long_period(const char *source, int size)
{
 const unsigned char *src = (const unsigned char *)source;
 unsigned int pos = 1, literals, offset, byte;
 if (size < 4 || size > 4352 || (src[0] & 15) != 15) return 0;
 literals = src[0] >> 4;
 if (literals == 15) {
  do {
   if (pos >= (unsigned int)size) return 0;
   byte = src[pos++]; literals += byte;
  } while (byte == 255);
 }
 if (literals > (unsigned int)size-pos) return 0;
 pos += literals;
 if ((unsigned int)size-pos < 3) return 0;
 offset = src[pos] | ((unsigned int)src[pos+1] << 8); pos += 2;
 if (offset > literals || (offset != 1 && offset != 2 && offset != 4 && offset != 8)) return 0;
 /* Extended match length is at least 15+4+109 = 128. */
 return src[pos] >= 109;
}
#endif
