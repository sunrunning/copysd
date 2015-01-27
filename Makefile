CC=arm-linux-gcc
LD=arm-linux-ld
AR=arm-linux-ar
OBJCOPY=arm-linux-objcopy
OBJDUMP=arm-linux-objdump

INCLUDEDIR := $(shell pwd)/include
CFLAGS     := -Wall -Os -fno-builtin-printf
CPPFLAGS   := -nostdinc -I$(INCLUDEDIR)
export CC LD AR OBJDUMP OBJCOPY INCLUDEDIR CFLAGS CPPFLAGS

objs := start.o main.o uart.o sdram_asm.o movi.o clock.o lib/libc.a

uart.bin: $(objs)
	${LD} -T uart.lds -Map uart.map -o uart.elf $^
	${OBJCOPY} -O binary -S uart.elf $@
	${OBJDUMP} -D uart.elf > uart.dis

.PHONY : lib/libc.a
lib/libc.a:
	cd lib; make; cd ..

%.o: %.S
	${CC} $(CPPFLAGS) $(CFLAGS) -c -o $@ $< 

%.o: %.c
	${CC} $(CPPFLAGS) $(CFLAGS) -c -o $@ $< 

clean:
	make clean -C lib
	rm *.o
	rm *.elf
	rm uart.bin
	rm uart.dis
