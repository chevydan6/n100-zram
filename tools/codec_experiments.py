# SPDX-License-Identifier: GPL-2.0-only
"""Source transforms for isolated experiments; reference sources stay intact."""
def add_runfill(text):
    marker='\t\tif (unlikely(offset < 8)) {'
    assert text.count(marker)==1
    code='''\t\t/* A distance-one match repeats one initialized byte. Only the
\t\t * normal bounded decoder and long, fully in-range matches use
\t\t * memset; keep all existing short/partial/error paths intact. */
\t\tif (endOnInput && !partialDecoding && offset == 1 &&
\t\t    length >= 128 && cpy <= oend - LASTLITERALS) {
\t\t\tmemset(op, match[0], length);
\t\t\top = cpy;
\t\t\tcontinue;
\t\t}

'''
    return text.replace(marker,code+marker)

def add_rep8(defs):
    marker='BYTE *const e = (BYTE *)dstEnd;'
    assert defs.count(marker)==1
    code="""
    /* An eight-byte initialized period can be repeated without loading
     * each preceding output word. Preserve the <=7-byte wild-copy contract. */
    if ((unsigned long)d - (unsigned long)s == 8 && e-d >= 128) {
        size_t pattern = LZ4_read_ARCH(s);
        size_t words = (size_t)(e-d)/8;
        __asm__ volatile ("rep stosq" : "+D"(d), "+c"(words)
                          : "a"(pattern) : "memory");
        if (d < e) LZ4_copy8(d, &pattern);
        return;
    }
"""
    return defs.replace(marker,marker+'\n'+code)

def add_matchrep8(text):
    marker='\t\top += 8;\n'
    assert text.count(marker)==1
    code='''
		/* Long effective eight-byte periods only. The first eight
		 * bytes were copied by the normal overlap handling above. */
		if (length >= 128 && (unsigned long)op - (unsigned long)match == 8 &&
		    cpy <= oend - LASTLITERALS) {
			size_t pattern = LZ4_read_ARCH(match);
			size_t words = (size_t)(cpy-op)/8;
			unsigned int tail = 0;
			__asm__ volatile ("rep stosq" : "+D"(op), "+c"(words)
					  : "a"(pattern) : "memory");
			while (op < cpy) *op++ = (BYTE)(pattern >> (8*tail++));
			continue;
		}
'''
    return text.replace(marker,marker+code)

def add_branchrep8(text):
    marker='/*\n * LZ4_decompress_generic()'
    assert text.count(marker)==1
    helper='''static __attribute__((__noinline__)) void n100_repeat8_copy(BYTE *dst,
						const BYTE *period, BYTE *end)
{
	size_t pattern = LZ4_read_ARCH(period);
	size_t words = (size_t)(end-dst)/8;
	unsigned int tail = 0;
	__asm__ volatile ("rep stosq" : "+D"(dst), "+c"(words)
				  : "a"(pattern) : "memory");
	while (dst < end) *dst++ = (BYTE)(pattern >> (8*tail++));
}

'''
    text=text.replace(marker,helper+marker)
    old='''		if (unlikely(offset < 8)) {
			op[0] = match[0];
			op[1] = match[1];
			op[2] = match[2];
			op[3] = match[3];
			match += inc32table[offset];
			LZ4_memcpy(op + 4, match, 4);
			match -= dec64table[offset];
		} else {
			LZ4_copy8(op, match);
			match += 8;
		}'''
    new='''		if (unlikely(offset <= 8)) {
			if (offset == 8) {
				LZ4_copy8(op, match);
				match += 8;
			} else {
				op[0] = match[0];
				op[1] = match[1];
				op[2] = match[2];
				op[3] = match[3];
				match += inc32table[offset];
				LZ4_memcpy(op + 4, match, 4);
				match -= dec64table[offset];
			}
			/* The usual short-offset expansion has initialized eight
			 * bytes. Effective period eight needs no more source loads.
			 * Other offsets keep the original hot path and no new test. */
			if (length >= 128 && match == op && cpy <= oend - LASTLITERALS) {
				n100_repeat8_copy(op+8, op, cpy);
				op = cpy;
				continue;
			}
		} else {
			LZ4_copy8(op, match);
			match += 8;
		}'''
    assert text.count(old)==1
    return text.replace(old,new)
