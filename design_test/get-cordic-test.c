#include <stdio.h>
#include <stdint.h>
#include <math.h>
#include <stdlib.h>


float angle[9] ={1.0f,0.01f,3.0f,3.1f,2.13f,3.04f,1.2334543f,0.0005f,1.111f};
float xcos[9];
float ysin[9];


int main()
{
	
  for (int i = 0; i < 9; i++)
  {	  

	xcos[i] = cos(angle[i]);
	ysin[i] = sin(angle[i]);
	
	uint32_t *xcos_ 	= (uint32_t*)xcos;
	uint32_t *ysin_ 	= (uint32_t*)ysin;
    uint32_t *angle_    = (uint32_t*)angle;

    printf("cos(%f) = %f, sin(%f) = %f\ncos(0x%X) = 0x%X, sin(0x%X) = 0x%X \n\n",
      angle[i], xcos[i], angle[i], ysin[i],
      angle_[i],xcos_[i],angle_[i],ysin_[i]);
   }  
  return 0;
}
