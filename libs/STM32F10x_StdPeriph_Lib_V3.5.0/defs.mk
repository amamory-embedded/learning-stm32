###############################################################################
#
# Makefile for compiling STM32F1xx devices, specially, STM32F103C8T6 or bluepill
# Copyright (C) 2020 Alexandre Amory <amamory@gmail.com>
#
###############################################################################
# RELEVANT VARIABLES:
#
# These are the definitions to compile the libStdPeriph static library.
# To compile it, open a terminal in this current dir and type:
#
#   $ make ../../config/common.mk lib
#
# If you wish to create a debug version of this lib, then type:
#
#   $ make ../../config/common.mk lib DEBUG=1
#
###############################################################################

#https://gist.github.com/xuhdev/1873316

# setting conditional
#DEVICE = STM32F103x8
#FLASH  = 0x08000000

# does this lib depends on other libs or low level API ?
#USE_ST_CMSIS = true
#USE_ST_HAL   = true

# the name of the executable or lib file
PROJECT_NAME = libStdPeriph

# static libs dont need statup file. so live it empty
# Libraries/CMSIS/CM3/DeviceSupport/ST/STM32F10x/startup/arm
DEVICE_STARTUP =

LINK_SCRIPT =

# insert here the lib's include dirs
INCLUDE_DIRS += ./Libraries/CMSIS/CM3/CoreSupport
INCLUDE_DIRS += ./Libraries/CMSIS/CM3/DeviceSupport/ST/STM32F10x
INCLUDE_DIRS += ./Libraries/STM32F10x_StdPeriph_Driver/inc
INCLUDE_DIRS += .

# insert here the dir to any required library
LIBRARY_DIRS +=

# insert here the C source file list
SRC ?=
SRC += ./Libraries/CMSIS/CM3/CoreSupport/*.c
SRC += ./Libraries/CMSIS/CM3/DeviceSupport/ST/STM32F10x/*.c
SRC += ./Libraries/STM32F10x_StdPeriph_Driver/src/*.c
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
DDEFS += -DSTM32F10X_MD -DUSE_STDPERIPH_DRIVER -DHSE_VALUE=8000000 -DRUN_FROM_FLASH=1

# insert the max size of the stack. the -Wstack-usage flag will make sure that this limit is not hit
STACK_SIZE = 255

# add here any additional flags for compilation and linking
AS_FLAGS  +=
CP_FLAGS  +=
#enables a base set of warnings generally agreed upon as being useful
CP_FLAGS += -Wall
#enables an additional set of flags not covered by -Wall
CP_FLAGS += -Wextra
#causes all enabled warnings to cause compilation errors.
CP_FLAGS += -Werror
CXX_FLAGS +=
LD_FLAGS  +=