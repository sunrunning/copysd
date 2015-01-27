.global _start
_start:
	/*Set Peri port address*/
	ldr	r0,	=0x70000000
	orr	r0,	r0,	#0x13
	mcr	p15,0,r0,c15,c2,4
	/*Disable watch dog*/
	ldr	r0,	=0x7E004000
	mov	r1,	#0
	str	r1,	[r0]
	
	bl	clock_init
	bl	mem_ctrl_asm_init
	/*Setup stack for C code*/
	/*bl  sdram_init*/

	/*Relocated the address*/
	adr r0, _start
	ldr	r1,	=_start
	ldr	r2,	=bss_start
	cmp	r0,	r1
	beq	clean_bss
	ldr	sp,	=0x5FE00000
	bl 	movi_bl2_copy

/*copy_loop:
	ldr	r3,	[r0],#4
	str	r3,	[r1],#4
	cmp	r1,	r2
	bne	copy_loop */

clean_bss:
	ldr	r0,	=bss_start
	ldr	r1,	=bss_end
	mov	r3,	#0
	cmp	r0,	r1
	beq	on_ddr
clean_loop:
	str	r3,	[r0], #4
	cmp	r0,	r1
	bne	clean_loop

on_ddr:
	bl	main /*This is the main function*/

halt:
	b	halt
