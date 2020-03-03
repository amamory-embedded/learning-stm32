# Variations of a blinking LED

This is the first step of any embedded programmer. Why would I skip it if it works for lots of people ? In the beginning, this can seem to be too trivial, but believe me when I say there are plenty of lessons to be learned from a blinking LED.

First, you get to test for the first time your device, your programming cable, the programming environment, and the setup of libraries. This initial setup takes quite a lot of time from a beginner. However, once you make a template design, you can only copy the directory. Within a few minutes, you have another environment for another project.

Second, and most important of all, it turns out that there are SEVERAL different ways to make an LED blink. I don't only say that there are different sequences of commands to have a blinking LED. There are also several abstractions levels to work with. The higher the abstraction level, the quicker you have your LED blinking. However, you pay in memory usage and performance, which is not a big issue for a blinking LED. But it an excellent opportunity to know more about what happens underneath the abstraction layers.

Since we are assuming that the reader is familiar with the Arduino programming environment and APIs, we are going to start from that until the Assembly version of the blinking LED. The following list of versions of the blinking LED is not exhaustive, but I believe it is enough to introduce several different pieces of relevant software in terms of embedded software.

- [STM32duino](./with_arduino/readme.md)
- [Standard Peripheral Libraries](./with_stm32_std_periph/readme.md)
- [Libopencm3](./with_opencm3/readme.md)
- [CMSIS only](./with_cmsis/readme.md)
- [CMSIS and HAL](./with_stm32_cubef1/readme.md)
- [Bare-metal C](./with_no_deps/readme.md)
- [Freertos](./with_freertos/readme.md)
- [Freertos with OpenCM3](./with_freertos_opencm3/readme.md)

To be done:
- [Assembly]()
- [Zephyr]()
- [RIOT]()
  
[//]: # (
Zephyr
https://github.com/zephyrproject-rtos/zephyr/tree/master/boards/arm/qemu_cortex_m3
https://docs.zephyrproject.org/latest/boards/arm/stm32_min_dev/doc/index.html
)