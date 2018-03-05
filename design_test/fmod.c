#include <stdio.h>
#include <math.h>
#include <stdint.h>

float our_fmod(float a, float b)
{
	return a - b * floor(a/b);
}

int main()
{
	float res; uint32_t *resp = (uint32_t*)&res;
	float inv_pi = 1.0 / M_PI;
	uint32_t *invpi = (int*)&inv_pi;
	printf("fmod testing (ours / stdlib):\n");
	for (float i = 0.0; i < 25.0; i += 1.0) {
		uint32_t *j = (uint32_t*)&i;
		res = fmod(i, M_PI);
		printf("i=%f -> 0x%x\n%lf -> 0x%x\n\n", i, *j, res, *resp);
	}
	printf("1/M_PI = %f -> 0x%x\n", inv_pi, *invpi);
	inv_pi = 2*M_PI;
	printf("2M_PI = %f -> 0x%x\n", inv_pi, *invpi);
	return 0;
}
