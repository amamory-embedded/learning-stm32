/*
// source based on https://github.com/WRansohoff/min_freertos_blink/blob/master/src/main.cpp
#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>
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
    gpio_toggle(GPIOC, GPIO13);
    delay();

    // Delay for a second-ish.
    vTaskDelay(pdMS_TO_TICKS(delay_ms));
  };
}

void led_setup() {
    // First, let's ensure that our clock is running off the high-speed
    // internal oscillator (HSI) at 48MHz
    rcc_clock_setup_in_hsi_out_48mhz();

    // Since our LED is on GPIO bank A, we need to enable
    // the peripheral clock to this GPIO bank in order to use it.
    rcc_periph_clock_enable(RCC_GPIOC);

    // Our test LED is connected to Port A pin 11, so let's set it as output
    gpio_set_mode(GPIOC, GPIO_MODE_OUTPUT_2_MHZ,
              GPIO_CNF_OUTPUT_PUSHPULL, GPIO13);
}

// LED delay timings.
const int led_delay_1 = 1111;
const int led_delay_2 = 500;

int main (void) {
    led_setup();

    // Create the LED tasks.
    xTaskCreate(led_task, "LED_blink_1", 128, (void*)&led_delay_1, configMAX_PRIORITIES-1, NULL);
    //xTaskCreate(led_task, "LED_blink_2", 128, (void*)&led_delay_2, configMAX_PRIORITIES-1, NULL);
    // Start the scheduler.
    vTaskStartScheduler();

  // This should never be reached; the FreeRTOS scheduler
  // should be in charge of the program's execution after starting.
  while (1) {}
  return 0;
}

*/

//#include <stdlib.h>
//https://github.com/dimtass/stm32f103-cmake-template/blob/master/source/src_freertos/main.c
#include <FreeRTOS.h>
#include <task.h>

#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>

int k = 0;

void task_blink(void *args __attribute__((unused)))
{
    while (1)
    {
        gpio_toggle(GPIOC, GPIO13);
        vTaskDelay(pdMS_TO_TICKS(500));
    }
}

int main(void)
{
    rcc_clock_setup_in_hse_8mhz_out_72mhz();
    rcc_periph_clock_enable(RCC_GPIOC);
    gpio_set_mode(GPIOC, GPIO_MODE_OUTPUT_2_MHZ, GPIO_CNF_OUTPUT_PUSHPULL, GPIO13);
    //gpio_set(GPIOC, GPIO13); // Turn off

    //int *test_var = malloc(sizeof(int));
    //*test_var = 5;

    xTaskCreate(task_blink, "blink", 100, NULL, configMAX_PRIORITIES - 1, NULL);
    vTaskStartScheduler();

    while (1);
    return 0;
}