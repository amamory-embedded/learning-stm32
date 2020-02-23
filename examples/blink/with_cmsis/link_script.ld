/* Linkfile for a STM32F103*
 * Robin Isaksson 2016
 */

/* MEMORY STRUCTURE
 *  Program flash:   64 KB: 0x0000_0000 -> 0x0000_FFFF
 *  SRAM:             8 KB:
 *              VALID: Ranges
 *              SRAM: 0x1FFF_F830 to 0x1FFF_FFFF
 *              SRAM_U: 0x2000_0000 to 0x2000_176F
 *
 *              SRAM should be used for data as it is mapped to
 *              the CODE bus and can access memory in one clock
 *              cycle whereas SRAM is connected to the system bus
 *              where instruction access are delayed on clock cycle.
 */

MEMORY {
    SRAM :       ORIGIN = 0x20000000, LENGTH = 20K
    FLASH :      ORIGIN = 0x08000000, LENGTH = 64K

}

SECTIONS {
    _STACK_TOP = 0x20000000 + 20K;
    . = 0x00000000;

   .text : {
       KEEP ( * (vectors) );
       * (.text);
    } > FLASH

    .rodata : {
        * (.rodata);
    } > FLASH
    FLASH_DATA_START = .; /*Where we will load from flash when writing to SRAM */

    /* Now we'll configure where we will keep our data outside off flash */
    . = 0x20000000;
    SRAM_DATA_START = .;

    .data : AT (FLASH_DATA_START) {
        * (.data);
    } > SRAM
    SRAM_DATA_END = .;
    SRAM_DATA_SIZE = SRAM_DATA_END - SRAM_DATA_START;

    BSS_START = .;
    .bss : {
        * (.bss);
        * (COMMON);
    } > SRAM
    BSS_END = .;
    BSS_SIZE = BSS_END - BSS_START;
}

ENTRY(main)
