###############################################################################
#
# Makefile for compiling STM32F1xx devices, specially, STM32F103C8T6 or bluepill
# Copyright (C) 2020 Alexandre Amory <amamory@gmail.com>
#
###############################################################################
# RELEVANT VARIABLES:
#
# fake makefile that calls the real one
#
###############################################################################

all:
	@echo "\\033[1;33m ************************************** \\033[0;39m"
	@echo "\\033[1;33m ************* STM32CubeF1 ************ \\033[0;39m"
	@echo "\\033[1;33m ************************************** \\033[0;39m"
	make -f  $(LEARNING_STM32)/config/common.mk lib

clean:
	make -f  $(LEARNING_STM32)/config/common.mk clean