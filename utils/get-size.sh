#!/bin/bash
# source https://interrupt.memfault.com/blog/best-firmware-size-tools

if [  $# -le 2 ]
then
    echo "This script requires 3 arguments."
    echo -e "\nUsage:\nget-size FILE MAX_FLASH_SIZE MAX_RAM_SIZE [-lib]\n"
    exit 1
fi

file=$1
max_flash=$2
max_ram=$3
is_lib=$4

if [ ! -f $file ] ; then
    echo "ERROR: file $file not found !"
    exit 1
fi

function print_region() {
    size=$1
    max_size=$2
    name=$3

    if [[ $max_size == 0x* ]];
    then
        max_size=$(echo ${max_size:2})
        max_size=$(( 16#$max_size ))
    fi

    pct=$(( 100 * $size / $max_size ))
    echo "$name used: $size / $max_size ($pct%)"
}

raw=""
text=0
data=0
bss=0

# if the 4th parameter is not defined, the it is an elf file
if [ ! -z $is_lib ];
then
    # if this is a static library, then it is necessary to sum up text, data, and bss of each object
    text=$(arm-none-eabi-size -d -G $file | awk '{s+=$1} END {printf s}')
    data=$(arm-none-eabi-size -d -G $file | awk '{s+=$2} END {printf s}')
    bss=$(arm-none-eabi-size  -d -G $file | awk '{s+=$3} END {printf s}')
else
    # if this is a elf file, then it simpler to extract text, data, and bss
    raw=$(arm-none-eabi-size $file)
    text=$(echo $raw | cut -d ' ' -f 7)
    data=$(echo $raw | cut -d ' ' -f 8)
    bss=$(echo $raw  | cut -d ' ' -f 9)
fi

flash=$(($text + $data))
ram=$(($data + $bss))

print_region $flash $max_flash "Flash"
print_region $ram $max_ram "RAM"

