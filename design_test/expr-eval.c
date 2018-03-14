#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <stdint.h>

float fn(float x)
{
	return x * (0.5f + x * cosf(floor(x/4) - 32));
}

int main()
{
	float testa[255], res[255];
	uint32_t *testa_ = (uint32_t*)testa,
		 *res_ = (uint32_t*)res;

	for (int i = 0; i < 255; i++) {
		testa[i] = (float)i;
		res[i] = fn(testa[i]);
		// toplevel test data
		/*printf("\t\t%sdataa = 32'h%x;\n\t\tdatab = 32'h00000000;\n\t\tresult_correct = 32'h%x;\n\n",
		 *		i ? "#20 " : "",
		 *		testa_[i],
		 *		res_[i]);
		 */
	}
	return 0;
}
