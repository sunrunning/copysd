SECTIONS {
	. = 0x5FE00000;
		.text : {
			start.o
			*(.text)		
		}
		
		.rodata : {
			*(.rodata)
		}
		
		.data : {
			*(.data)		
		}
	bss_start = .;
	.bss ALIGN(4) : {*(.bss) *(COMMON)}		
	bss_end = .;
}
