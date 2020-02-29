###############################################################################
#
# Makefile for compiling STM32F1xx devices, specially, STM32F103C8T6 or bluepill
# Copyright (C) 2020 Alexandre Amory <amamory@gmail.com>
#
###############################################################################
# RELEVANT VARIABLES:
#
# These are the definitions required by any app using libopencm3. To use it,
# just add the following line in the app's def.mk file
#
#   USE_MODULE += opencm3
#
###############################################################################

# startup file and linker script
DEVICE_STARTUP =
LINK_SCRIPT = $(LEARNING_STM32)/libs/libopencm3/lib/stm32/f1/stm32f103x8.ld

# insert here the lib's include dirs
INCLUDE_DIRS += $(LEARNING_STM32)/libs/libopencm3/include

# insert here the dir to any required library
LIBRARY_DIRS += $(LEARNING_STM32)/libs/libopencm3/lib

# insert here the names of the required library
LIBRARY_NAMES += opencm3_stm32f1

# insert here the lib's scpecific defines
DDEFS += -DSTM32F1

# add here any additional flags for compilation and linking
AS_FLAGS  +=
CP_FLAGS  +=
CXX_FLAGS +=
# No standard lib startup files
LD_FLAGS  += -nostartfiles
LD_FLAGS  += -nostdlib
## Perform dead-code elimination
LD_FLAGS  += -Xlinker --gc-sections
