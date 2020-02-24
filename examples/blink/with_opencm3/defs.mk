# the name of the executable or lib file
PROJECT_NAME = main

LEARNING_STM32 = /home/lsa/stm32/learning-stm32

# startup file and linker script
DEVICE_STARTUP =
LINK_SCRIPT = ./stm32f103x8.ld

# insert here the lib's include dirs
INCLUDE_DIRS += $(LEARNING_STM32)/libs/libopencm3/include

# insert here the dir to any required library
LIBRARY_DIRS += $(LEARNING_STM32)/libs/libopencm3/lib

# insert here the names of the required library
LIBRARY_NAMES += opencm3_stm32f1

# insert here the C source file list
SRC ?=
SRC += ./*.c
# you can also add cpp files
#SRC += ./*.cpp

# insert here the ASM source list
ASM_SRC ?=
ASM_SRC +=

# or you can use somthing more generic, like this following line
#SRC := $(shell find $(SRC_DIRS) -name *.cpp -or -name *.c -or -name *.s)

# insert here the lib's scpecific defines
DDEFS ?=
DDEFS += -DSTM32F1

# add here any additional flags for compilation and linking
AS_FLAGS  +=
CP_FLAGS  +=
CXX_FLAGS +=
LD_FLAGS  += -nostartfiles
