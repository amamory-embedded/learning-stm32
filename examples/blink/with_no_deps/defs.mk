# the name of the executable or lib file
PROJECT_NAME = main

LEARNING_STM32 = /home/lsa/stm32/learning-stm32

# startup file and linker script
DEVICE_STARTUP =
LINK_SCRIPT = ./linker_script.ld

# insert here the lib's include dirs
INCLUDE_DIRS ?=

# insert here the dir to any required library
LIBRARY_DIRS +=

# insert here the names of the required library
LIBRARY_NAMES +=

# insert here the C source file list
SRC ?=
#SRC += $(LEARNING_STM32)/libs/STM32CubeF1_V1.8.0/Drivers/CMSIS/Device/ST/STM32F1xx/Source/Templates/*.c
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

# add here any additional flags for compilation and linking
AS_FLAGS  +=
CP_FLAGS  +=
CXX_FLAGS +=
LD_FLAGS  += -nostdlib
# this option must be commented because it eliminates too much code
#LD_FLAGS  += -Xlinker --gc-sections ## Perform dead-code elimination
