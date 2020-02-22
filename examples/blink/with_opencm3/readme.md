readme.md

cd libs/libopencm3
make lib TARGETS=stm32/f1
cd ../../examples/blink/with_opencm3
make -f ../../../config/common.mk all
make -f ../../../config/common.mk flash
