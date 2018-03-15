#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <stdint.h>

float fn(float x)
{
	return x * (0.5f + x * cosf(floorf(x/4) - 32));
}

int delay = 64;

int main()
{
	float testa[255], res[255];
	uint32_t *testa_ = (uint32_t*)testa,
		 *res_ = (uint32_t*)res;

		res[0] = 0.0;
	for (int i = 0; i < 254; i++) {
		testa[i] = (float)i;
		res[i+1] = fn(testa[i]) + res[i];
		// toplevel test data
		printf("\t\tdataa <=#%i 32'h%x;\n\t\tdatab <=#%i 32'h%x;\n\t\tresult_correct <=#%i 32'h%x;\n\n",
		 		i*20,testa_[i],
				i*20,res_[i],
				20*(i+delay),res_[i+1]);
		 
	}
	return 0;
}
