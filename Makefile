###############################################################################
#
# Makefile for compiling STM32F1xx devices, specially, STM32F103C8T6 or bluepill
# Copyright (C) 2020 Alexandre Amory <amamory@gmail.com>
#
###############################################################################
# RELEVANT VARIABLES:
#
# Main makefile that compiles all libs and all examples.
#
# In the TERMINAL, point the LEARNING_STM32 to the directory of the base project.
# For example:
#
#    $ export LEARNING_STM32=$HOME/learning-stm32
#
# Alternatively, you can also set this variable in the ~/.bashrc file.
#
#
# In the MAKE command, it is possible to define the other relevant variables:
#
#    V=1 : enables verbose mode
#    DEBUG=1: enables debug mode. Otherwise, the code is optimized for size
#
# Usage example:
#    $ make V=1 <=== enables verbose mode
#    $ make DEBUG=1 V=1 <=== enables both verbose and debug modes
###############################################################################

# testing the requirements
ifndef LEARNING_STM32
    $(error LEARNING_STM32 is undefined)
endif

# Be silent per default, but 'make V=1' will show all compiler calls.
ifneq ($(V),1)
Q := @
# Do not print "Entering directory ...".
MAKEFLAGS += --no-print-directory
endif

#creating the list of things to be compiled
LIB_DIRS := $(shell find $(LEARNING_STM32)/libs/* -maxdepth 0 -type d)
EXAMPLE_DIRS := $(shell find $(LEARNING_STM32)/examples/* -maxdepth 0 -type d)
ALL_DIRS :=  $(LIB_DIRS) $(EXAMPLE_DIRS)
$(info $$ALL_DIRS is [${ALL_DIRS}])

.PHONY: $(ALL_DIRS) 

all: $(ALL_DIRS)
	@echo "\\033[1;33m \t----------COMPILATION DONE----------- \\033[0;39m"

clean: $(ALL_DIRS)
	@echo "\\033[1;33m \t----------CLEANING DONE----------- \\033[0;39m"

help:
	@echo "\\033[1;33m \t----------HELP----------- \\033[0;39m"

# MAKECMDGOALS is special variable to the list of goals you specified on the command line
$(ALL_DIRS):
	cd $@ && make $(MAKECMDGOALS)
