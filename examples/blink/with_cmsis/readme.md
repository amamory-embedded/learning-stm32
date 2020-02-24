readme.md

cd ../../examples/blink/with_cmsis
make -f ../../../config/common.mk all
make -f ../../../config/common.mk flash

## compiling with -lto

$ python /home/lsa/Downloads/linker-map-summary-master/analyze_map.py main.map
linker stubs                             	      0  (code: 0 data: 0)
/opt/gcc-arm/lib/gcc/arm-none-eabi/9.2.1/thumb/v7-m/nofp/crti.o 	     37  (code: 0 data: 37)
startup.o                                	    514  (code: 176 data: 338)
/tmp/main.elf.gt0XTm.ltrans0.ltrans.o    	   1232  (code: 68 data: 1164)
/tmp/ccMmyAvz.debug.temp.o               	   1669  (code: 0 data: 1669)
TOTAL 3452  (code: 244 data: 3208)

## compiling without -lto

$ python /home/lsa/Downloads/linker-map-summary-master/analyze_map.py main.map
linker stubs                             	      0  (code: 0 data: 0)
/opt/gcc-arm/lib/gcc/arm-none-eabi/9.2.1/thumb/v7-m/nofp/crti.o 	     37  (code: 0 data: 37)
startup.o                                	    514  (code: 176 data: 338)
main.o                                   	   2419  (code: 76 data: 2343)
TOTAL 2970  (code: 252 data: 2718)

