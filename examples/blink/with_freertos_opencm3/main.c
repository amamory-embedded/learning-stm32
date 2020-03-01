// source based on https://github.com/WRansohoff/min_freertos_blink/blob/master/src/main.cpp
#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>
#include "FreeRTOS.h"
#include "task.h"
#include "croutine.h"

// 'Blink LED' task.
static void led_task(void *args) {
  int delay_ms = *(int*)args;

  while (1) {
    // Toggle the LED.
    // Reset the state of pin 13 to output low
    gpio_toggle(GPIOC, GPIO13);
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
    xTaskCreate(led_task, "LED_blink_2", 128, (void*)&led_delay_2, configMAX_PRIORITIES-1, NULL);
    // Start the scheduler.
    vTaskStartScheduler();

  // This should never be reached; the FreeRTOS scheduler
  // should be in charge of the program's execution after starting.
  while (1) {}
  return 0;
}
