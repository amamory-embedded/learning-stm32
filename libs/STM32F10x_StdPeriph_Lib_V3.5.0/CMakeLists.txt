# CMake minimum version
cmake_minimum_required (VERSION 3.1)

# Set include path
include_directories( Libraries/CMSIS/CM3/CoreSupport )
include_directories( Libraries/CMSIS/CM3/DeviceSupport/ST/STM32F10x )
include_directories( Libraries/STM32F10x_StdPeriph_Driver/inc )

# The need build source path and build all files
#aux_source_directory (STM32F10x_StdPeriph_Driver/src DIR_STM32F10x_StdPeriph_Driver_SRCS)

# The need build source path and build all files
aux_source_directory (Libraries/CMSIS/CM3/CoreSupport Libraries/CMSIS/CM3/DeviceSupport/ST/STM32F10x Libraries/STM32F10x_StdPeriph_Driver/src DIR_STM32F10x_StdPeriph_Driver_SRCS)

# Select the startup file according to the compiler and the device. For Blue Pill is this setup
set(STARTUP_PATH "Libraries/CMSIS/CM3/DeviceSupport/ST/STM32F10x/startup/arm")
set(STARTUP_FILE "${STARTUP_PATH}/startup_stm32f10x_md.s")


# CC AR
set(CMAKE_C_COMPILER "arm-none-eabi-gcc")
set(CMAKE_C_AR "arm-none-eabi-ar")

# CFLAGS
set(CMAKE_C_FLAGS "-g -mthumb -fno-builtin -mcpu=$ENV{MCPU} -Wall -std=gnu99 -ffunction-sections -fdata-sections -fomit-frame-pointer -mabi=aapcs -fno-unroll-loops -ffast-math -ftree-vectorize" CACHE INTERNAL "c compiler flags")
set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -D $ENV{DEFINE_DEVICE} -D $ENV{DEFINE_DRIVER}")

# Generate the target to static linker library
add_library (STM32F10x_StdPeriph_Driver ${DIR_STM32F10x_StdPeriph_Driver_SRCS})
