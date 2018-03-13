#include <stdio.h>
#include <stdint.h>
#include <math.h>
#include <stdlib.h>

#define N 10

float tan_arr[N];
float angle[N];

char *convert(float num)
{
	char *ret = malloc(32);
	int   ipart = (int)floor(num);
	float fpart = num - floor(num);
	while (fpart - floor(fpart) != 0.0)
		fpart *= 10.0;
	sprintf(ret, "%c0x%x.%x\n",
		     num >= 0.0 ? '+' : '-',
		     ipart,
		     (int) fpart);
	return ret;
}

int main()
{
  for (int i = 0; i < N; i++)
  {	
    
    angle[i]  = pow(2,-i);
    tan_arr[i]   = atan(angle[i]);    
	uintconvert
    uint32_t *tan_arr_   = (uint32_t*)tan_arr;
    uint32_t *angle_     = (uint32_t*)angle;
	//TODO: print tan_arr as fixed
    printf("tanh(%f) = %f\ntanh(0x%X), 0x%X\n\n",
      angle[i], tan_arr[i],
      angle_[i], tan_arr_[i]);
   }  
  return 0;
}
