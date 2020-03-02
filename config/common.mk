
###############################################################################
#
# Makefile for compiling STM32F1xx devices, specially, STM32F103C8T6 or bluepill
# Copyright (C) 2020 Alexandre Amory <amamory@gmail.com>
#
###############################################################################
# RELEVANT VARIABLES:
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

# LEARNING_STM32 base folder
BASE_HOME    = $(LEARNING_STM32)
BUILD_DIR ?= ./build

# toolchain
TOOLCHAIN    = arm-none-eabi-
CC           = $(TOOLCHAIN)gcc
CP           = $(TOOLCHAIN)objcopy
AS           = $(TOOLCHAIN)as
AR           = $(TOOLCHAIN)ar
GDB 		 = $(TOOLCHAIN)gdb
SIZE 		 = $(TOOLCHAIN)size
HEX          = $(CP) -O ihex
BIN          = $(CP) -O binary -S

# tools
SIZE_SCRIPT = $(LEARNING_STM32)/utils/get-size.sh

# define mcu, specify the target processor
MCU      = cortex-m3
MC_FLAGS = -mcpu=$(MCU)

# base flags
AS_FLAGS = $(MC_FLAGS) -mthumb
CP_FLAGS = $(MC_FLAGS) -mthumb
LD_FLAGS = $(MC_FLAGS) -mthumb

# Define optimisation level here
ifdef DEBUG
# https://interrupt.memfault.com/blog/best-and-worst-gcc-clang-compiler-flags#-g3
# extra debug definitions, including macro definition
    CP_FLAGS   += -g3
else
# optimize for speed and size
    CP_FLAGS   += -Os
    #CP_FLAGS += -flto # link time optimizer. for the tests i did, it infact increased memory usage
endif
# # Generate separate ELF section for each function.
# usefull for static libraries since it possible to benefit from more efficient dead code removal.
# check https://elinux.org/images/2/2d/ELC2010-gc-sections_Denys_Vlasenko.pdf for more
# https://interrupt.memfault.com/blog/best-and-worst-gcc-clang-compiler-flags#-ffunction-sections--fdata-sections----gc-sections
CP_FLAGS += -ffunction-sections
# Enable elf section per variable
CP_FLAGS += -fdata-sections
#https://interrupt.memfault.com/blog/best-and-worst-gcc-clang-compiler-flags#-fstack-usage---wstack-usage
#https://stackoverflow.com/questions/6387614/how-to-determine-maximum-stack-usage-in-embedded-system-with-gcc
# used to monitor stack space in a function and emit warnings when the usage is too high.
# -fstack-usage flag generates a .su files for each compiled c file.
CP_FLAGS  += -fstack-usage


# Stub library with empty definitions for POSIX functions
LD_FLAGS += -specs=nosys.specs
# newlibnano https://blog.uvokchee.de/2019/07/arm-bare-metal-flags.html
LD_FLAGS += -specs=nano.specs
# gcc enables verbose linker output
#LD_FLAGS += -Wl,--verbose
# extra messages
LD_FLAGS += -Wextra -Wall
# Generate separate ELF section for each function. usefull for static libraries
#https://interrupt.memfault.com/blog/get-the-most-out-of-the-linker-map-file
#http://blog.atollic.com/the-ultimate-guide-to-reducing-code-size-with-gnu-gcc-for-arm-cortex-m
#https://stackoverflow.com/questions/4274804/query-on-ffunction-section-fdata-sections-options-of-gcc
LD_FLAGS += -ffunction-sections
# Enable elf section per variable
LD_FLAGS += -fdata-sections
# Generate a memory map. The map file is a symbol table for the whole program
LD_FLAGS += -Wl,-Map=${PROJECT_NAME}.map
#LD_FLAGS += -Wl,--print-memory-usage # prints something like this
#Memory region         Used Size  Region Size  %age Used
#             rom:       10800 B       256 KB      4.12%
#             ram:        8376 B        32 KB     25.56%

