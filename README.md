# Learning STM32

[![Build Status](https://travis-ci.org/amamory/learning-stm32.svg?branch=master)](https://travis-ci.org/amamory/learning-stm32)

A tutorial-like description for using an STM32 device for the first time.

***The examples and the environment are working, but the text is stil Work in Progress***

# Before you start programming


## Audience

Have you been using Arduino for quite a while, and now you are wondering what is the next step to learn more about embedded system programming?
This tutorial has been developed for this type of audience. Its main goal is to smooth the transition from Arduino to ARM programming.
The STM32 family of devices is one of the best options since there is plenty of documentation, and the devices are not expensive. It's about US$ 5 of investment for your first STM32 board.


## Background

To fully use this example, I am assuming the reader has some background experience, which is the essential background of any [low-level programmer](https://github.com/gurugio/lowlevelprogramming-university):

- Theory: computer architecture and operating systems
- Programming Environments: GCC, Ubuntu, Make
- Programming Languages: C. Optional C++ and Assembly for for ARM, RISCV, or MIPS
- Embedded Programming: Arduino

I am also assuming that you had some experience with Arduino and you think you are ready to expand your experience mebedded prograamin beyond the Arduino world.

# Seting up a programming environment for STM32 devices

https://github.com/amamory/Awesome-Embedded
https://github.com/gurugio/lowlevelprogramming-university
http://sijinjoseph.com/programmer-competency-matrix/

doc baseado em formato MD
https://github.com/umanovskis/baremetal-arm/blob/master/doc/build-ebook.sh

## Compilation adn Linking Process for GCC

Even though you have the background listed before and you have experience with GCC and make for Linux systems,
there are few concepts that you probably never heard if you never did some embedded programming beyond Arduino.

The goal of this section is to review the compilation and linking process of GCC, with a focus to the parts different for embedded programming.

***TO Be Done !!!***

https://medium.com/@xsumirx/gnu-linker-script-and-memory-relocation-for-embedded-devices-5d3d16d1f0



### The Linker Script

https://interrupt.memfault.com/blog/get-the-most-out-of-the-linker-map-file


### The Startup Code

https://barrgroup.com/embedded-systems/books/programming-embedded-systems/compiling-linking-locating
Startup code for C/C++ programs usually consists of the following actions, performed in the order described:

    Disable all interrupts.
    Copy any initialized data from ROM to RAM.
    Zero the uninitialized data area.
    Allocate space for and initialize the stack.
    Initialize the processor’s stack pointer.
    Create and initialize the heap.
    Execute the constructors and initializers for all global variables (C++ only).
    Enable interrupts.
    Call main.
    Call Destructors (C++ only)

startup code em C
http://pandafruits.com/stm32_primer/stm32_primer_lib.php


## Selecting a Device

Selecting a device to build up your programming skills can be quite complicated for beginners. However, I suggest a straightforward, perhaps too simples method, based only on $$$. Answer yourself, how much are you willing to invest? Even if you have money to spare, I would also suggest to take it slow because learning is also slow. I have plenty of examples of boards I bought with the best intentions to crack all its secrets. Still, it turns out that I didn't have enough time or something else with higher priority came. Years passed, and that board became obsolete. So, my ultimate suggestion is to start with the cheap and simple ones. If things go as aspected, you make a second investment with a board with more resources. If you do this, there will be no regrets in the future.

It turns out that you can spend ZERO to start learning embedded programming. QEMU has been ported to a few embedded boards, such as .... Using [QEMU](qemu.md) was my first step, and the examples I built are available here. But I have to say that I didn't go too much further in this direction. I want to do something more physical, at least some blinking LEDs.

Bare-metal programming for ARM: A hands-on guide
Daniels Umanovskis
book using QEMU for ARM bare metal programming
https://github.com/umanovskis/baremetal-arm

For my first actual ARM-based board, I chose one of the most straightforward and cheapest boards called [STM32F103C8T6](https://www.st.com/en/microcontrollers-microprocessors/stm32f103c8.html), or blue pill.
There are tons of places describing the resources available on this little board. So I won't describe it here, but it is relevant to compare it with the Arduino boards.
In my opinion, I saw the necessity to move away from simpler Arduino because of the lack of memory, second, because of low speed.
Blue pill has 64 Kbytes Flash memory, 20 Kbytes of SRAM, 72 MHz frequency. It doesn't seem much, but it is much more than Arduino nano, uno, or mega.
There is a third reason I moved away from Arduino, which is the lack of proper debugging resources. Debugging in Arduino is mainly by using prints, which is ok for learning,
but not scalable for a more significant project. With Blue pill, I can use GDB !!!. I also included with tutorials about using [GDB](gdb.md).

Be aware that it is not only the board you have to buy. You also need to select the cabling to upload the code, debug the system, etc.
Again, for the despair of the beginners, STM32 supports several methods. This brings the obvious question: which cable do I need?
Few tutorials allow uploading code with a [simple USB cable plus serial-USB converter](). however, i choose to use [ST-link cable]()
because it is cheap, and it supports debugging with GDB, which is a GREAT advantage compare to Arduino boards.
The rest of the tutorials assume you have this cable.


### What is STM32 ? what is ecxatly a STM32F103C8T6 ?

http://www.emcu.it/STM32.html

Processador [STM32F103C8T6 datasheet](https://www.st.com/resource/en/datasheet/CD00161566.pdf)

### Alternative STM32 Devices

In the future, I want to explore more complex boards, with periherals such as ethernet, wifi, radios, etc. For the time being, this is still future work.
Here is a list of other interesting boards:

https://medium.com/swlh/super-blue-pill-like-stm32-blue-pill-but-better-6d341d9347da
https://www.aliexpress.com/item/33051553220.html
with wifi, ethernet, and RF interfaces

https://www.aliexpress.com/item/33025687500.html
https://www.aliexpress.com/item/4000108648104.html
https://www.aliexpress.com/item/33011440716.html


## seting up the programming ecosystem



### selecting a programming environment


For a novice programmer, selecting the board is the first struggle. However, it is even harder to select a programming environment.
There are tons of nice options out there for embedded and STM32 devices. Here is a list of some of these options:
- [Eclipse]
- [Keil]
- [Atollic]
- [PlatformIO](https://docs.platformio.org/)
This is by far one of the GUI-based systems that called my attention. Some features such as Unit Testing, CLI, Continuous Integration, debug, and easy configurability are incredibly appealing. Perhaps this will be future work.

This tutorial uses Free and open-source software ([FOSS](https://en.wikipedia.org/wiki/Free_and_open-source_software)) alternatives.
I am a Linux user who loves the combination of GCC, make, and CMake. Sometimes people ask why you use such more straightforward methods where you can use Eclipse or Keil, etc. My answer to this question is simple. I have full control of the environment just by fixing a few text files. Moreover, these tools are extremely stable. I know that this environment will keep working despite future updates. Ok, sometimes compiler/libraries updates break things, but it would also happen in the GUI-based environment. However, it is usually easy to fix compiler/library update issues. For 99% of the time, the issue is just related to some new compiler flag that has to be added to the makefiles or minor modifications in the source code due to dependency updates.

Continuing with my motivations to use GCC, make, and CMake. These tools are extremely stable and large community of users. When you get stuck with make or CMake, you have to type what you want in the browser. There will be tons of answers and suggestions.

Finally, what I think is most important, I can automate the entire compilation, execution, debug processes with a single command line. This makes it easier to develop, and easier to someone else take this code and compile it him/herself.



### selecting the programming libraries

It turns out that selecting the libraries for STM32 is also not simple for a beginner. First, there are the libraries provided by the chip vendor (ST microelectronics). However, they only present the workflow for using their own GUI-based programming environment. And, that is a quite complex ecosystem of tools with weird names. Sometimes they replace the names of the tools, so your code is not compatible more with a newer version. The same old story I was talking in the previous section.

It turns out that it is possible to separate the libraries from the programming environment. Doing this is not advisable for beginners because you would spend a precious amount of time to understand these libraries and programming ecosystem. Luckily, some folks did part of the job, and I exploit it allot to build this repository. Hopefully, including also some contributions of my own.

In summary, these are the main libraries, or hardware abstraction layers, or middleware, OS I found to be the most useful:
- CMSIS by STM
- Standard Peripheral Libraries by STM
- [libopencm3]( http://libopencm3.org/)
- stm32duino

### selecting the RTOS

- freertos
- Zephyr (***to be done!***)
- RIOT (***to be done!***)


### Linux-based command-line programming environment (LBCLPE)

During my search for the ideal Linux-based command-line programming environment (LBCLPE), I found few excelent resources listed bellow:
- [https://stm32-base.org/](https://stm32-base.org/); It is the best resource I found for an LBCLPE for STM32 decives. Modular makefiles, simple to configure, and well documented. It relies on HAL and CMSIS. Altough, I have to say that it would be nice to have additional options of software libraries,
such as Standard Peripheral Libraries, opencm3, and and RTOS. It supports several STM32 device families, not only STM32F1xx.
- [Beginning STM32: Developing with FreeRTOS, libopencm3 and GCC](https://www.apress.com/us/book/9781484236239): A must read book about STM32. I have to say that this book is my motivation
to build this repo and trying to include more examples and prograaming options to it.
- [For the QEMU Users](https://github.com/beckus/stm32_p103_demos.git): Those who choose to use QEMU will certainly find this repo.
In fact, it is not only usefeull for QEMU users because it has such a huge number of examples that I suggest that any STM32 programmer to check it out. It uses Std Periph Driver.
- [minimal-stm32](https://github.com/samvrlewis/minimal-stm32.git): extremely simple and clean bare-bone LBCLPE. It has no depedencies whatsoever but it is not specific for an STM32F103C8T6 device;
- [STM32F103C8T6-from-scratch](https://github.com/asura6/STM32F103C8T6-from-scratch.git): Also very clean LBCLPE, with few examples, and based on only CMSIS.
- [Stm32f103-cmake-template](https://bitbucket.org/dimtass/stm32f103-cmake-template): for CMAKE users


### Setting up ST-Link


## The tutorial examples

- [blinking LED](./examples/blink/variations.md): several different ways to make a LED blink
- [serial](./examples/serial/variations.md): several different ways to do some serial communication (TO be DONE!)
- [timer](./examples/timer/variations.md): several different ways to use the timer  (TO be DONE!)


## Debugging STM32 with GDB

DDD
https://github.com/rohanrhu/gdb-frontend
https://github.com/cs01/gdbgui




## Now what ?!?!

If you get to this point, now you are a master in terms of blinking LED.  But they're much more if you want to master embedded software skills.
In the future, I intend to do something similar to a serial port. However, for the time being, I suggest choosing an application that you are interested in and start to learn the use of those libraries/RTOSs.

## To Do List

My future reading list:


### More examples

Include examples with serial communication and timers.

[//]: # (
exemplos c timer
https://rhye.org/post/stm32-with-opencm3-0-compiling-and-uploading/
https://github.com/szczys/bluepill-opencm3/blob/master/examples/systick/systick_example.c
exemplos c serial
https://github.com/szczys/bluepill-opencm3/tree/master/examples
)

### Other ROTS

[//]: # (
https://github.com/RIOT-OS/RIOT/tree/master/boards/bluepill
https://github.com/zephyrproject-rtos/zephyr/tree/master/boards/arm/stm3210c_eval
)

### Include C++ examples

[//]: # (
make a c++ version based on the book "Real-Time C++: Efficient Object-Oriented and Template Microcontroller"
)

### Hypervisor

[//]: # (
https://github.com/ARMmbed/uvisor
https://github.com/pierpaolobagnasco/hyperos
da p colocar RTOS e Linux junto na rasp
https://github.com/minos-project/minos-hypervisor
Xen Hypervisor - freeRTOS - automotive
https://xenproject.org/2015/02/02/getting-started-with-freertos-for-xen-on-arm-2/
https://github.com/GaloisInc/FreeRTOS-Xen
hypervisor - jailhouse - run linux in 3 core and a bare-metal application in the 4th core - jetson
https://github.com/siemens/jailhouse
https://github.com/evidence/linux-jailhouse-jetson
https://www.youtube.com/watch?v=eahQCEW4Uhc 
https://www.youtube.com/watch?v=skIcAkXfNWQ 
https://www.youtube.com/watch?v=7fiJbwmhnRw 
https://www.youtube.com/watch?v=yl_Q91xYTD4
)

### Stack memory and graph control flow Analises

[//]: # (
estudar tools para analisar stack memory e graph control flow
https://stackoverflow.com/questions/6387614/how-to-determine-maximum-stack-usage-in-embedded-system-with-gcc
https://www.gnu.org/software/cflow/manual/cflow.html
artigo Compile-time stack requirements analysis with GCC
https://github.com/PeterMcKinnis/WorstCaseStack
https://github.com/HBehrens/puncover
)

### MQTT

[//]: # (
https://github.com/S3ler/linux-mqtt-sn-gateway
)

### RadioHead

[//]: # (com cmake na rasp https://github.com/epsilonrt/RadioHead/tree/a05bb0b82be0a6c81c2c0046f5e8aafc5b94b366/piduino, 
https://www.aliexpress.com/item/32975942101.html SX1278)

### RadioLib

[//]: # (
https://github.com/jgromes/RadioLib
https://github.com/jgromes/RadioLib/tree/master/examples/SX127x
https://github.com/jgromes/RadioLib/tree/master/examples/MQTT
https://github.com/jgromes/RadioLib/tree/master/examples/XBee
https://github.com/jgromes/RadioLib/blob/master/src/modules/SX127x/SX1278.h
https://github.com/jgromes/RadioLib/blob/master/src/modules/SX127x/SX1278.cpp#L388 getRSSI
)

### LoRaWAN

[//]: # (
https://github.com/Lora-net/LoRaMac-node
)

### PlatformIO

[//]: # (
https://docs.platformio.org/en/latest/boards/ststm32/bluepill_f103c8.html
https://github.com/platformio/platformio-examples/tree/develop/unit-testing
https://github.com/platformio/platformio-examples/tree/develop/platforms/ststm32 <===
https://github.com/platformio/platform-ststm32
https://docs.platformio.org/en/latest/platforms/ststm32.html
https://github.com/platformio/platform-ststm32/blob/master/examples/libopencm3-blink/src/main.c
https://docs.platformio.org/en/latest/ide/cloud9.html
https://github.com/mupfelofen-de/BluePrint
)

### Meson

[//]: # (
https://gitlab.com/jhamberg/stm32-meson/-/tree/master
https://github.com/amitesh-singh/libopencm3-proj-template
https://github.com/vikaig/stm32-libopencm3-meson-blink
)

### Machine Learning

Sound cliche ?!?! that's because it is. I will include some examples about it in the near future.


## References and additional resources





## Utilities

The utils dir has tools such as:
- adafruit's linker map summary: takes a map file and it breaks down the sizes of each .o in a human readble way. Usefull to reduce the memory size.

similar tools
https://github.com/amamory/linker-map-summary.git
https://fpv-gcc.readthedocs.io/en/latest/usage.html
https://github.com/bmwcarit/Emma
https://github.com/google/bloaty
