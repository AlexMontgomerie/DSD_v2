#include <stdio.h>
#include <stdint.h>
#include <math.h>
#include <stdlib.h>

#define PI 3.14159265

float a[127];
float a_tmp[127];

float b[127];

int main()
{
  for (int i = 0; i < 127; i++)
  {	
    a[i] = 2;
    for(int j=0;j<i;j++)    
      a[i]  = a[i]*2;
    
    if(i==0)
      b[i]  = 0.0;
    else if(i==1)
      b[i] = b[0];
    else b[i] = b[i-2];
    
    a_tmp[i] = a[i]-b[i];

    while(! (a_tmp[i] <  PI &&
             a_tmp[i] > -PI))
    {
      a_tmp[i] = a_tmp[i] - 2*PI;
      b[i] += 2*PI;
    }

    
    uint32_t *a_      = (uint32_t*)a;
    uint32_t *a_tmp_  = (uint32_t*)a_tmp;
    uint32_t *b_      = (uint32_t*)b;

    printf("%d : %f, %f, %f\n0x%X, 0x%X, 0x%X\n\n",
      i,a[i],a_tmp[i], b[i],
      a_[i],a_tmp_[i], b_[i]);
   }  
  return 0;
}
