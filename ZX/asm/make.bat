@echo off

rem le ponemos el nombre al juego, máximo 9 caracteres
set nombre_juego=game

rem ensamblando

rem pasmo http://pasmo.speccy.org/
rem --tapbas genera un archivo.tap y le tienes que decir el archivo.asm
rem --public genera el archivo de listado de etiquetas
rem tools\assemblers\pasmo\pasmo.exe --name watchmen --tapbas src\main.asm main.tap --public
tools\assemblers\pasmo\pasmo.exe --name watchmen --tapbas src\pantalla.asm main.tap --public

rem sjasmplus: https://github.com/z00m128/sjasmplus
rem tools\assemblers\sjasmplus\windows\sjasmplus.exe --sym=obj/main.sym --lst=obj/main.lst src/main.asm 

rem Aunque no hacen falta copiamos todos los archivos.bas de la carpeta src
rem los pegamos en obj (objects) y mostramos un mensajito
rem for /R src %%a in (*.bas) do (
rem     copy "%%a" obj & echo %%a)

rem Le quitamos los comentarios a game.bas
rem java -jar tools/deletecomments/deletecomments1.2.jar src/main.bas obj/game.bas  
rem convertimos nuestro .bas en .tap
rem start /wait tools\bas2tap\bas2tap -c obj\game.bas -a10 -s%nombre_juego%

rem abrimos el emulador 

rem fuse command line= https://www.mankier.com/1/fuse#Synopsis
start /wait tools\emulators\fuse\fuse.exe --machine 48 --graphics-filter 2x --tape main.tap


