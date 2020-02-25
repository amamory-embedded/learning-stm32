# the name of the executable or lib file
PROJECT_NAME = main

LEARNING_STM32 = /home/lsa/stm32/learning-stm32

# startup file and linker script
DEVICE_STARTUP = ./startup_stm32f103x6.s
LINK_SCRIPT = ./STM32F103X6_FLASH.ld

# insert here the lib's include dirs
INCLUDE_DIRS += $(LEARNING_STM32)/libs/STM32CubeF1_V1.8.0/Drivers/CMSIS/Core/Include
INCLUDE_DIRS += $(LEARNING_STM32)/libs/STM32CubeF1_V1.8.0/Drivers/CMSIS/Device/ST/STM32F1xx/Include
INCLUDE_DIRS += $(LEARNING_STM32)/libs/STM32CubeF1_V1.8.0/Drivers/STM32F1xx_HAL_Driver/Inc

# insert here the dir to any required library
LIBRARY_DIRS += $(LEARNING_STM32)/libs/STM32CubeF1_V1.8.0/

# insert here the names of the required library
LIBRARY_NAMES += STM32CubeF1

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
DDEFS += -DHSE_VALUE=8000000 -DSTM32F1 -DUSE_HAL_DRIVER -DSTM32F103x6

# add here any additional flags for compilation and linking
AS_FLAGS  +=
CP_FLAGS  +=
CXX_FLAGS +=
LD_FLAGS  +=
LD_FLAGS  += -Xlinker --gc-sections ## Perform dead-code elimination
