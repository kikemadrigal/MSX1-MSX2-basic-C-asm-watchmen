
rem para desactivar los mensajes de los programas
@echo off
rem /********Estructura proyecto***********************************/
rem src=archivos .bas y .asm con el código fuente
rem obj=archivos generados por los archivos del código fuente y procesados
rem tools=herramientas o programas de ayuda
rem dsk=simula una unidad de disco para MSX-DOS

rem /************Compilando a ensamblador******************/
rem glass compiler (http://www.grauw.nl/projects/glass/) es un compilador de ensamblador z80 que puedo convertir tu código ensamblador en los archivos binarios.rom y .bin
java -jar  tools\assemblers\glass\glass-0.5.jar src\main.asm obj\main.bin obj\main.sym

rem sjasmplus: https://github.com/z00m128/sjasmplus
rem tools\assemblers\sjasmplus\windows\sjasmplus.exe --sym=obj/main.sym --lst=obj/main.lst src/main.asm 

rem asMSX: https://github.com/Fubukimaru/asMSX
rem tools\assemblers\asMSX\win32\asmsx.exe src\main.asm
rem move /Y src\main.cas ./obj
rem move /Y src\main.wav ./obj

rem pasmo http://pasmo.speccy.org/
rem tools\assemblers\pasmo\pasmo.exe pasmo.bin

rem /************Preparando archivos******************/
rem move /Y main.bin ./obj
rem move /Y main.lst ./obj
rem move /Y main.sym ./obj
rem del /F src/main.lst

rem /************creando carpeta dsk******************/
for /R obj/ %%a in (*.bin) do (
        copy "%%a" dsk)   


rem /************Creando el .dsk******************/

rem /************Diskmanager******************/
rem Añadiendo archivos al .dsk, tenemos que crear antes el archivo disco.dsk con el programa disk manager
rem para ver los comandos abrir archivo DISKMGR.chm
rem AUTOEXEC.BAS es un archivo basic con el comando bload que hará que se autoejecute el main.bas
rem start /wait tools\Disk-Manager\DISKMGR.exe -A -F -C main.dsk src/autoexec.bas 
rem main.bas contiene mi código fuente
rem start /wait tools\Disk-Manager\DISKMGR.exe -A -F -C main.dsk src/main.bas

rem /***********Abriendo el emulador***********/

rem/************openMSX******************/
rem presiona f9 al arrancar para que vaya rápido
start /wait tools\emulators\openmsx\openmsx.exe -machine Philips_NMS_8255 -diska dsk/
rem Abriendo con FMSX https://fms.komkon.org/fMSX/fMSX.html
rem start /wait emulators/fMSX/fMSX.exe -diska main.dsk
