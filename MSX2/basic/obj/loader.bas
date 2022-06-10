
1 'Inicilizamos dispositivo: 003B, inicilizamos teclado: 003E'
10 cls:defusr=&h003B:a=usr(0):defusr1=&h003E:a=usr1(0):defusr2=&H90:a=usr2(0)
1 'Enlazar con las rutinas de apagar y encender la pantalla'
20 defusr3=&H41:defusr4=&H44
1 ' color letra negro, fondo letra: azul claro, borde blanco, quitamos las letras que aparecen abajo'
30 color 1,15,15:key off
1 'Nos ponemos en modo screen 5, sprites de 16x16pixeles y quitamos el sonido de las teclas'
40 screen 5,2,0:defint a-z
1 'Abrimos un canal para poder escribir'
50 open "grp:" as #1
1 'Cargamos la imagen de carga'
80 bload"loader.S05",s
1 'Cargamos los sprites'
90 print #1,"Loading sprites"
100 gosub 10000
130 print #1,"Cargando tilset en page 1"
140 bload"tileset.S05",s,32768
220 preset(0,2*8):print #1,"Loading game"
230 print #1,"Loading xbasic"
240 bload"xbasic.bin",r
510 load"game.bas",r



1 '---------------------------------------------------------'
1 '------------------------Carga de srites------------------'
1 '---------------------------------------------------------'
            1'10075 'vpoke &h7400+i, a


1 'Rutina cargar sprites con datas basic'
    10000 restore
    1 'Vamos a cargar 4 sprites'
    1 ' Patrones:'
    10010 for i=0 to 3:sp$=""
        10020 for j=1 to 32
            10030 read a$
            1 'Val transforma en entero los 3 primeros caracteres numéricos'
            1 'Sistema hexadecimal
            10040 sp$=sp$+chr$(val("&H"+a$))
            1 'Sistema decimal'
             1 '10040 sp$=sp$+chr$(val(a$))
        10050 next J
        10060 sprite$(i)=sp$
    10070 next I
    1 'Color patrones'
    10080 for i=0 to 3:a$=""
        10090 for j=0 to (16)-1
            10100 read a$
            10110 sp$=sp$+chr$(val("&H"+a$))
            1 '10110 sp$=sp$+chr$(val(a$))
        10120 next j
        10130 color sprite$(i)=sp$
    10140 next i

    1 'Es importante quitar el valor del color en put sprite'
    1 'put sprite pp,(px,py),,ps

    1 '10200 REM kikefu
    1 '10210 REM SPRITE DATA
    1 '10220 DATA 15,15,63,23,16,55,55,7
    1 '10230 DATA 7,0,15,23,2,2,2,3
    1 '10240 DATA 192,192,240,192,64,112,240,32
    1 '10250 DATA 192,0,224,208,64,64,96,112

    1 '10260 DATA 15,15,63,23,16,23,23,7
    1 '10270 DATA 7,0,3,5,4,9,13,0
    1 '10280 DATA 192,192,240,192,64,112,240,32
    1 '10290 DATA 192,0,224,224,64,192,0,128

    1 '10300 DATA 3,3,15,3,2,14,15,4
    1 '10310 DATA 3,0,7,11,2,2,6,14
    1 '10320 DATA 240,240,252,232,8,236,236,224
    1 '10330 DATA 224,0,240,232,64,64,64,192

    1 '10340 DATA 3,3,15,3,2,14,15,4
    1 '10350 DATA 3,0,7,7,2,3,0,1
    1 '10360 DATA 240,240,252,232,8,232,232,224
    1 '10370 DATA 224,0,192,160,32,144,176,0
    1 '

    1 '10740 REM COLOR MODE2 DATA
    1 '10750 DATA 6,6,6,9,9,9,9,9
    1 '10760 DATA 9,10,5,5,5,5,4,4

    1 '10770 DATA 6,6,6,9,9,9,9,9
    1 '10780 DATA 9,9,5,5,5,5,4,4

    1 '10790 DATA 6,6,6,9,9,9,9,9
    1 '10800 DATA 9,10,5,5,5,5,4,4

    1 '10810 DATA 6,6,6,9,9,9,9,9
    1 '10820 DATA 9,10,5,5,5,5,4,4
    
    10200 REM kikefu
    10210 REM SPRITE DATA
    10220 DATA 0F,0F,3F,17,10,37,37,07
    10230 DATA 07,00,0F,17,02,02,02,03
    10240 DATA C0,C0,F0,C0,40,70,F0,20
    10250 DATA C0,00,E0,D0,40,40,60,70

    10260 DATA 0F,0F,3F,17,10,17,17,07
    10270 DATA 07,00,03,05,04,09,0D,00
    10280 DATA C0,C0,F0,C0,40,70,F0,20
    10290 DATA C0,00,E0,E0,40,C0,00,80

    10300 DATA 03,03,0F,03,02,0E,0F,04
    10310 DATA 03,00,07,0B,02,02,06,0E
    10320 DATA F0,F0,FC,E8,08,EC,EC,E0
    10330 DATA E0,00,F0,E8,40,40,40,C0

    10340 DATA 03,03,0F,03,02,0E,0F,04
    10350 DATA 03,00,07,07,02,03,00,01
    10360 DATA F0,F0,FC,E8,08,E8,E8,E0
    10370 DATA E0,00,C0,A0,20,90,B0,00

    10740 REM COLOR MODE2 DATA
    10750 DATA 06,06,06,09,09,09,09,09
    10760 DATA 09,0A,05,05,05,05,04,04

    10770 DATA 06,06,06,09,09,09,09,09
    10780 DATA 09,09,05,05,05,05,04,04

    10790 DATA 06,06,06,09,09,09,09,09
    10800 DATA 09,0A,05,05,05,05,04,04

    10810 DATA 06,06,06,09,09,09,09,09
    10820 DATA 09,0A,05,05,05,05,04,04
10990 return


