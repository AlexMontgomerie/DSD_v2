#include <stdio.h>
#include <stdint.h>

void flt(float x)
{
	uint32_t *i = (uint32_t*)&x;
	printf("%f = 0x%x\n"
	       "s -> %d\n"
	       "e -> %d\n"
	       "m -> %d\n",
	       x, *i,
	       ((*i) & 0x80000000) >> 31,
	       ((*i) & 0x7F800000) >> 23,
	       ((*i) & 0x007FFFFF));
}

void as_int(uint32_t x)
{
	float *f = (float*)&x;
	printf("%f = 0x%x\n"
	       "s -> %d\n"
	       "e -> %d\n"
	       "m -> %d\n",
	       *f, x,
	       (x & 0x80000000) >> 31,
	       (x & 0x7F800000) >> 23,
	       (x & 0x007FFFFF));
}


int main()
{
	as_int(0x467c67ae);
	as_int(0x467c67af);
	return 0;
}
