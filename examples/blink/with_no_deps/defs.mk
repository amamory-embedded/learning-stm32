###############################################################################
#
# Makefile for compiling STM32F1xx devices, specially, STM32F103C8T6 or bluepill
# Copyright (C) 2020 Alexandre Amory <amamory@gmail.com>
#
###############################################################################
# RELEVANT VARIABLES:
#
# Insert here only the defitions strictly related to the application itself.
# Do not add here definitions required by lower level libs. These lib's definitions
# are already defined in  $LEARNING_STM32/config/<lib_name>.mk
#
# The following variable at the end of this file informs the app's depedency.
# For example:
#
#   USE_MODULE += opencm3
#
###############################################################################

# the name of the executable or lib file
PROJECT_NAME = main

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
# This tells GCC to ignore everything it knows about where to find header files and libraries and instead uses what you tell it
# it does not include  crtbegin.o, crt1.o, crti.o, crtend.o, crtn.o
# http://cs107e.github.io/guides/gcc/
LD_FLAGS  += -nostdlib
# The -ffreestanding option also directs the compiler to not assume that standard functions have their usual definitions.
# this option must be commented because it eliminates too much code
#LD_FLAGS  += -Xlinker --gc-sections ## Perform dead-code elimination