#include the apps specific definitions
include $(PWD)/defs.mk
# include the apps depedency modules
$(foreach module,$(USE_MODULE),$(eval include $(LEARNING_STM32)/config/$(module).mk))
#$(info $$INCLUDE_DIRS is [${INCLUDE_DIRS}])

# check variables in the included makefile
ifndef PROJECT_NAME
    $(error Please set the required PROJECT_NAME variable in your makefile.)
endif
#$(info PROJECT_NAME = ${PROJECT_NAME})

# adds -T in front of the linker script file
ifdef LINK_SCRIPT
    LD_FLAGS += $(patsubst %, -T%, $(LINK_SCRIPT))
endif

ifdef DDEFS
    CP_FLAGS += $(DDEFS)
endif

# include the statup code into to the list of ASM file
ifdef DEVICE_STARTUP
	ASM_SRC  += $(DEVICE_STARTUP)
endif

# the -Wstack-usage flag will make sure that the stack limit is not hit
ifndef STACK_SIZE
    $(error Please set the required STACK_SIZE variable in your makefile.)
else
	# -Wstack-usage=<stack_limit> emit a warning when stack usage exceeds a certain value
	CP_FLAGS  += -Wstack-usage=$(STACK_SIZE)
endif


# insert -I in front of every folder in INCLUDE_DIRS
INC_DIR  = $(patsubst %, -I%, $(INCLUDE_DIRS))
# insert -L in front of every folder in LIBRARY_DIRS
LIB_DIR  = $(patsubst %, -L%, $(LIBRARY_DIRS))
# insert -l in front of every LIBRARY_NAMES
LIB_NAME  = $(patsubst %, -l%, $(LIBRARY_NAMES))

LD_FLAGS += $(LIB_DIR) $(LIB_NAME)
#$(info $$INCLUDE_DIRS is [${INCLUDE_DIRS}])
#$(info $$INC_DIR is [${INC_DIR}])
#$(info $$LIBRARY_DIRS is [${LIBRARY_DIRS}])
#$(info $$LIB_DIR is [${LIB_DIR}])

#$(info SOURCES : $(wildcard $(SRC)))

# expand wildcards to the each source file
#$(info $$SRC is [${SRC}])
SRC_FILES = $(wildcard $(SRC))
ASM_FILES += $(wildcard $(ASM_SRC))
#$(info $$SRC_FILES is [${SRC_FILES}])
#$(info $$ASM_FILES is [${ASM_FILES}])

# create a string with all obj names
OBJECTS  = $(ASM_FILES:.s=.o) $(SRC_FILES:.c=.o)
# I was trying to place all obj files under the BUILD_DIR, similar to
# https://spin.atomicobject.com/2016/08/26/makefile-c-projects/, but it didnt work
# i have to try it again
#SRC_FILES2 = $(notdir $(SRC_FILES))
#OBJECTS    := $(patsubst %.c,$(BUILD_DIR)/%.o,$(SRC_FILES2))
#$(info $$OBJECTS is [${OBJECTS}])


#
# makefile rules
#
all: init_rule $(OBJECTS) $(PROJECT_NAME).elf  $(PROJECT_NAME).hex $(PROJECT_NAME).bin
	@echo "\\033[1;33m \t----------COMPILATION FINISHED---------- \\033[0;39m"
	@printf "\n  SIZE        $(PROJECT_NAME).elf\n"
	$(Q)$(SIZE) $(PROJECT_NAME).elf
	@printf "  MEM REPORT  $(PROJECT_NAME).elf\n"
	$(Q)python $(LEARNING_STM32)/utils/linker-map-summary/analyze_map.py $(PROJECT_NAME).map
	@printf "\n"
	$(Q)$(SIZE_SCRIPT)	$(PROJECT_NAME).elf 0x10000 0x5000
	@echo "\\033[1;33m \t----------REPORTS FINISHED----------- \\033[0;39m"

