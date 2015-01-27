#include "uart.h"


typedef unsigned char          unchar;
typedef unsigned short         ushort;
typedef unsigned int           uint;
typedef unsigned long          ulong;

#define SD_Control      (*((volatile unsigned int *)0x7C20008C))
#define TCM_BASE        0x0c004000
#define SS_SIZE         (8 * 1024)
#define eFUSE_SIZE      (1 * 1024)
#define MOVI_BLKSIZE		512

#define PART_SIZE_BL		(256 * 1024)
#define CFG_ENV_SIZE        0x80000

#define BL2_BASE         0x5FE00000
#define MOVI_TOTAL_BLKCNT *((volatile unsigned int *)(TCM_BASE - 0x4))



#define HSMMC_CHANNEL       0
#define MOVI_INIT_REQUIRED  0

#define CopyMovitoMem(a,b,c,d,e)    (((int(*)(int, uint, ushort, uint *, int))(*((uint *)(TCM_BASE + 0x8))))(a,b,c,d,e))


#define MOVI_LAST_BLKPOS	(MOVI_TOTAL_BLKCNT - (eFUSE_SIZE / MOVI_BLKSIZE))
#define MOVI_BL1_BLKCNT		(SS_SIZE / MOVI_BLKSIZE)
#define MOVI_ENV_BLKCNT		(CFG_ENV_SIZE / MOVI_BLKSIZE)
#define MOVI_BL2_BLKCNT		(PART_SIZE_BL / MOVI_BLKSIZE)
#define MOVI_BL2_POS		(MOVI_LAST_BLKPOS - MOVI_BL1_BLKCNT - MOVI_BL2_BLKCNT - MOVI_ENV_BLKCNT)


void movi_bl2_copy(void)
{ 
	//init_uart();
	SD_Control |= (0x3 << 16);
	CopyMovitoMem(HSMMC_CHANNEL, MOVI_BL2_POS, MOVI_BL2_BLKCNT, (uint *)BL2_BASE, MOVI_INIT_REQUIRED);
	//printf("Copy successed! \n\r");
}
