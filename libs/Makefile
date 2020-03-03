###############################################################################
#
# Makefile for compiling STM32F1xx devices, specially, STM32F103C8T6 or bluepill
# Copyright (C) 2020 Alexandre Amory <amamory@gmail.com>
#
###############################################################################
# RELEVANT VARIABLES:
#
# Makefile that iterates over the list of variations of the same example
#
###############################################################################
MAKEFLAGS += --no-print-directory

.PHONY: $(EXAMPLE_DIRS)

all: $(EXAMPLE_DIRS)
	cd libopencm3 && make all
	cd STM32CubeF1_V1.8.0 && make lib
	cd STM32F10x_StdPeriph_Lib_V3.5.0 && make lib

clean: $(EXAMPLE_DIRS)
	cd libopencm3 && make clean
	cd STM32CubeF1_V1.8.0 && make clean
	cd STM32F10x_StdPeriph_Lib_V3.5.0 && make clean

