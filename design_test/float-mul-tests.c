#include <stdio.h>
#include <stdint.h>
#include <ctype.h>
#include <stdlib.h>
#include <unistd.h>

uint32_t test_data[48][3] = {{0x4c57449C, 0x00400000, 0x0CD7449},
{0x4f17c2f2, 0x4caaf006, 0x5C4AAB7E},
{0x4b846afe, 0x4ceb79a3, 0x58F39A44},
{0x00400000, 0x00400000, 0x00000000},
{0x00000000, 0x7F800000, 0XFFC00000},
{0xFFFFFFFF, 0xFFFFFCCC, 0xFFFFFfff},
{0xFFFFFCCC, 0xFFFFFFFF, 0xFFFFFccc},
{0xFC434000, 0x54535A80, 0XFF800000},
{0x7F800000, 0xfF800000, 0xfF800000},
{0x60100000, 0x5F800000, 0x7F800000},
{0x40800000, 0x40800000, 0x41800000},
{0x7F800000, 0x54535A80, 0x7F800000},
{0x007FFFFF, 0x007FFFFF, 0x00000000},
{0x3DCCCCCD, 0x3DCCCCCD, 0x3C23D70B},
{0x21B61B34, 0x625629D4, 0x4498587F},
{0x00000001, 0xFF7FFFFF, 0xB4FFFFFF},
{0x007FFFFF, 0x7E800001, 0x3F800000},
{0x0078F2AD, 0x2A9D2E9F, 0x00000000},
{0x0078F2AD, 0x6A9D2E9F, 0x2B9485B6},
{0x0078F2AD, 0x7E9D2E9F, 0x3F9485B6},
{0x00400000, 0x80400000, 0x80000000},
{0x023FDA64, 0x3C9BCA4E, 0x001D3036},
{0x021FDA64, 0x3C9BCA4E, 0x001851E3},
{0x021FDA64, 0x2C9BCA4E, 0x00000000},
{0x063BA4FD, 0x79EF28D4, 0x40AF4CF5},
{0x023fda64, 0x3c9bca4e, 0x001D3036},
{0xcc57449c, 0x491a5685, 0xd601C807},
{0X0,		 0x491a5685, 0X0   	   },
{0x4c57449c, 0X80000000, 0X80000000},
{0x0,        0X7F800000, 0XFFC00000},
{0XfF800000, 0X0       , 0XFFC00000},
{0XFF800000, 0x491a5685, 0XFF800000},
{0x4c57449c, 0X7F800000, 0X7F800000},
{0XFFC07020, 0x491a5685, 0XFFC07020},
{0x4c57449c, 0X7FC00301, 0X7FC00301},
{0XFFC07020, 0X7FC00301, 0XFFC07020},		
{0X7FC07020, 0x491a5685, 0X7FC07020},
{0x491a5685, 0X7F807020, 0X7FC07020},
{0XC91A5685, 0X7F807020, 0X7FC07020},
{0XC91A5685, 0XFF807020, 0XFFC07020},
{0X0, 	     0xC91a5685, 0X80000000},
{0xC91A5685, 0X80000000, 0X0	   },
{0x0,	     0X7FC00000, 0X7FC00000},
{0XFFC00000, 0X0, 	 0XFFC00000	   },
{0X7FC00002, 0X7F800001, 0X7FC00002},
{0X7F800001, 0X7FC00002, 0X7FC00001},
{0XFF800001, 0XFFC00002, 0XFFC00001},
{0X7F800001, 0XFFC00002, 0X7FC00001}};


int main(int argc, char **argv)
{
	float* a;
	float* b;
	float f;
	int c=0;
	
	while((c=getopt(argc,argv,"mas")) != -1) {
		switch(c)
		{
			case 'm':
				for(int i=0;i<48;i++){
					a = (float*)&test_data[i][0];
					b = (float*)&test_data[i][1];
					f = (*a)*(*b);
					uint32_t* res = (uint32_t*)&f;
					printf("%X\n", *res);
				}
				break;
				
			case 'a':
				for(int i=0;i<48;i++){
					a = (float*)&test_data[i][0];
					b = (float*)&test_data[i][1];
					f = (*a)+(*b);
					uint32_t* res = (uint32_t*)&f;
					printf("%X\n", *res);
				}
				break;
				
			case 's':
				for(int i=0;i<48;i++){
					a = (float*)&test_data[i][0];
					b = (float*)&test_data[i][1];
					f = (*a)-(*b);
					uint32_t* res = (uint32_t*)&f;
					printf("%X\n", *res);
				}
				break;
		}
	}
	
	return 0;
}
