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
#include <math.h>
#include <stdint.h>

int main()
{
  printf("Hello from Nios II!\n");

  unsigned int x[5] = {1,2,3,4,5};


  printf("x address: %X\n", (unsigned int)x);
  printf("x address: %X\n", (unsigned int)(x+1));

  unsigned int result = ALT_CI_AH_INSTR_0((unsigned int)&x[0],12);

  printf("result = %X\n",result);
  return 0;
}
