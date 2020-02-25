# the name of the executable or lib file
PROJECT_NAME = libSTM32CubeF1

# static libs dont need statup file. so live it empty
# Libraries/CMSIS/CM3/DeviceSupport/ST/STM32F10x/startup/arm
DEVICE_STARTUP = ./Drivers/CMSIS/Device/ST/STM32F1xx/Source/Templates/gcc/startup_stm32f103x6.s
#DEVICE_STARTUP =

LINK_SCRIPT =

# insert here the lib's include dirs
INCLUDE_DIRS += ./Drivers/CMSIS/Core/Include
INCLUDE_DIRS += ./Drivers/CMSIS/Device/ST/STM32F1xx/Include
INCLUDE_DIRS += ./Drivers/STM32F1xx_HAL_Driver/Inc
#INCLUDE_DIRS += ./Middlewares/Third_Party/FreeRTOS/
#INCLUDE_DIRS += ./Middlewares/Third_Party/FreeRTOS/Source/include/
#INCLUDE_DIRS += ./Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM3

# insert here the dir to any required library
LIBRARY_DIRS +=

# insert here the C source file list
SRC ?=
SRC += ./Drivers/CMSIS/Device/ST/STM32F1xx/Source/Templates/*.c
SRC += ./Drivers/STM32F1xx_HAL_Driver/Src/*.c
#SRC += ./Middlewares/Third_Party/FreeRTOS/Source/*.c
#SRC += ./Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM3/*.c
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
#CP_FLAGS += -Werror
CXX_FLAGS +=
LD_FLAGS  +=