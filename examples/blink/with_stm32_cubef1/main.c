#include "stm32f1xx.h"

// Quick and dirty delay
void delay(){
    for (int i=0; i<1000000; i++) {
        __asm__("nop");
    }
}

int main (void) {
    // Turn on the GPIOC peripheral
    RCC->APB2ENR |= RCC_APB2ENR_IOPCEN;

    // Put pin 13 in general purpose push-pull mode
    GPIOC->CRH &= ~(GPIO_CRH_CNF13);
    // Set the output mode to max. 2MHz
    GPIOC->CRH |= GPIO_CRH_MODE13_1;

    while (1) {
        // Reset the state of pin 13 to output low
        GPIOC->BSRR = GPIO_BSRR_BR13;

        delay();

        // Set the state of pin 13 to output high
        GPIOC->BSRR = GPIO_BSRR_BS13;

        delay();
    }

    // Return 0 to satisfy compiler
    return 0;
}
