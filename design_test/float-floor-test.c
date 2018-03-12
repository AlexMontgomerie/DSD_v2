#include <stdio.h>
#include <stdint.h>
#include <math.h>

float a[] = {1.0f, 2.34353f, 3423.6789978f, 578678678670.35355f, 29.5f, 127.8f, 0.56f, 0.64556f, 0.0000000065756f};
float c[9];

int main()
{
	for (int i = 0; i < 9; i++)
		c[i] = floorf(a[i]);

	uint32_t *a_ = (uint32_t*)a,
			*c_ = (uint32_t*)c;

	for (int i = 0; i < 9; i++)
		printf("floor(%f) = %f\nfloor(0x%X) = 0x%X\n\n",
				a[i], c[i],
				a_[i], c_[i]);
	return 0;
}
