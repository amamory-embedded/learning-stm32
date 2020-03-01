
# Seting up a programming environment for STM32 devices

https://github.com/amamory/Awesome-Embedded
https://github.com/gurugio/lowlevelprogramming-university
http://sijinjoseph.com/programmer-competency-matrix/

doc baseado em formato MD
https://github.com/umanovskis/baremetal-arm/blob/master/doc/build-ebook.sh

## Background

In order to fully use this example I am assuming the reader has some background experience, which is basically the basic background of any [low level programmer](https://github.com/gurugio/lowlevelprogramming-university):

- Theory: computer architecture and operating systems
- Programming Environments: GCC, Ubuntu, Make
- Programming Languages: C. Optional C++ and Assembly for for ARM, RISCV, or MIPS
- Embedded Programming: Arduino

I am also assuming that you had some experience with Arduino and you think you are ready to expand your experience mebedded prograamin beyond the Arduino world.

### Compilation adn Linking Process for GCC

Even though you have the background listed before and you have experience with GCC and make for Linux systems,
there are few concepts that you probably never heard with you never did some embedded prograaming beyond Arduino.

The goal of this section is to review the compilation and linking process of GCC, with focus to the parts different for embedded prograaming.

***TO Be Done !!!***

https://medium.com/@xsumirx/gnu-linker-script-and-memory-relocation-for-embedded-devices-5d3d16d1f0



#### The Linker Script

https://interrupt.memfault.com/blog/get-the-most-out-of-the-linker-map-file


#### The Startup Code

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

Selecting a device to build up your programming skills can be quite complex for beginners.
However, I suggest a very simple, perhaps too simples method, based only on $$$.
Answer yourself how much are you willing to invest ? Even if you have money to spare,
I would also suggest to take it slow because learning is also slow. I have pleanty
of examples of boards I bought with the best intentions to crack all its secrets,
but it turns out that I didnot have enough time or something else with higher priority came.
Years passed and that board became obsolete. So, my ultimate suggestion is to start with the
cheap and simple ones. If things go as aspected, you make a second investment with a board with more resources.
If you does like this, there will be no regrest in the future.

It turns out that you can spend ZERO to start learning embedded prograaming. QEMU has been ported to few embedded boards such as ....
Using [QEMU](qemu.md) was my first step, and the examples I built are available here. But i have to say that i didnt go too much further in this direction.
I want to do somthing more physical, at least some blinking LEDs.

Bare-metal programming for ARM: A hands-on guide
Daniels Umanovskis
book using QEMU for ARM bare metal programming
https://github.com/umanovskis/baremetal-arm

For my first actual ARM-based board, I chose one of the simplest and cheapsts boards called [STM32F103C8T6](https://www.st.com/en/microcontrollers-microprocessors/stm32f103c8.html), or blue pill.
There are tons of places describing the resources available in this little board. So I won't describe it here but it is relevant to compare it with the Arduino boards.
In my opinion, I saw the nessecity to move away from simpler Arduino because the lack of memory, second, because of low speed.
Blue pill has 64 Kbytes Flash memory, 20 Kbytes of SRAM, 72 MHz frequency. It doesnt seem much, but it is much more than Arduino nano, uno, or mega.
There is a third reason I moved awas from arduino, which is lack of good debugging resources. Debugging in Arduino is mainly by using prints, which is ok for learning,
but not scalable for bigger project. With Blue pill i can use GDB !!!. I also included with tutorials about using [GDB](gdb.md).

Be aware that it is not only the board you have to buy. Yuo also need to select the cabling to upload the code, debug the system, etc.
again, for the dispear of the beginners, STM32 supports several methods. This bring the obvious question: which cable do I need ?
There are few tutorials that allow to upload code with a [simple USB cable plus serial-usb converter](). however, i choose to use [ST-link cable]()
basically because it is cheap and it support debugging with GDB, which is a GREAT advantage compare to Arduino boards.
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


For a novice programer, selecting the board is the first struggle. However, it is even harded to select to programming environment.
There are tons of nice options out there for embedded and STM32 devices. Here is a list of some of these options:
- [Eclipse]
- [Keil]
- [Atollic]
- [PlatformIO](https://docs.platformio.org/)
This is by far one of the GUI-based systems that called my attention. Some features such as Unit Testing,
CLI, Continuous Integration, debug, and easy configurability are extremely appeling. Perhaps this will be a future work.

This tutorial uses Free and open-source software ([FOSS](https://en.wikipedia.org/wiki/Free_and_open-source_software)) alternatives.
I am a Linux user who loves the combination of gcc, make, and cmake. Sometimes people ask why you use such simpler methods where you can use Eclipse or Keil, etc. My answer to this question is simple. I have full control of the environment just by fixing few text files. Moreover, these tools are extremely stable. I know that this environment will keep working despite the future updates. Ok, sometimes compiler/libraries updates breaks things, but it would also happen in GUI-based environment. however, it is usually easy to fix compiler/library update iussues. 99% of the time, some new compiler flag has to be added to the makefiles or some library was updated and the function name you are calling in your code has to updated too.

Continuing with my motivations to use gcc, make, and cmake. These tools are extremely stable and large comunity of users. When you get stuck with make or cmake, you just have to type what you want in the browser. There will be tons of answers and suggestions.

Finally, what i think it is most important, I can automate the entire compilation, execution, debug processes with a single command line. This makes it easier to develope and easier to someone else take this code and compile it him/herself.



### selecting the programming libraries

It turns out that selecting the libraries for STM32 is also not simple for a beginner. First, there are the libraries provided by the chip vendor (ST microelectronis). However, they only present the workflow for using their own GUI-based programming environment. And, that is a quite complex ecosystem of tools with weird names. Sometimes the totaly replace the names of the tools, so your code is not compatible more with newer version ... the same old story I was talking in the previous section.

It turns out that it is possible to separate the libraries from the programming environment. Doing this is not advisable for begginers because you would speend a precious amount of time just to understand these libraries and programming ecosystem. Luckly, some folks did part of the job and I exploit it allot to build this repository. Hopefully, including also some contributions of my own.

In summary, these are the main libraries, or hardware abstraction layers, or middleware, OS I found to be the most usefull:
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

### The fifty shades of a blinking LED

This is the first step of any embedded programmer. Why would I skip it if it works for lots of people ? At the beginning, this can seem to be too trivial,
but belive me when I say there are pleanty of lessons to be learned from a blinking LED.

First, you get to test for the first time your decive, your programming cable, the programming environment, and the setup of libraries. This initial setup takes quite a lot of time from a beginner. However, once you make a template design, you can only copy the directory and within few minutes you have another environment for another project.

Second, and most important of all, it turns out that there are SEVERAL different ways to make an LED blink. I dont only say that there are different sequences of commands to have a bliking LED. There are also several abstractions levels to work with. The higher the abstraction level, the quicker you will have your LED blinking. However, you will pay in memory usage and performance which is not a big issue for a blinking LED, but it a excelent opportuninty to know more what happens underneath the abstraction laeyrs.

Since we are assuming that the reader is familiar to the Arduino programming environment and APIs, we are going to start from that, until Assembly version of the blinking LED. The following list of versions of the blinking LED is not exaustive, but I believe it is enough to introduce several different pieces of relevant software in terms of embedded software.

- [stm32duino](the_fifty_shades_of_blink.md#stm32duino)
- [Standard Peripheral Libraries](the_fifty_shades_of_blink.md#std_periph_lib)
- [Libopencm3](the_fifty_shades_of_blink.md#libopencm3)
- [CMSIS and HAL](the_fifty_shades_of_blink.md#cmsis)
- [Bare-metal C](the_fifty_shades_of_blink.md#bare_metal_c)
- [Assembly](the_fifty_shades_of_blink.md#asm)
- [Freertos](the_fifty_shades_of_blink.md#freertos)
- [Zephyr](the_fifty_shades_of_blink.md#zephyr)
- [RIOT](the_fifty_shades_of_blink.md#riot)


### The fifty shades of a serial port

***To be done!***

### The fifty shades of timers

***To be done!***

## Debugging STM32 with GDB

DDD
https://github.com/rohanrhu/gdb-frontend
https://github.com/cs01/gdbgui




## Now what ?!?!

If you get to this points, now your are a master in terms of blinking LED.  But there much more if you want to master embedded software skills.
In the future I intend to do something similar to a serial port. However, for the time being, i suggest to chose an application that you are interested and start to learn the use those libraries/RTOSs.


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



