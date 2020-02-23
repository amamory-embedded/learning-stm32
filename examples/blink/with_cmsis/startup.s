/* Startup code for a STM32F103C8
 * Robin Isaksson 2017
 */ 
.syntax unified
.arch armv7-m 
.thumb 

/* Initial vector table */
        .section "vectors" 
    .long    _STACK_TOP             /* Top of Stack */
    .long    _reset_Handler        /* Reset Handler */
    .long    _NMI_Handler           /* NMI Handler */
    .long    _HardFault_Handler     /* Hard Fault Handler */
    .long    _MemManage_Handler    /* Reserved */
    .long    _BusFault_Handler     /* Reserved */
    .long    _UsageFault_Handler   /* Reserved */
    .long    0                     /* Reserved */
    .long    0                     /* Reserved */
    .long    0                     /* Reserved */
    .long    0                     /* Reserved */
    .long    _SVCall_Handler       /* SVCall Handler */
    .long    _DebugMonitor_Handler /* Reserved */
    .long    0                     /* Reserved */
    .long    _PendSV_Handler        /* PendSV Handler */
    .long    _SysTick_Handler       /* SysTick Handler */



/* Startup code */
.text
.thumb_func
_reset_Handler: 

        /* Copy data from flash to RAM */
_startup: 
        @@ Copy data to RAM 
        ldr     r0, =FLASH_DATA_START
        ldr     r1, =SRAM_DATA_START
        ldr     r2, =SRAM_DATA_SIZE 
        @@ If data is zero then do not copy 
        cmp     r2, #0 
        beq     _BSS_init 
        /* Initialize data by loading it to SRAM */
        ldr     r3, =0 @@ i = 0 
_RAM_copy: 
        ldr    r4, [r0, r3] @@ r4 = FLASH_DATA_START[i] 
        str    r4, [r1, r3] @@ SRAM_DATA_START[i] = r4 
        adds    r3, #4       @@ i++ 
        cmp     r3, r2       @@ if i < SRAM_DATA_SIZE then branch 
        blt     _RAM_copy    @@ otherwise loop again 

        /* Initialize uninitialized variables to zero (required for C) */
_BSS_init: 
        ldr     r0, =BSS_START 
        ldr     r1, =BSS_END
        ldr     r2, =BSS_SIZE 
        /* If BSS size is zero then do not initialize */
        cmp     r2, #0
        beq     _end_of_init
        /* Initialize BSS variables to zero */
        ldr     r3, =0x0 @@ i = 0 
        ldr     r4, =0x0 @@ r4 = 0 
_BSS_zero: 
        str     r4, [r0, r3] @@ BSS_START[i] = 0
        adds    r3, #4       @@ i++
        cmp     r3, r2       @@ if i < BSS_SIZE then branch
        blt     _BSS_zero        @@ otherwise loop again 

        /* Here control is given to the C-main function. Take note that
         * no heap is initialized. */
_end_of_init:   bl   main 
_halt:  b       _halt 

/* Here are all the interrupt vectors. The macro below define each and every
 * one of the ones listed beolw as a weak symbol which can be overwritten by
 * including the corresponding function-name in a C-file (for example) */
.macro                 def_rewritable_handler   handler 
    .thumb_func
    .weak    \handler
    .type    \handler, %function
    \handler:   b  . @@ Branch forever in default state
.endm
       
