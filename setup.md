
# Seting up a programming environment for ARM devices

https://github.com/amamory/Awesome-Embedded
https://github.com/gurugio/lowlevelprogramming-university
http://sijinjoseph.com/programmer-competency-matrix/

## background

https://medium.com/@xsumirx/gnu-linker-script-and-memory-relocation-for-embedded-devices-5d3d16d1f0




## selecting a device

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

For my first actual ARM-based board, I chose one of the simplest and cheapsts boards called [STM32F103C8T6](https://www.st.com/en/microcontrollers-microprocessors/stm32f103c8.html), or blue pill.  
There are tons of places describing the resources available in this little board. So I won't describe it here but it is relevant to compare it with the Arduino boards.
In my opinion, I saw the nessecity to move away from simpler Arduino because the lack of memory, second, because of low speed. 
Blue pill has 64 Kbytes Flash memory, 20 Kbytes of SRAM, 72 MHz frequency. It doesnt seem much, but it is much more than Arduino nano, uno, or mega. 
There is a third reason I moved awas from arduino, which is lack of good debugging resources. Debugging in Arduino is mainly by using prints, which is ok for learning, 
but not scalable for bigger project. With Blue pill i can use GDB !!!. I also included with tutorials about using [GDB](gdb.md).


https://medium.com/swlh/super-blue-pill-like-stm32-blue-pill-but-better-6d341d9347da
https://www.aliexpress.com/item/33051553220.html
with wifi, ethernet, and RF interfaces


https://www.aliexpress.com/item/33025687500.html
https://www.aliexpress.com/item/4000108648104.html
https://www.aliexpress.com/item/33011440716.html

Be aware that it not only the board you have to buy. Yuo also need to select the cabling to upload the code, debug the system, etc. 
again, for the dispear of the beginners, STM32 supports several methods. This bring the obvious question: which cable do I need ? 
There are few tutorials that allow to upload code with a [simple USB cable plus serial-usb converter](). however, i choose to use [ST-link cable]()
basically because it is cheap and it support debugging with GDB, which is a GREAT advantage compare to Arduino boards. 
The rest of the tutorials assume you have this cable. 

In the future, I want to explore more complex boards, with periherals such as ethernet, wifi, radios, etc. For the time being, this is still future work.

## selecting a programming environment

For a novice programer, selecting the board is the first struggle. However, it is even harded to select to programming environment.
There are tons of nice options out there for embedded and STM32 devices. Here is a list of some of these options:
- [Eclipse]
- [Keil]
- [Atollic]
- [PlatformIO](https://docs.platformio.org/) 
This is by far one of the GUI-based systems that called my attention. Some features such as Unit Testing, 
CLI, Continuous Integration, debug, and easy configurability are extremely appeling. Perhaps this will be a future work.

However, I a Linux used who loves the combination of gcc, make, and cmake. Sometimes people ask why you use such simpler methods where you can use Eclipse or Keil, etc.
My answer to this question is simple. I have full control of the environment just by fixing few text files. Moreover, these tools are extremely stable. 
I know that this environment will keep working despite the future updates.
Ok, sometimes compiler/libraries updates breaks things, but it would also happen in GUI-based environment. however, it is usually easy to fix compiler/library update iussues.
99% of the time, some new compiler flag has to be added to the makefiles or some library was updated and the function name you are calling in your code has to updated too.

Continuing with my motivations to use gcc, make, and cmake. These tools are extremely stable and large comunity of users. When you get stuck with make or cmake, you just have to type
what you want in the browser. There will be tons of answers and suggestions. 

Finally, what i think it is most important, I can automate the entire compilation, execution, debug processes with a single command line. This makes it easier to develope and easier 
to someone else take this code and compile it him/herself.


### what is STM32 ? what is ecxatly a STM32F103C8T6 ?

http://www.emcu.it/STM32.html

Processador [STM32F103C8T6 datasheet](https://www.st.com/resource/en/datasheet/CD00161566.pdf)

## selecting the programming libraries

It turns out that selecting the libraries for STM32 is also not simple for a beginner. First, there are the libraries provided by the chip vendor (ST microelectronis). However, they 
only present the workflow for using their own GUI-based programming environment. And, that is a quite messy ecosystem of tools with weird names. Sometimes the totaly replace the names 
of the tools, so your code is not compatible more with newer version ... the same old story I was talking in the previous section.

It turns out that it is possible to separate the libraries from the programming environment. Doing this is not advisable for begginers because you would speend a precious amount of time
just to understand these libraries and programming ecosystem. Luckly, some folks did part of the job and I exploit it allot to build this repository. Hopefully, including also some 
contributions of my own. 

In summary, these are the main libraries, or hardware abstraction layers, or middleware, OS I found to be the most usefull:
- CMSIS by STM
- Standard Peripheral Libraries by STM
- [libopencm3]( http://libopencm3.org/)
- freertos
- stm32duino

## Linux-based command-line programming environment (LBCLPE)

During my search for the ideal Linux-based command-line programming environment (LBCLPE), I found few excelent resources listed bellow:
- [https://stm32-base.org/](https://stm32-base.org/); It is the best resource I found for an LBCLPE for STM32 decives. Modular makefiles, simple to configure, and well documented. It relies on HAL and CMSIS. Altough, I have to say that it would be nice to have additional options of software libraries, 
such as Standard Peripheral Libraries, opencm3, and and RTOS. It supports several STM32 device families, not only STM32F1xx. 
- [Beginning STM32: Developing with FreeRTOS, libopencm3 and GCC](https://www.apress.com/us/book/9781484236239): A must read book about STM32. I have to say that this book is my motivation 
to build this repo and trying to include more examples and prograaming options to it.
- [For the QEMU Users](https://github.com/beckus/stm32_p103_demos.git): Those who choose to use QEMU will certainly find this repo. 
In fact, it is not only usefeull for QEMU users because it has such a huge number of examples that I suggest that any STM32 programmer to check it out. It uses Std Periph Driver.
- [minimal-stm32](https://github.com/samvrlewis/minimal-stm32.git): extremely simple and clean bare-bone LBCLPE. It has no depedencies whatsoever but it is not specific for an STM32F103C8T6 device;
- [STM32F103C8T6-from-scratch](https://github.com/asura6/STM32F103C8T6-from-scratch.git): Also very clean LBCLPE, with few examples, and based on only CMSIS. 


## Setting up ST-Link 


## The fifty shades of a blinking LED

This is the first step of any embedded programmer. Why would I skip it if it works for lots of people ? At the beginning, this can seem to be too trivial, 
but belive me when I say there are pleanty of lessons to be learned from a blinking LED. 

First, you get to test for the first time your decive, your programming cable, 
the programming environment, and the setup of libraries. This initial setup takes quite a lot of time from a beginner. However, once you make a template design, 
you can only copy the directory and within few minutes you have another environment for another project. 

Second, and most important of all, it turns out that there are SEVERAL different ways to make an LED blink. I dont only say that there are different sequences of commands 
to have a bliking LED. There are also several abstractions levels to work with. The higher the abstraction level, the quicker you will have your LED blinking. However,
you will pay in memory usage and performance which is not a big issue for a blinking LED, but it a excelent opportuninty to know more what happens underneath the abstraction laeyrs. 

Since we are assuming that the reader is familiar to the Arduino programming environment and APIs, we are going to start from that, until Assembly version of the blinking LED.
The following list of versions of the blinking LED is not exaustive, but I believe it is enough to introduce several different pieces of relevant software in terms of embedded software. 

- [stm32duino](the_fifty_shades_of_blink.md#stm32duino)
- [Standard Peripheral Libraries](the_fifty_shades_of_blink.md#std_periph_lib)
- [Libopencm3](the_fifty_shades_of_blink.md#libopencm3)
- [CMSIS and HAL](the_fifty_shades_of_blink.md#cmsis)
- [Bare-metal C](the_fifty_shades_of_blink.md#bare_metal_c)
- [Assembly](the_fifty_shades_of_blink.md#asm)
- [Freertos](the_fifty_shades_of_blink.md#freertos)
- [Zephyr](the_fifty_shades_of_blink.md#zephyr)

## Debugging STM32 with GDB

DDD
https://github.com/rohanrhu/gdb-frontend
https://github.com/cs01/gdbgui

## The fifty shades of a serial port


## Nice things to include in the future

### MQTT
https://github.com/S3ler/linux-mqtt-sn-gateway

### RadioHead

com cmake na rasp
https://github.com/epsilonrt/RadioHead/tree/a05bb0b82be0a6c81c2c0046f5e8aafc5b94b366/piduino
https://www.aliexpress.com/item/32975942101.html
SX1278 

### RadioLib
https://github.com/jgromes/RadioLib
https://github.com/jgromes/RadioLib/tree/master/examples/SX127x
https://github.com/jgromes/RadioLib/tree/master/examples/MQTT
https://github.com/jgromes/RadioLib/tree/master/examples/XBee
https://github.com/jgromes/RadioLib/blob/master/src/modules/SX127x/SX1278.h
https://github.com/jgromes/RadioLib/blob/master/src/modules/SX127x/SX1278.cpp#L388 getRSSI

### LoRaWAN
https://github.com/Lora-net/LoRaMac-node

### PlatformIO

https://docs.platformio.org/en/latest/boards/ststm32/bluepill_f103c8.html
https://github.com/platformio/platformio-examples/tree/develop/unit-testing
https://github.com/platformio/platformio-examples/tree/develop/platforms/ststm32 <===
https://github.com/platformio/platform-ststm32
https://docs.platformio.org/en/latest/platforms/ststm32.html
https://github.com/platformio/platform-ststm32/blob/master/examples/libopencm3-blink/src/main.c
https://docs.platformio.org/en/latest/ide/cloud9.html


### Meson
https://gitlab.com/jhamberg/stm32-meson/-/tree/master
https://github.com/amitesh-singh/libopencm3-proj-template
https://github.com/vikaig/stm32-libopencm3-meson-blink

## Now what ?!?!

If you get to this points, now your are a master in terms of blinking LED.  But there much more if you want to master embedded software skills. 
In the future I intend to do something similar to a serial port. However, for the time being, i suggest to chose an application that you are interested and start to learn the use those libraries/RTOSs.

## References and additional resources


 
