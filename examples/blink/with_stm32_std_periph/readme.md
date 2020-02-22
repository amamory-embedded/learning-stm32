readme.md

cd libs/STM32F10x_StdPeriph_Lib_V3.5.0
make -f ../../config/common.mk lib
cd ../../examples/blink/with_stf_periph
make -f ../../../config/common.mk all
make -f ../../../config/common.mk flash