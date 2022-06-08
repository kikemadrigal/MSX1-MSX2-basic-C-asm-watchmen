#!/bin/bash

#Compiladores
## glass compiler: http://www.grauw.nl/projects/glass/
#java -jar  tools/assemblers/glass/glass-0.5.jar src/main.asm obj/main.bin obj/main.lst

## sjasmplus: https://github.com/z00m128/sjasmplus
./tools/assemblers/sjasmplus/mac/sjasmplus --raw=obj/main.bin  --sym=obj/main.sym --lst=obj/main.lst src/main.asm 

# Preparando archivos
mv obj/main.bin dsk/main.bin

# abriendo emulador
##openMSX
./tools/emulators/openmsx/mac/openMSX.app/Contents/MacOS/openmsx -script ./tools/emulators/openmsx/emul_start_config.txt