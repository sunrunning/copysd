.globl clock_init

clock_init:
	/*Set LOCK_TIME*/
	ldr	r0,	=0x7E00F000	/*APLL_LOCK*/
	ldr	r1,	=0x0000FFFF
	str	r1,	[r0]

	str	r1,	[r0, #4]	/*MPLL_LOCK*/
	str	r1,	[r0, #8]	/*EPLL_LOCK*/

#define OTHERS		0x7E00F900
	/*Set async mode*/   /*The CPU mode should be set to async mode while CPU clock != HCLK */
	ldr	r0,	=OTHERS
	ldr	r1,	[r0]
	bic	r1,	r1,	#0xC0
	str	r1,	[r0]

loop1:                          /*Wait until CPU enter async mode*/
	ldr	r0,	=OTHERS
	ldr	r1,	[r0]
	and	r1,	r1,	#0xf00
	cmp	r1,	#0
	bne	loop1

#define ARM_RATIO      0	/* ARMCLK = DOUTAPLL / (ARM_RATIO + 1)    */
#define HCLKX2_RATIO   1	/* HCLKX2 = HCLKX2IN / (HCLKX2_RATIO + 1) */
#define HCLK_RATIO     1	/* HCLK = HCLKX2 / (HCLK_RATIO + 1)       */
#define PCLK_RATIO     3	/* PCLK   = HCLKX2 / (PCLK_RATIO + 1)     */
#define MPLL_RATIO     0	/* DOUTMPLL = MOUTMPLL / (MPLL_RATIO + 1)     */
	ldr r0, =0x7E00F020  /* CLK_DIV0 */
	ldr r1, =(ARM_RATIO) | (MPLL_RATIO << 4) | (HCLK_RATIO << 8) | (HCLKX2_RATIO << 9) | (PCLK_RATIO << 12)
	str r1, [r0]


#define		APLL_CON_VAL	((1<<31) | (266 << 16) | (3 << 8) | (1))
	ldr r0, =0x7E00F00C
	ldr r1, =APLL_CON_VAL
	str r1, [r0]		/* APLL_CON, FOUTAPL = MDIV * Fin / (PDIV*2^SDIV) = 266*12/(3*2^1) = 532MHz  */

#define		MPLL_CON_VAL	((1<<31) | (266 << 16) | (3 << 8) | (1))
	ldr r0, =0x7E00F010
	ldr r1, =MPLL_CON_VAL
	str r1, [r0]		/* MPLL_CON, FOUTMPL = MDIV * Fin / (PDIV*2^SDIV) = 266*12/(3*2^1) = 532MHz  */
	

	ldr r0, =0x7E00F01C
	ldr r1, =0x03
	str r1, [r0]
	
	mov pc, lr
