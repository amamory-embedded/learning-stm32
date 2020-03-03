readme.md

[CMSIS and HAL](https://www.st.com/en/embedded-software/stm32cubef1.html) by STM
https://github.com/STMicroelectronics/stm32f1xx_hal_driver
https://github.com/STMicroelectronics/cmsis_device_f1/
https://github.com/STMicroelectronics/STM32CubeF1
Description of STM32F1 HAL and low-layer drivers - UM1850

https://github.com/platformio/platform-ststm32/blob/master/examples/stm32cube-hal-blink/src/main.c


```sh
make all
make flash
```

cd libs/STM32CubeF1_V1.8.0
make -f ../../config/common.mk lib
cd ../../examples/blink/with_stm32_cubef1
make -f ../../../config/common.mk all
make -f ../../../config/common.mk flash

open startup_stm32f103x6.s and comment the line 95
'''
/*bl __libc_init_array*/
'''

This will remove this dependency with libc, allowing to compile the desing with the flags -nostartfiles and -nostdlib,
saving some memory. Note that the objects crti.o, crtn.o lib_a-memset.o crtbegin.o are not references anymore.


