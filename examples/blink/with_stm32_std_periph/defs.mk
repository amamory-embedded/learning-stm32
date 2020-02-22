# the name of the executable or lib file
PROJECT_NAME = main

LEARNING_STM32 = /home/lsa/stm32/learning-stm32

# static libs dont need statup file. so live it empty
#DEVICE_STARTUP = $(LEARNING_STM32)/ld/startup_stm32f10x_md.s

#LINK_SCRIPT = $(LEARNING_STM32)/ld/stm32f103x8.ld

# insert here the lib's include dirs
INCLUDE_DIRS += $(LEARNING_STM32)/libs/STM32F10x_StdPeriph_Lib_V3.5.0/Libraries/CMSIS/CM3/CoreSupport
INCLUDE_DIRS += $(LEARNING_STM32)/libs/STM32F10x_StdPeriph_Lib_V3.5.0/Libraries/CMSIS/CM3/DeviceSupport/ST/STM32F10x
INCLUDE_DIRS += $(LEARNING_STM32)/libs/STM32F10x_StdPeriph_Lib_V3.5.0/Libraries/STM32F10x_StdPeriph_Driver/inc
INCLUDE_DIRS += $(LEARNING_STM32)/libs/STM32F10x_StdPeriph_Lib_V3.5.0/.

# insert here the dir to any required library
LIBRARY_DIRS += $(LEARNING_STM32)/libs/STM32F10x_StdPeriph_Lib_V3.5.0/
LIBRARY_DIRS += $(LEARNING_STM32)/ld

# insert here the names of the required library
LIBRARY_NAMES += StdPeriph

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
DDEFS += -DSTM32F10X_MD -DUSE_STDPERIPH_DRIVER -DHSE_VALUE=8000000 -DRUN_FROM_FLASH=1


# add here any additional flags for compilation and linking
AS_FLAGS  +=
CP_FLAGS  +=
CXX_FLAGS +=
LD_FLAGS  +=