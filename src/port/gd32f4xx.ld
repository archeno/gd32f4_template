/* gd32f425ret6.ld - Linker script for GD32F425RET6 */

ENTRY(Reset_Handler)

MEMORY
{
    FLASH (rx)  : ORIGIN = 0x08000000, LENGTH = 512K
    RAM (xrw)   : ORIGIN = 0x20000000, LENGTH = 128K
}

SECTIONS
{
    .isr_vector :
    {
        KEEP(*(.isr_vector))
    } > FLASH

    .text :
    {
        *(.text)
        *(.text*)
        *(.rodata)
        *(.rodata*)
        KEEP(*(.init))
        KEEP(*(.fini))
    } > FLASH

    .ARM.exidx :
    {
        *(.ARM.exidx*)
    } > FLASH

    .data : AT (ADDR(.text) + SIZEOF(.text))
    {
        _sdata = .;
        *(.data)
        *(.data*)
        _edata = .;
    } > RAM

    .bss :
    {
        __bss_start = .;
        *(.bss)
        *(.bss*)
        *(COMMON)
        __bss_end = .;
    } > RAM

    ._user_heap_stack :
    {
        . = ALIGN(8);
        PROVIDE(_heap_start = .);
        . = . + 0x2000; /* 8KB heap */
        PROVIDE(_heap_end = .);
        . = ALIGN(8);
        PROVIDE(_stack_start = .);
        . = . + 0x2000; /* 8KB stack */
        PROVIDE(_stack_end = .);
    } > RAM

    /* Provide symbols for startup code */
    PROVIDE(_estack = ORIGIN(RAM) + LENGTH(RAM));
    PROVIDE(_sidata = LOADADDR(.data));
}