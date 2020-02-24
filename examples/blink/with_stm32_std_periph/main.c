#include "stm32f10x.h"
#include "stm32f10x_rcc.h"
#include "stm32f10x_gpio.h"

// Quick and dirty delay
void delay(){
    for (int i=0; i<1000000; i++) {
        __asm__("nop");
    }
}

void init_led(void)
{
    GPIO_InitTypeDef GPIO_InitStructure;

    /* Enable GPIO C clock. */
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOC, ENABLE);

    /* Set the LED pin state such that the LED is off.  The LED is connected
     * between power and the microcontroller pin, which makes it turn on when
     * the pin is low.
     */
    GPIO_WriteBit(GPIOC,GPIO_Pin_13,Bit_SET);

    /* Configure the LED pin as push-pull output. */
    GPIO_StructInit(&GPIO_InitStructure);
    GPIO_InitStructure.GPIO_Pin =  GPIO_Pin_13;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz;
    GPIO_Init(GPIOC, &GPIO_InitStructure);
}

int main(void)
{
    init_led();

    while(1) {
       GPIO_WriteBit(GPIOC, GPIO_Pin_13,Bit_SET);
       delay();
       GPIO_WriteBit(GPIOC, GPIO_Pin_13,Bit_RESET);
       delay();
    }
}
