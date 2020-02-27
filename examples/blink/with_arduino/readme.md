# Blink with Arduino and stm32duino

## Depedencies:

This particular example depends on [stm32duino v1.8.0](https://github.com/stm32duino/Arduino_Core_STM32/releases/tag/1.8.0)
, available at https://github.com/stm32duino/wiki/wiki.
Please follow the instalation procedure and test it with a blink app using arduino IDE.

## To Do:

I would like to use a CLI for compiling this app for stm32duino, however i had no succes so far. I have tried:

- https://github.com/sudar/Arduino-Makefile
Although it works really well for the original arduino boards, it requires several adaptations to work with stm32duino.

- arduino-cli

I managed to compile this app with arduino-cli, following the instructions in https://stm32duinoforum.com/forum/viewtopic_f_41_t_4052.html
with some adaptations. For example, if you type
'''
	$ arduino-cli board listall
'''
you see the stm32 boards listed. Then I compiled the sketch with
'''
	$ arduino-cli compile -v -b STM32:stm32:GenF1
'''
and tried to upload with
'''
	$ STM32_Programmer.sh -c port=SWD -e all -d  <bin file> 0x8000000 -v
'''
no error happens, but there is no blinking LED. However, if I compiled it using Arduino GUI, it works.
After investigating a bit, I have seem that the objs files inserted into the elf files are diffent.
when I compare with arduino-cli and arduino GUI, suggesting that somehow they set different compilation parameter, leading to this error.