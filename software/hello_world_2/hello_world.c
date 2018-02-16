/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdio.h>
#include <sys/alt_stdio.h>
#include <sys/alt_alarm.h>
#include <sys/times.h>
#include <alt_types.h>
#include <system.h>
#include <unistd.h>
#include <stdlib.h>

#define N 52
#define step 5


void generateVector(float x[N])
{
	int i;
	x[0] = 0;

	for(i=1;i<N;i++)
		x[i] = x[i-1] + step;
	return;
}

float sumVector(float x[], int M)
{
	int i;
	float y = 0.0;

	if(M>N)
		M = N;

	for(i=0;i<N;i++)
		y = y + x[i] + x[i]*x[i];

	return y;
}


int main()
{

  //printf("Task 2!\n");

  float x[N];
  float y;

  generateVector(x);

  char buf[50];
  clock_t exec_t1, exec_t2;

  exec_t1 = times(NULL);

  y = sumVector(x, N);

  exec_t2 = times(NULL);

  gcvt((exec_t2 - exec_t1), 10, buf);
  alt_putstr(" proc time = "); alt_putstr(buf); alt_putstr(" ticks \n");

  int i;
  for(i=0;i<10;i++)
	  y = y/2.0;

  gcvt(((int) y), 10, buf);
  alt_putstr(" Result (divided by 1014) = "); alt_putstr(buf);

  return 0;
}
