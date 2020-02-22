readme.md

cd libs/STM32CubeF1_V1.8.0
make -f ../../config/common.mk lib
cd ../../examples/blink/with_stm32_cubef1
make -f ../../../config/common.mk all
make -f ../../../config/common.mk flash

