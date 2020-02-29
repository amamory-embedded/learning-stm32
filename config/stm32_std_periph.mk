###############################################################################
#
# Makefile for compiling STM32F1xx devices, specially, STM32F103C8T6 or bluepill
# Copyright (C) 2020 Alexandre Amory <amamory@gmail.com>
#
###############################################################################
# RELEVANT VARIABLES:
#
# These are the definitions required by any app using stm32_std_periph. To use it,
# just add the following line in the app's def.mk file
#
#   USE_MODULE += stm32_std_periph
#
###############################################################################

# startup and linker script files
DEVICE_STARTUP = $(LEARNING_STM32)/libs/STM32F10x_StdPeriph_Lib_V3.5.0/Libraries/CMSIS/CM3/DeviceSupport/ST/STM32F10x/startup/gcc_ride7/startup_stm32f10x_md.s
LINK_SCRIPT = $(LEARNING_STM32)/libs/STM32F10x_StdPeriph_Lib_V3.5.0/stm32_flash.ld

# insert here the lib's include dirs
INCLUDE_DIRS += $(LEARNING_STM32)/libs/STM32F10x_StdPeriph_Lib_V3.5.0/Libraries/CMSIS/CM3/CoreSupport
INCLUDE_DIRS += $(LEARNING_STM32)/libs/STM32F10x_StdPeriph_Lib_V3.5.0/Libraries/CMSIS/CM3/DeviceSupport/ST/STM32F10x
INCLUDE_DIRS += $(LEARNING_STM32)/libs/STM32F10x_StdPeriph_Lib_V3.5.0/Libraries/STM32F10x_StdPeriph_Driver/inc
INCLUDE_DIRS += $(LEARNING_STM32)/libs/STM32F10x_StdPeriph_Lib_V3.5.0/.

# insert here the dir to any required library
LIBRARY_DIRS += $(LEARNING_STM32)/libs/STM32F10x_StdPeriph_Lib_V3.5.0/

# insert here the names of the required library
LIBRARY_NAMES += StdPeriph

# insert here the lib's scpecific defines
DDEFS += -DSTM32F10X_MD -DUSE_STDPERIPH_DRIVER -DHSE_VALUE=8000000 -DRUN_FROM_FLASH=1

# add here any additional flags for compilation and linking
AS_FLAGS  +=
CP_FLAGS  +=
CXX_FLAGS +=
LD_FLAGS  +=
# No standard lib startup files
LD_FLAGS  += -nostdlib
LD_FLAGS  += -Xlinker --gc-sections ## Perform dead-code elimination
# shows the removed sections. uncommnet it just if you want the investigate the removed sections
#LD_FLAGS += -Xlinker --print-gc-sections