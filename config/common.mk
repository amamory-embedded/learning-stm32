LEARNING_STM32 = /home/lsa/stm32/learning-stm32
#MAKE_DIR = libs/STM32F10x_StdPeriph_Lib_V3.5.0
#MAKE_DIR = libs/STM32CubeF1_V1.8.0

# testing the requirements
ifndef LEARNING_STM32
    $(error LEARNING_STM32 is undefined)
endif

#ifndef MAKE_DIR
#    $(error MAKE_DIR is undefined)
#endif

# LEARNING_STM32 base folder
BASE_HOME    = $(LEARNING_STM32)
BUILD_DIR ?= ./build

# toolchain
TOOLCHAIN    = arm-none-eabi-
CC           = $(TOOLCHAIN)gcc
CP           = $(TOOLCHAIN)objcopy
#AS           = $(TOOLCHAIN)gcc -x assembler-with-cpp
AS           = $(TOOLCHAIN)as
AR           = $(TOOLCHAIN)ar
GDB 		 = $(TOOLCHAIN)gdb
HEX          = $(CP) -O ihex
BIN          = $(CP) -O binary -S

# define mcu, specify the target processor
MCU          = cortex-m3

# Define optimisation level here
OPT = -Os
#OPT = -Og -ggdb3 # for debug mode

MC_FLAGS = -mcpu=$(MCU)

# base flags
AS_FLAGS = $(MC_FLAGS) -g -mthumb
CP_FLAGS = $(MC_FLAGS) $(OPT) -g -mthumb
CP_FLAGS += -ffunction-sections # # Generate separate ELF section for each function. usefull for static libraries
CP_FLAGS += -fdata-sections  # # Enable elf section per variable
#CP_FLAGS += -flto # link time optimizer. for the tests i did, it infact increased memory usage

LD_FLAGS = $(MC_FLAGS) -g -mthumb
LD_FLAGS += -specs=nosys.specs  # Stub library with empty definitions for POSIX functions
LD_FLAGS += -specs=nano.specs # newlibnano https://blog.uvokchee.de/2019/07/arm-bare-metal-flags.html
#LD_FLAGS += -Wl,--verbose #  gcc enables verbose linker output
LD_FLAGS += -Wextra -Wall # extra messages
#https://interrupt.memfault.com/blog/get-the-most-out-of-the-linker-map-file
# http://blog.atollic.com/the-ultimate-guide-to-reducing-code-size-with-gnu-gcc-for-arm-cortex-m
#https://stackoverflow.com/questions/4274804/query-on-ffunction-section-fdata-sections-options-of-gcc
LD_FLAGS += -ffunction-sections # # Generate separate ELF section for each function. usefull for static libraries
LD_FLAGS += -fdata-sections  # # Enable elf section per variable
#LD_FLAGS += -flto # link time optimizer. for the tests i did, it infact increased memory usage
LD_FLAGS += -Xlinker --gc-sections ## Perform dead-code elimination
LD_FLAGS += -Wl,-Map=${PROJECT_NAME}.map # Generate a memory map. The map file is a symbol table for the whole program

include $(PWD)/defs.mk

#$(info $$INCLUDE_DIRS is [${INCLUDE_DIRS}])

# check variables in the included makefile
ifndef PROJECT_NAME
    $(error Please set the required PROJECT_NAME variable in your makefile.)
endif
$(info $$PROJECT_NAME is [${PROJECT_NAME}])

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
all: $(OBJECTS) $(PROJECT_NAME).elf  $(PROJECT_NAME).hex $(PROJECT_NAME).bin
	$(TOOLCHAIN)size $(PROJECT_NAME).elf

%.o: %.c | $(OBJ_FOLDER)
	$(CC) -c $(CP_FLAGS) -I . $(INC_DIR) $< -o $@

%.o: %.cpp | $(OBJ_FOLDER)
	$(CC) -c $(CP_FLAGS) $(CXX_FLAGS) -I . $(INC_DIR) $< -o $@

%.o: %.s | $(OBJ_FOLDER)
	$(AS) -c $(AS_FLAGS) $< -o $@

%.elf: $(OBJECTS)
	$(CC) $(OBJECTS) $(LD_FLAGS) -o $@

%.hex: %.elf
	$(HEX) $< $@

%.bin: %.elf
	$(BIN)  $< $@

$(OBJ_FOLDER):
	mkdir $(BUILD_DIR)

flash: $(PROJECT_NAME).bin
	#st-flash write $(PROJECT_NAME).bin 0x8000000
	# Make flash to the board by STM32CubeProgrammer v2.2.1
	STM32_Programmer.sh -c port=SWD -e all -d  $(PROJECT_NAME).bin 0x8000000 -v

# rule used to create static library for the libs that are not supposed to change often: CMSIS, Std_Periph, HAL, openCM3, etc
lib: $(OBJECTS)
	$(AR) -r -s $(PROJECT_NAME).a $(OBJECTS)

debug:	$(PROJECT_NAME).elf
	$(GDB) --eval-command="target extended-remote :4242" $(PROJECT_NAME).elf

erase:
	st-flash erase

clean:
	-rm -rf $(OBJECTS)
	-find . -type f -name '*.o' -delete
	-rm -rf $(BUILD_DIR)
	-rm -rf $(PROJECT_NAME).elf
	-rm -rf $(PROJECT_NAME).map
	-rm -rf $(PROJECT_NAME).hex
	-rm -rf $(PROJECT_NAME).bin
	-rm -rf $(PROJECT_NAME).a

