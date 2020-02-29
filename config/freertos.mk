###############################################################################
#
# Makefile for compiling STM32F1xx devices, specially, STM32F103C8T6 or bluepill
# Copyright (C) 2020 Alexandre Amory <amamory@gmail.com>
#
###############################################################################
# RELEVANT VARIABLES:
#
# These are the definitions required by any app using freertos. To use it,
# just add the following line in the app's def.mk file
#
#   USE_MODULE += freertos
#
# This FreeRTOS definition uses the minimal definitions from CMSIS
###############################################################################

# startup file and linker script
DEVICE_STARTUP = $(LEARNING_STM32)/libs/STM32CubeF1_V1.8.0/./Drivers/CMSIS/Device/ST/STM32F1xx/Source/Templates/gcc/startup_stm32f103x6.s
LINK_SCRIPT = $(LEARNING_STM32)/libs/STM32CubeF1_V1.8.0/./Drivers/CMSIS/Device/ST/STM32F1xx/Source/Templates/gcc/linker/STM32F103X6_FLASH.ld

# insert here the lib's include dirs
INCLUDE_DIRS += $(LEARNING_STM32)/libs/STM32CubeF1_V1.8.0/Drivers/CMSIS/Core/Include
INCLUDE_DIRS += $(LEARNING_STM32)/libs/STM32CubeF1_V1.8.0/Drivers/CMSIS/Device/ST/STM32F1xx/Include
INCLUDE_DIRS += $(LEARNING_STM32)/libs/STM32CubeF1_V1.8.0/Drivers/STM32F1xx_HAL_Driver/Inc
INCLUDE_DIRS += $(LEARNING_STM32)/libs/STM32CubeF1_V1.8.0/Middlewares/Third_Party/FreeRTOS/
INCLUDE_DIRS += $(LEARNING_STM32)/libs/STM32CubeF1_V1.8.0/Middlewares/Third_Party/FreeRTOS/Source/include/
INCLUDE_DIRS += $(LEARNING_STM32)/libs/STM32CubeF1_V1.8.0/Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM3/
INCLUDE_DIRS += $(LEARNING_STM32)/libs/STM32CubeF1_V1.8.0/Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS_V2/

# insert here the dir to any required library
LIBRARY_DIRS += $(LEARNING_STM32)/libs/STM32CubeF1_V1.8.0/

# insert here the names of the required library
LIBRARY_NAMES += STM32CubeF1

# insert here the lib's scpecific defines
DDEFS += -DHSE_VALUE=8000000 -DSTM32F1 -DUSE_HAL_DRIVER -DSTM32F103x6

# add here any additional flags for compilation and linking
AS_FLAGS  +=
CP_FLAGS  +=
CXX_FLAGS +=
LD_FLAGS  +=
# This tells GCC to ignore everything it knows about where to find header files and libraries and instead uses what you tell it
# it does not include  crtbegin.o, crt1.o, crti.o, crtend.o, crtn.o
# http://cs107e.github.io/guides/gcc/
LD_FLAGS  += -nostdlib
## Perform dead-code elimination
LD_FLAGS  += -Xlinker --gc-sections
