#include <stdio.h>
#include <sys/alt_stdio.h>
#include <sys/alt_alarm.h>
#include <sys/times.h>
#include <alt_types.h>
#include <system.h>
#include <unistd.h>
#include <stdlib.h>
#include <math.h>

// Test case 1
#define step 5
#define N 52

// Test case 2
//#define step 0.1
//#define N 2551

//Test case 3
//#define step 0.001
//#define N 255001

float functionVector(float x[], int M) {

	int i;
	float y = 0.0;

	if(M>N)
		M = N;

	for(i=0;i<M;i++)
		y += x[i]*(0.5 + x[i]*cos(floor(x[i]/4)-32));

	return y;

}

void generateVector(float x[N])
{
	int i;
	x[0] = 0;

	for(i=1;i<N;i++) {
		x[i] = x[i-1] + (float) step;
	}
	return;
}

float sumVector(float x[], int M)
{
	int i;
	float y = 0.0;

	if(M>N)
		M = N;

	for(i=0;i<M;i++)
		y += x[i] + x[i]*x[i];

	return y;
}

int main()
{
  printf("Task 2!\n");

  float x[(int) N];
  float y = 0.0;

  printf("generating vector...\n");
  generateVector(x);

  char buf[50];
  clock_t exec_t1, exec_t2;

  printf("time starts now...");
  exec_t1 = times(NULL);

  float tmp;

  int i;

  for(i =0; i< N; i++)
	  tmp = y;
	  y = ALT_CI_AH_FUNC_INSTR_0(x[i],tmp);

  //y = functionVector(x, N);

  exec_t2 = times(NULL);
  printf("done.\n");

  //gcvt((exec_t2 - exec_t1), 10, buf);
  //alt_putstr(" proc time = "); alt_putstr(buf); alt_putstr(" ticks \n");


  printf("time elapsed: %d ticks\n", (int) (exec_t2 - exec_t1));
  printf("Result: %f", y);

  return 0;
}
