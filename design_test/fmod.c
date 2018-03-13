#include <stdio.h>
#include <math.h>
#include <stdint.h>

#define PI 3.14159265359

float our_fmod(float a, float b)
{
	return a - b * floor(a/b);
}

int main()
{
	printf("PI: %f\n\n\n\n",M_PI);
	float res; 		uint32_t *resp = (uint32_t*)&res;
	float our_res; 	uint32_t *our_resp = (uint32_t*)&our_res;
	float inv_pi = 1.0 / M_PI;
	uint32_t *invpi = (uint32_t*)&inv_pi;
	printf("fmod testing (ours / stdlib):\n");
	for (float i = -5.0; i < 25.0; i += 1.0) {
		uint32_t *j = (uint32_t*)&i;
		res = fmod(i, M_PI);
		printf("i=%f -> 0x%x\n%lf -> 0x%x\n\n", i, *j, res, *resp);
	}
	printf("1/M_PI = %f -> 0x%x\n", inv_pi, *invpi);
	inv_pi = M_PI;
	printf("2M_PI = %f -> 0x%x\n", inv_pi, *invpi);
	return 0;
}
