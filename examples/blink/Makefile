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

# these dirs dont have makefile
EXCLUDE_DIR_LIST = with_arduino
EXCLUDE_DIR_STR  = $(patsubst %, -name %, $(EXCLUDE_DIR_LIST))

#creating the list of things to be compiled
EXAMPLE_DIRS := $(shell find ./* -type d \( ! $(EXCLUDE_DIR_STR) \) -print)
$(info $$EXAMPLE_DIRS is [${EXAMPLE_DIRS}])

MAKEFLAGS += --no-print-directory

.PHONY: $(EXAMPLE_DIRS)

all: $(EXAMPLE_DIRS)

clean: $(EXAMPLE_DIRS)

list:
	@echo $(EXAMPLE_DIRS)

# MAKECMDGOALS is special variable to the list of goals you specified on the command line
$(EXAMPLE_DIRS):
	cd $@ && make -f $(LEARNING_STM32)/config/common.mk $(MAKECMDGOALS)