def_rewritable_handler  _NMI_Handler             /* NMI HANDLER */
def_rewritable_handler  _HardFault_Handler       /* HARD FAULT Handler */
def_rewritable_handler  _MemManage_Handler    /* Reserved */
def_rewritable_handler  _BusFault_Handler     /* Reserved */
def_rewritable_handler  _UsageFault_Handler   /* Reserved */ 
def_rewritable_handler  _SVCall_Handler             /* SVCALL Handler */
def_rewritable_handler  _PendSV_Handler          /* PENDSV Handler */
def_rewritable_handler  _SysTick_Handler         /* SYSTICK Handler */ 
def_rewritable_handler  _DebugMonitor_Handler /* Reserved */ 
def_rewritable_handler  _WWDG_IRQHandler            /* WWDG_IRQHandler */
def_rewritable_handler  _PVD_IRQHandler             /* PVD_IRQHandler */
def_rewritable_handler  _TAMPER_IRQHandler          /* TAMPER_IRQHandler */
def_rewritable_handler  _RTC_IRQHandler             /* RTC_IRQHandler */
def_rewritable_handler  _FLASH_IRQHandler           /* FLASH_IRQHandler */
def_rewritable_handler  _RCC_IRQHandler             /* RCC_IRQHandler */
def_rewritable_handler  _EXTI0_IRQHandler           /* EXTI0_IRQHandler */
def_rewritable_handler  _EXTI1_IRQHandler           /* EXTI1_IRQHandler */
def_rewritable_handler  _EXTI2_IRQHandler           /* EXTI2_IRQHandler */
def_rewritable_handler  _EXTI3_IRQHandler           /* EXTI3_IRQHandler */
def_rewritable_handler  _EXTI4_IRQHandler           /* EXTI4_IRQHandler */
def_rewritable_handler  _DMA1_Channel1_IRQHandler   /* DMA1_Channel1_IRQHandler */
def_rewritable_handler  _DMA1_Channel2_IRQHandler   /* DMA1_Channel2_IRQHandler */
def_rewritable_handler  _DMA1_Channel3_IRQHandler   /* DMA1_Channel3_IRQHandler */
def_rewritable_handler  _DMA1_Channel4_IRQHandler   /* DMA1_Channel4_IRQHandler */
def_rewritable_handler  _DMA1_Channel5_IRQHandler   /* DMA1_Channel5_IRQHandler */
def_rewritable_handler  _DMA1_Channel6_IRQHandler   /* DMA1_Channel6_IRQHandler */
def_rewritable_handler  _DMA1_Channel7_IRQHandler   /* DMA1_Channel7_IRQHandler */
def_rewritable_handler  _ADC1_2_IRQHandler          /* ADC1_2_IRQHandler */
def_rewritable_handler  _USB_HP_CAN1_TX_IRQHandler  /* USB_HP_CAN1_TX_IRQHandler */
def_rewritable_handler  _USB_LP_CAN1_RX0_IRQHandler /* USB_LP_CAN1_RX0_IRQHandler */
def_rewritable_handler  _CAN1_RX1_IRQHandler        /* CAN1_RX1_IRQHandler */
def_rewritable_handler  _CAN1_SCE_IRQHandler        /* CAN1_SCE_IRQHandler */
def_rewritable_handler  _EXTI9_5_IRQHandler         /* EXTI9_5_IRQHandler */
def_rewritable_handler  _TIM1_BRK_IRQHandler        /* TIM1_BRK_IRQHandler */
def_rewritable_handler  _TIM1_UP_IRQHandler         /* TIM1_UP_IRQHandler */
def_rewritable_handler  _TIM1_TRG_COM_IRQHandler    /* TIM1_TRG_COM_IRQHandler */
def_rewritable_handler  _TIM1_CC_IRQHandler         /* TIM1_CC_IRQHandler */
def_rewritable_handler  _TIM2_IRQHandler            /* TIM2_IRQHandler */
def_rewritable_handler  _TIM3_IRQHandler            /* TIM3_IRQHandler */
def_rewritable_handler  _I2C1_EV_IRQHandler         /* I2C1_EV_IRQHandler */
def_rewritable_handler  _I2C1_ER_IRQHandler         /* I2C1_ER_IRQHandler */
def_rewritable_handler  _SPI1_IRQHandler            /* SPI1_IRQHandler */
def_rewritable_handler  _USART1_IRQHandler          /* USART1_IRQHandler */
def_rewritable_handler  _USART2_IRQHandler          /* USART2_IRQHandler */
def_rewritable_handler  _EXTI15_10_IRQHandler       /* EXTI15_10_IRQHandler */
def_rewritable_handler  _RTCAlarm_IRQHandler        /* RTCAlarm_IRQHandler */
def_rewritable_handler  _USBWakeUp_IRQHandler       /* USBWakeUp_IRQHandler */

        .end 
