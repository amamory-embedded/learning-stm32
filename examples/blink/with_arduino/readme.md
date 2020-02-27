# Blink with Arduino and stm32duino

## Depedencies:

This particular example depends on [stm32duino v1.8.0](https://github.com/stm32duino/Arduino_Core_STM32/releases/tag/1.8.0)
, available at https://github.com/stm32duino/wiki/wiki.
Please follow the instalation procedure and test it with a blink app using arduino IDE.
It also depends on [arduino-cli v0.9.0](https://github.com/arduino/arduino-cli/releases/tag/0.9.0) or newer.

## Compilation of stm32duino with arduino-cli

I managed to compile this app with arduino-cli, following these [instructions](https://stm32duinoforum.com/forum/viewtopic_f_41_t_4052.html) in
with some adaptations and also this [issue](https://github.com/arduino/arduino-cli/issues/355).

To compile the sketch, execute:

'''
$ arduino-cli compile -v -b STM32:stm32:GenF1:pnum=BLUEPILL_F103C8
'''

## Uploading of stm32duino with arduino-cli

Once the sketch is compiled, the expected upload command was:

'''
$ arduino-cli upload -p /dev/ttyACM0 -b STM32:stm32:GenF1:pnum=BLUEPILL_F103C8
'''

However, it will cause a error because there is no Blink.STM32.stm32.GenF1.bin in the current folder.

'''
Opening and parsing file: Blink.STM32.stm32.GenF1.bin
Error: The file Blink.STM32.stm32.GenF1.bin does not exist, please check the file's path
'''

So, there are two alternatives. The first alternative is to find out the place in the /tmp where the project is being built and just copy the bin file
from there to the current dir, using the name Blink.STM32.stm32.GenF1.bin.
The second alternative is to create a bin file from the elf file using the following command:

'''
$(HOME).arduino15/packages/STM32/tools/xpack-arm-none-eabi-gcc/9.2.1-1.1/bin/arm-none-eabi-objcopy Blink.STM32.stm32.GenF1.elf -O binary Blink.STM32.stm32.GenF1.bin
'''

Now, repeat the upload, execute:

'''
$ arduino-cli upload -p /dev/ttyACM0 -b STM32:stm32:GenF1:pnum=BLUEPILL_F103C8
'''

and hopefully you will see the LED blinking and no up errors.

Since arduino-cli is still barely documented, I decided to place here few additional commands that mmight be hepfull:

- To clean. However it does not clean the sketch dir.


'''
$ arduino-cli cache clean
'''

- list the supported boards

'''
$ arduino-cli board listall
'''

- list details of a specific board

'''
$ arduino-cli board details STM32:stm32:GenF1:pnum=BLUEPILL_F103C8
'''

- list an even more detailed list of all the compilation properties of a specific board

'''
$ arduino-cli compile -v -b STM32:stm32:GenF1:pnum=BLUEPILL_F103C8 --show-properties
'''


- alternatives ways to upload

'''
$ STM32_Programmer.sh -c port=SWD -e all -d  Blink.STM32.stm32.GenF1.bin 0x8000000 -v
$ arduino-cli upload -p /dev/ttyACM0 -b STM32:stm32:GenF1:pnum=BLUEPILL_F103C8 -i /tmp/arduino-sketch-0E2561A4A3EC64AB31B1A2C87B9880F4/Blink.ino
'''

## To Do:

I would like also to use a makefile for compiling this app for stm32duino, however i had no succes so far.
I have tried [Arduino-Makefile](https://github.com/sudar/Arduino-Makefile).
Although it works really well for the original arduino boards, it requires several adaptations to work with stm32duino.
