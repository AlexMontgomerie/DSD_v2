#include <stdio.h>
#include <stdint.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <math.h>
#include <stdlib.h>

#define N 64

double our_fmod(double a, double b)
{
	return a - b * floor(a/b);
}

int main(int argc, char *argv[])
{
	uint32_t a[N], b[N], ca[N], cs[N], cm[N];
	float *ap  = (float*)a,
	      *bp  = (float*)b,
	      *cap = (float*)ca,
	      *csp = (float*)cs,
	      *cmp = (float*)cm;

	double fmoda[N], fmodb[N];

	int fd = open("/dev/urandom", O_RDONLY);
	read(fd, a,     4*N);
	read(fd, b,     4*N);
	read(fd, fmoda, 8*N);
	read(fd, fmodb, 8*N);
	close(fd);
	
	for (int i = 0; i < N; i++)
		cap[i] = ap[i] + bp[i],
		csp[i] = ap[i] - bp[i],
		cmp[i] = ap[i] * bp[i];

	printf("op1\t\top2\t\tadd\t\tsub\t\tmul\n");
	for (int i = 0; i < N; i++)
		if (a[i] != 0.f && b[i] != 0.f)
			printf("0x%x\t0x%x\t0x%x\t0x%x\t0x%x\n"
			       "%f\t%f\t%f\t%f\t%f\n\n",
			       a [i], b [i], ca [i], cs [i], cm [i],
			       ap[i], bp[i], cap[i], csp[i], cmp[i]);

	printf("\nfmod testing: our calc / stdlib calc");
	for (int i = 0; i < N; i++)
		if (fmoda[i] != 0.0 && fmodb[i] != 0.0)
			printf("%c: %lf\t\t%lf\n", our_fmod(fmoda[i], fmodb[i]) == fmod(fmoda[i], fmodb[i]) ? 'y' : 'n',
					           our_fmod(fmoda[i], fmodb[i]),
						   fmod(fmoda[i], fmodb[i]));
	
	float inv_pi = 1.0 / M_PI;
	uint32_t *invpi = (int*)&inv_pi;
	printf("1/M_PI = %f -> 0x%x\n", inv_pi, *invpi);

	return 0;
}
