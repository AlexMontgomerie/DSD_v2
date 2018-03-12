#include <stdio.h>
#include <stdint.h>
#include <math.h>
#include <stdlib.h>

#define N 10

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

float angle[9] ={-1.0f,0.01f,1.5f,1.4321f,1.01232f,-0.3434545f,1.2334543f,0.0005f,1.111f};
float xcos[9];
float xsin[9];

void cordic(float x_init, float y_init, float angle_init) {

	int i;	
	float a_n = 1.0;
	for(i=0;i<N;i++)
		a_n = a_n * sqrt(1+pow(2,(-2*i)));


	//TODO: print a_n as fixed
	a_n = 1/a_n;
	
	uint32_t *a_n_ 	= (uint32_t*)&a_n;	
	//printf("a_n = %f  (0x%X) \n\n",a_n,*a_n_);
	
	float x[N];
	float y[N];
	float z[N];
	
	float x_cos_correct = 1.0*cos(angle_init);
	float y_sin_correct = 1.0*sin(angle_init);

	x[0] = a_n;
	y[0] = 0.0;
	z[0] = angle_init;

	
	for(i=0;i<(N-1);i++) {
		if (z[i]>=0.0) {
			x[i+1] = x[i] - y[i]*(pow(2,(-i)));
			y[i+1] = y[i] + x[i]*(pow(2,(-i)));
			z[i+1] = z[i] - atan(pow(2,(-i)));
		}
		else {
			x[i+1] = x[i] + y[i]*(pow(2,(-i)));
			y[i+1] = y[i] - x[i]*(pow(2,(-i)));
			z[i+1] = z[i] + atan(pow(2,(-i)));			
		}
	}
	
	float x_cos = x[N-1];
	float y_sin = y[N-1];
	
	uint32_t *x_cos_ 	= (uint32_t*)&x_cos;		
	uint32_t *y_sin_ 	= (uint32_t*)&y_sin;		
	uint32_t *angle 	= (uint32_t*)&angle_init;		
	
	printf("ANGLE: 0x%X \nxcos correct = %f, ysin correct = %f\n xcos result = %f (0x%X), ysin result = %f (0x%X)\n cos diff= %f, sin diff= %f \n\n\n",
		*angle,
		x_cos_correct,
		y_sin_correct,
		x_cos, *x_cos_,
		y_sin, *y_sin_,
		x_cos_correct-x_cos,
		y_sin_correct-y_sin
		);
	
	return;
}

int main()
{
	
  for (int i = 0; i < 9; i++)
  {	  

	xcos[i] = 1.0*cos(angle[i]);
	xsin[i] = 1.0*sin(angle[i]);
	
	uint32_t *xcos_ 	= (uint32_t*)xcos;
	uint32_t *xsin_ 	= (uint32_t*)xsin;
    uint32_t *angle_    = (uint32_t*)angle;
	
	cordic(1.0/1.674,0.0,angle[i]);
    /*
	printf("cos(%f) = %f, sin(%f) = %f\ncos(0x%X) = 0x%X, sin(0x%X) = 0x%X \n\n",
      angle[i], xcos[i], angle[i], xsin[i],
      angle_[i],xcos_[i],angle_[i],xsin_[i]);
	*/
   } 
  return 0;
}
