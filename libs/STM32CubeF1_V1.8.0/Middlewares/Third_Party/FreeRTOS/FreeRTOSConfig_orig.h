/*
this is the FreeRTOSConfig.h file recommended by STM, as described in the doc
Developing applications on STM32Cube with RTOS - UM1722
*/
/* Ensure stdint is only used by the compiler, and not the assembler. */
#if defined(__ICCARM__) || defined(__CC_ARM) || defined(__GNUC__)
	#include <stdint.h>
	extern uint32_t SystemCoreClock;
#endif
#define configUSE_PREEMPTION 			1
#define configUSE_IDLE_HOOK 			0
#define configUSE_TICK_HOOK 			0
#define configCPU_CLOCK_HZ 				( SystemCoreClock )
#define configTICK_RATE_HZ 				( ( portTickType ) 1000 )
//#define configMAX_PRIORITIES 			( ( unsigned portBASE_TYPE ) 7 )
#define configMAX_PRIORITIES 			(  7 )
#define configMINIMAL_STACK_SIZE 		( ( unsigned short ) 128 )
#define configTOTAL_HEAP_SIZE 			( ( size_t ) ( 15 * 1024 ) )
#define configMAX_TASK_NAME_LEN 		( 16 )
#define configUSE_TRACE_FACILITY 		1
#define configUSE_16_BIT_TICKS 			0
#define configIDLE_SHOULD_YIELD 		1
#define configUSE_MUTEXES 				1
#define configQUEUE_REGISTRY_SIZE 		8
#define configCHECK_FOR_STACK_OVERFLOW 	0
#define configUSE_RECURSIVE_MUTEXES 	1
#define configUSE_MALLOC_FAILED_HOOK 	0
#define configUSE_APPLICATION_TASK_TAG 	0
#define configUSE_COUNTING_SEMAPHORES 	1
/* Cortex-M specific definitions. */
#ifdef __NVIC_PRIO_BITS
	/* __BVIC_PRIO_BITS will be specified when CMSIS is being used. */
	#define configPRIO_BITS __NVIC_PRIO_BITS
#else
	#define configPRIO_BITS 4 /* 15 priority levels */
#endif
/* The lowest interrupt priority that can be used in a call to a "set priority"
function. */
#define configLIBRARY_LOWEST_INTERRUPT_PRIORITY 0xf
/* The highest interrupt priority that can be used by any interrupt service
routine that makes calls to interrupt safe FreeRTOS API functions */
#define configLIBRARY_MAX_SYSCALL_INTERRUPT_PRIORITY 5
/* Interrupt priorities used by the kernel port layer itself. These are generic
to all Cortex-M ports, and do not rely on any particular library functions. */
#define configKERNEL_INTERRUPT_PRIORITY (configLIBRARY_LOWEST_INTERRUPT_PRIORITY << (8 - configPRIO_BITS) )
#define configMAX_SYSCALL_INTERRUPT_PRIORITY (configLIBRARY_MAX_SYSCALL_INTERRUPT_PRIORITY << (8 - configPRIO_BITS) )
/* Definitions that map the FreeRTOS port interrupt handlers to their CMSIS
standard names. */
#define vPortSVCHandler SVC_Handler
#define xPortPendSVHandler PendSV_Handler
/* IMPORTANT: This define MUST be commented when used with STM32Cube firmware,
to prevent overwriting SysTick_Handler defined within STM32Cube HAL
*/
/* #define xPortSysTickHandler SysTick_Handler */