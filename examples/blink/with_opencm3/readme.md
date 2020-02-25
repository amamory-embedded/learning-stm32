readme.md

cd libs/libopencm3
make lib TARGETS=stm32/f1
cd ../../examples/blink/with_opencm3
make -f ../../../config/common.mk all
make -f ../../../config/common.mk flash

The startup code of projects based on opencm3 is located in
./libs/libopencm3/lib/cm3/vector.c

when you compile this application you will see
/home/lsa/stm32/learning-stm32/libs/libopencm3/lib/libopencm3_stm32f1.a(vector.o) 	  14159  (code: 484 data: 13675)
meaning this is the size of the startup code

note that symbols defined at the .ld file are referenced in the startup code
'''
	.data : {
		_data = .;
		*(.data*)	/* Read-write initialized data */
		. = ALIGN(4);
		_edata = .;
	} >ram AT >rom
	_data_loadaddr = LOADADDR(.data);

	.bss : {
		*(.bss*)	/* Read-write zero initialized data */
		*(COMMON)
		. = ALIGN(4);
		_ebss = .;
	} >ram
'''

For instance, _data_loadaddr, _data, _edata, _ebss are all defined in the linker script file.
In this case, these symbols are required to initialize the data segment and to zero the bss segment

'''
	for (src = &_data_loadaddr, dest = &_data;
		dest < &_edata;
		src++, dest++) {
		*dest = *src;
	}

	while (dest < &_ebss) {
		*dest++ = 0;
	}
'''