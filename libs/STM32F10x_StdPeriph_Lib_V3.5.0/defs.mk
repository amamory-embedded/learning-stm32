
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


# add here any additional flags for compilation and linking
AS_FLAGS  +=
CP_FLAGS  +=
CXX_FLAGS +=
LD_FLAGS  +=