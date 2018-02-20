#include <stdio.h>
#include <stdint.h>

float a[] = {1.0f, 2.0f, 3.0f, 500.0f, 29.5f, 127.8f, 21234.56f, 12345.0f, 1.11103f,0.000000001f,0.0000000000001f};
float b[] = {2.0f, 4.0f, 3.5f, 9.2f, 3007.5f, 126.4f, 223.67f, 123456.5f, 0.00123f,1000000000.0f,1000000000000.0f};
float c[11];

int main()
{
	for (int i = 0; i < 11; i++)
		c[i] = a[i] * b[i];

	uint32_t *a_ = (uint32_t*)a,
		 *b_ = (uint32_t*)b,
		 *c_ = (uint32_t*)c;

	for (int i = 0; i < 11; i++)
		printf("%f * %f = %f\n0x%X * 0x%X = 0x%X\n\n",
				a[i], b[i], c[i],
				a_[i], b_[i], c_[i]);
	return 0;
}
