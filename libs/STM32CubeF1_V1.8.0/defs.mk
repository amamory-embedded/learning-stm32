# the name of the executable or lib file
PROJECT_NAME = libSTM32CubeF1

# when the flag -Os is removed, as in debug mode, the compilation fails with these two error:
#  CC      Libraries/CMSIS/CM3/CoreSupport/core_cm3.c
#/tmp/ccPyyafK.s: Assembler messages:
#/tmp/ccPyyafK.s:912: Error: registers may not be the same -- `strexb r2,r2,[r3]'
#/tmp/ccPyyafK.s:962: Error: registers may not be the same -- `strexh r2,r2,[r3]'
#
# I had to apply a fix in the file Libraries/CMSIS/CM3/CoreSupport/core_cm3.c, lines 736
#   __ASM volatile ("strexb %0, %2, [%1]" : "=&r" (result) : "r" (addr), "r" (value) );
# and 755
#   __ASM volatile ("strexh %0, %2, [%1]" : "=&r" (result) : "r" (addr), "r" (value) );
#As suggested in https://github.com/texane/stlink/issues/65 and https://gist.github.com/timbrom/1942280
#It is necessary to replace '=r (result)' by '=&r (result)' in both cases.

# static libs dont need statup file. so live it empty
DEVICE_STARTUP = ./Drivers/CMSIS/Device/ST/STM32F1xx/Source/Templates/gcc/startup_stm32f103x6.s

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