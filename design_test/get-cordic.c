#include <stdio.h>
#include <stdint.h>
#include <math.h>
#include <stdlib.h>

#define N 10

float tan_arr[N];
float angle[N];

int main()
{
  for (int i = 0; i < N; i++)
  {	
    
    angle[i]  = pow(2,-i);
    tan_arr[i]   = atan(angle[i]);    

    uint32_t *tan_arr_      = (uint32_t*)tan_arr;
    uint32_t *angle_     = (uint32_t*)angle;

    printf("tanh(%f) = %f\ntanh(0x%X), 0x%X\n\n",
      angle[i], tan_arr[i],
      angle_[i], tan_arr_[i]);
   }  
  return 0;
}
