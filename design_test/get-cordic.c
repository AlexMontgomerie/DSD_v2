#include <stdio.h>
#include <stdint.h>
#include <math.h>
#include <stdlib.h>

#define N 255

#define FIXED_ONE (powf(2.0f,29))
#define SGNBIT(x) (((x)>0.0 ? 0 : 1) << 31)

#define FIXED_BIT 29

uint32_t FLOAT2FIXED(float x)
{
	uint32_t mantissa = (uint32_t)(fabs(x) * FIXED_ONE);
	return SGNBIT(x) | mantissa;
}

float FIXED2FLOAT(uint32_t x)
{
	return ((float)x) / 0x20000000;
}

uint32_t f2f(float x)
{
	uint32_t *x_ = (uint32_t*)&x;
	uint32_t mant = (1<<31) | ((*x_ & 0x7FFFFF) << 8),
		 expo = (*x_ & 0x7F800000) >> 23,
		 sign = *x_ >> 31;
	
	uint32_t res_tmp = mant >> (127 - expo + 2);
	return sign ? ~res_tmp + 1 : res_tmp;
}

float tan_arr[N];
float angle[N];

char *convert(float num)
{
	char *ret = malloc(32);
	int   ipart = (int)floor(num);
	float fpart = num - floor(num);
	while (fpart - floor(fpart) != 0.0)
		fpart *= 10.0;

	sprintf(ret, "%c0x%x.%x",
		     num >= 0.0 ? '+' : '-',
		     ipart,
		     (int) fpart);
	return ret;
}

int main()
{
  for (int i = 0; i < N; i++)
  {	
    
  //  angle[i]  = pow(2,-i);
  //  tan_arr[i]   = atan(angle[i]);
   // uint32_t *tan_arr_   = (uint32_t*)tan_arr;
    //uint32_t *angle_     = (uint32_t*)angle;
   // generate tangent table
/*    printf("tanh(%f) = %f\ntanh(0x%X), 0x%X\ntanh(0x%8x) = 0x%08x\n\n",
      angle[i], tan_arr[i],
      angle_[i], tan_arr_[i],
      f2f(angle[i]), f2f(tan_arr[i])
 */
	  float theta = M_PI * ((float)i) / ((float)N);
	  float costh = cosf(theta);
    printf("\t\t%sx_start <= 32'h20000000\n\t\ty_start <= 32'h00000000\n\t\ttheta <= 32'h%x\n\t\tx_cos_correct <= 32'h%x\n\n",
		    i ? "#20 " : "",
		    f2f(theta),
		    f2f(costh));
   }  
  return 0;
}
