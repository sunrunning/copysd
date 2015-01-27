#include "uart.h"


int main()
{
	char c,i;
	c = 'w';
	init_uart();
	printf("hello world!\n\r");
	while(1)
	{ 
		for(i = 0; i < 4; i++ )
			putc(c);
		i = 0;
		//putc(0x0a);
		putc(0x0d);
		//printf("hello world!\n\r");
				
	}
	/*while(1)
	{ 
		printf("[w] write the nand flash\n\r");
		printf("[r] read the nand flash\n\r");
		printf("[e] erase the nand flash\n\r");
		printf("[g] get file, and write to nand flash 0 block\n\r");
		printf("[x] get file to ddr(0x52000000), run it\n\r");
		printf("[t] test lcd\n\r");
		printf("[s] test touch screem\n\r");
		printf("[a] test ac97\n\r");
		printf("[n] test DM9000\n\r");
		
		do {
			c = getc();
			if (c == '\n' || c == '\r')
			{
				printf("\n\r");
			} 
			else
			{
				putc(c);
			}
		} while (c == '\n' || c == '\r');
		
		switch(c)
		{
			case 'n':
			case 'N':
			{
				//dm9000_test();
				break;
			}
		}
	}*/
	return 0;
}
