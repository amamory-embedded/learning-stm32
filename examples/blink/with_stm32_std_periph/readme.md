readme.md

## STM32 Standard Peripheral Libraries

-[Standard Peripheral Library](https://www.st.com/content/st_com/en/products/embedded-software/mcu-mpu-embedded-software/stm32-embedded-software/stm32-standard-peripheral-libraries/stsw-stm32054.html)
-[Std Periph in github](https://github.com/nematix/stm32f10x-stdperiph-lib)
-[Standard Peripheral Library Expansion](https://www.st.com/en/embedded-software/stm32-standard-peripheral-library-expansion.html): A collection of embedded software libraries running on top of the std periph lib. If you are still learning, you wont probably need this


https://github.com/nematix/stm32f10x-stdperiph-lib
http://www.longlandclan.yi.org/~stuartl/stm32f10x_stdperiph_lib_um/index.html

cd libs/STM32F10x_StdPeriph_Lib_V3.5.0
make -f ../../config/common.mk lib
cd ../../examples/blink/with_stm32_std_periph
make -f ../../../config/common.mk all
make -f ../../../config/common.mk flash