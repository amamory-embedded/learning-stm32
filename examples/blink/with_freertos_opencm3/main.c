// source based on https://github.com/WRansohoff/min_freertos_blink/blob/master/src/main.cpp
#include "stm32f1xx.h"
#include "FreeRTOS.h"
#include "task.h"
#include "croutine.h"

// Quick and dirty delay
void delay(){
    for (int i=0; i<1000000; i++) {
        __asm__("nop");
    }
}

// 'Blink LED' task.
static void led_task(void *args) {
  int delay_ms = *(int*)args;

  while (1) {
    // Toggle the LED.
    // Reset the state of pin 13 to output low
    GPIOC->BSRR = GPIO_BSRR_BS13;
    delay();
    // Set the state of pin 13 to output high
    GPIOC->BRR = GPIO_BSRR_BS13;
    delay();
    // Delay for a second-ish.
    vTaskDelay(pdMS_TO_TICKS(delay_ms));
  };
}

void led_setup() {
    // Turn on the GPIOC peripheral
    RCC->APB2ENR |= RCC_APB2ENR_IOPCEN;
    // Put pin 13 in general purpose push-pull mode
    GPIOC->CRH &= ~(GPIO_CRH_CNF13);
    // Set the output mode to max. 2MHz
    GPIOC->CRH |= GPIO_CRH_MODE13_1;
}

// LED delay timings.
const int led_delay_1 = 1111;
const int led_delay_2 = 500;

int main (void) {
    led_setup();

    // Create the LED tasks.
    xTaskCreate(led_task, "LED_blink_1", 128, (void*)&led_delay_1, configMAX_PRIORITIES-1, NULL);
    xTaskCreate(led_task, "LED_blink_2", 128, (void*)&led_delay_2, configMAX_PRIORITIES-1, NULL);
    // Start the scheduler.
    vTaskStartScheduler();

  // This should never be reached; the FreeRTOS scheduler
  // should be in charge of the program's execution after starting.
  while (1) {}
  return 0;
}
