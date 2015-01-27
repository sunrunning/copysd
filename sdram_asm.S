	.globl mem_ctrl_asm_init
mem_ctrl_asm_init:
	ldr	r0, =0x7e00f120			@Memory sussystem address 0x7e00f120
	mov	r1, #0xd				@ Xm0CSn2 = NFCON CS0, Xm0CSn3 = NFCON CS1
	str	r1, [r0]

	ldr	r0, =0x7e001000			@DMC1 base address 0x7e001000

	ldr	r1, =0x04
	str	r1, [r0, #0x04]

	ldr	r1, =1115
	str	r1, [r0, #0x10]

	ldr	r1, =6
	str	r1, [r0, #0x14]

	ldr	r1, =1
	str	r1, [r0, #0x18]

	ldr	r1, =2
	str	r1, [r0, #0x1c]

	ldr	r1, =7
	str	r1, [r0, #0x20]

	ldr	r1, =10
	str	r1, [r0, #0x24]

	ldr	r1, =4
	ldr	r2, =8
	orr	r1, r1, r2
	str	r1, [r0, #0x28]

	ldr	r1, =12
	ldr	r2, =288
	orr	r1, r1, r2
	str	r1, [r0, #0x2c]

	ldr	r1, =4
	ldr	r2, =8
	orr	r1, r1, r2
	str	r1, [r0, #0x30]

	ldr	r1, =3
	str	r1, [r0, #0x34]

	ldr	r1, =3
	str	r1, [r0, #0x38]

	ldr	r1, =0x7
	str	r1, [r0, #0x3c]

	ldr	r1, =0x2
	str	r1, [r0, #0x40]

	ldr	r1, =18
	str	r1, [r0, #0x44]

	ldr	r1, =18
	str	r1, [r0, #0x48]

	ldr	r1, =0x0001001a
	str	r1, [r0, #0x0C]

	ldr	r1, =0xb45
	str	r1, [r0, #0x4c]

	ldr	r1, =0x150f0
	str	r1, [r0, #0x200]

	ldr	r1, =0x0
	str	r1, [r0, #0x304]

	@DMC0 DDR Chip 0 configuration direct command reg
	ldr	r1, =0x0c0000
	str	r1, [r0, #0x08]

	@Precharge All
	ldr	r1, =0x000000
	str	r1, [r0, #0x08]

	@Auto Refresh	2 time
	ldr	r1, =0x040000
	str	r1, [r0, #0x08]
	str	r1, [r0, #0x08]

	@MRS
	ldr	r1, =0x0a0000
	str	r1, [r0, #0x08]

	@Mode Reg
	ldr	r1, =0x080032
	str	r1, [r0, #0x08]

	@Enable DMC1
	mov	r1, #0x0
	str	r1, [r0, #0x04]

check_dmc1_ready:
	ldr	r1, [r0, #0x00]
	mov	r2, #0x3
	and	r1, r1, r2
	cmp	r1, #0x1
	bne	check_dmc1_ready
	nop
    mov	pc, lr
	