%.o: %.c | $(OBJ_FOLDER)
	@printf "  CC      $<\n"
	$(Q)$(CC) -c $(CP_FLAGS) -I . $(INC_DIR) $< -o $@

%.o: %.cpp | $(OBJ_FOLDER)
	@printf "  CXX     $<\n"
	$(Q)$(CC) -c $(CP_FLAGS) $(CXX_FLAGS) -I . $(INC_DIR) $< -o $@

%.o: %.s | $(OBJ_FOLDER)
	@printf "  AS      $<\n"
	$(Q)$(AS) -c $(AS_FLAGS) $< -o $@

%.elf: $(OBJECTS)
	@printf "  LD      $(*).elf\n"
	$(Q)$(CC) $(OBJECTS) $(LD_FLAGS) -o $@

%.hex: %.elf
	@printf "  OBJCOPY $@\n"
	$(Q)$(HEX) $< $@

%.bin: %.elf
	@printf "  OBJCOPY $@\n"
	$(Q)$(BIN)  $< $@

init_rule:
	@echo "\\033[1;33m \t----------COMPILATION STARTED----------- \\033[0;39m"

$(OBJ_FOLDER):
	$(Q)mkdir $(BUILD_DIR)

flash: $(PROJECT_NAME).bin
	@#st-flash write $(PROJECT_NAME).bin 0x8000000
	@# Make flash to the board by STM32CubeProgrammer v2.2.1
	STM32_Programmer.sh -c port=SWD -e all -d  $(PROJECT_NAME).bin 0x8000000 -v

# rule used to create static library for the libs that are not supposed to change often: CMSIS, Std_Periph, HAL, openCM3, etc
lib: init_rule $(OBJECTS)
	@printf "\n  STATIC LIB  $(PROJECT_NAME).a\n"
	$(Q)$(AR) -r -s $(PROJECT_NAME).a $(OBJECTS)
	@echo "\\033[1;33m \t----------COMPILATION FINISHED---------- \\033[0;39m"
	@printf "\n  REPORT    $(PROJECT_NAME).a\n"
	@# reporting objs included into the static library, removed unwanted coluns with awk, and sort the objs by their sizes
	$(Q)$(AR) -tv $(PROJECT_NAME).a | awk '{printf "%8s %s\n", $$3, $$8}' | sort -k 1n
	@# report text, data, bss and total size for each object. Then, use awk to sum these values and present the total
	@printf "\n"
	$(Q)$(SIZE) -d -G $(PROJECT_NAME).a | awk '{c1+=$$1; c2+=$$2; c3+=$$3; c4+=$$4} END {printf "Text size: %.0f\n", c1; printf "Data size: %.0f\n", c2; printf "BSS size: %.0f\n", c3;  printf "Total size: %.0f\n", c4}'
	@# print the % of flash and ram usage considering 64K of flash and 20K of RAM
	@printf "\n"
	$(Q)$(SIZE_SCRIPT)	$(PROJECT_NAME).a 0x10000 0x5000 lib
	@echo "\\033[1;33m \t----------REPORTS FINISHED----------- \\033[0;39m"

debug:	$(PROJECT_NAME).elf
	$(GDB) --eval-command="target extended-remote :4242" $(PROJECT_NAME).elf

erase:
	$(Q)st-flash erase

clean:
	$(Q)-rm -rf $(OBJECTS)
	$(Q)-find . -type f -name '*.o' -delete
	$(Q)-find . -type f -name '*.su' -delete
	$(Q)-rm -rf $(BUILD_DIR)
	$(Q)-rm -rf $(PROJECT_NAME).elf
	$(Q)-rm -rf $(PROJECT_NAME).map
	$(Q)-rm -rf $(PROJECT_NAME).hex
	$(Q)-rm -rf $(PROJECT_NAME).bin
	$(Q)-rm -rf $(PROJECT_NAME).a
	@echo "\\033[1;33m \t----------DONE CLEANING----------------- \\033[0;39m"

