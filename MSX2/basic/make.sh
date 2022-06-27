#!/bin/bash

#Borramos todos los archivos que hay en obj
OBJFILES=$(find "./obj" -type f)
for i in ${OBJFILES[*]}; do
    rm $i
    #echo $i
done

#We get and compress files asm, then copy on folder bin
#El archivo sjasm es solo para sistemas de 32 bits, pone en el termianl file sjasm y lo verás

tools/sjasm42c/sjasm ./src/world0.asm
tools/sjasm42c/sjasm ./src/world1.asm
tools/sjasm42c/sjasm ./src/musicint.asm
mv world0.bin ./bin
mv world1.bin ./bin
mv musicint.bin ./obj

#remove comments
#grep -v "^1 '" main.bas > main-temp.bas
# Covertimos CR+LF a LF para que se puedan leer en linux, son los saltos de línea


# rem Le quitamos los comentarios,espacios en blanco al main y o ponemos en obj
java -jar tools/deletecomments1.4/deletecomments1.4.jar src/main.bas obj/game.bas  
#unix2dos obj/game.bas

#Copiamos todos los archivos.bas de la carpeta src a la carpeta obj
SRCFILES=$(find "./src" -iname *.bas -type f)
for i in ${SRCFILES[*]}; do
    #cat $i >> ./${OBJ}/game.bas
    cp $i ./obj
    #echo $i
done
#Los formateamos al modelo linux
# sudo apt install dos2unix, el programa unix2dos está dentro de dos2unix
BASONOBJFOLDER=$(find "./obj" -iname *.bas -type f)
for i in ${BASONOBJFOLDER[*]}; do
    unix2dos $i
done
#Copiamos todos los archivos de la carpta bin a la carpeta obj
BINFILES=$(find "./bin" -type f)
for i in ${BINFILES[*]}; do
    cp $i ./obj
    #echo $i
done



#rm "${BASFILE}"

tools/emulators/openmsx-15.0/openmsx -script tools/emulators/openmsx-16.0/emul_start_config.txt
