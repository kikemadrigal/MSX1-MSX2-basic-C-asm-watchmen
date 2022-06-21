
1 'Inicilizamos dispositivo: 003B, inicilizamos teclado: 003E'
10 cls:clear 500:defusr=&h003B:a=usr(0):defusr1=&h003E:a=usr1(0):defusr2=&H90:a=usr2(0)
1 'Enlazar con las rutinas de apagar y encender la pantalla'
20 defusr3=&H41:defusr4=&H44
1 ' color letra negro, fondo letra: azul claro, borde blanco, quitamos las letras que aparecen abajo'
30 color 1,15,11:key off
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
    10000 'restore
    1 'Vamos a cargar 4 sprites'
    1 ' Patrones:'
    10010 for i=0 to 14:sp$=""
        10020 for j=0 to 31
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
    1 '10080 for i=0 to 12:a$=""
    1 '    10090 for j=0 to (16)-1
    1 '        10100 read a$
    1 '        10110 sp$=sp$+chr$(val("&H"+a$))
    1 '        1 '10110 sp$=sp$+chr$(val(a$))
    1 '    10120 next j
    1 '    10130 color sprite$(i)=sp$
    1 '10140 next i

    1 'Es importante quitar el valor del color en put sprite'
    1 'put sprite pp,(px,py),,ps

    10200 REM kikefu
    10210 REM SPRITE DATA
    10220 DATA 0F,0F,3F,17,10,37,37,07
    10230 DATA 07,00,0F,17,02,02,02,03
    10240 DATA C0,C0,F0,C0,40,70,F0,20
    10250 DATA C0,00,E0,D0,40,40,60,70
    10260 DATA 0F,0F,3F,17,10,17,17,07
    10270 DATA 07,00,03,05,01,01,01,00
    10280 DATA C0,C0,F0,C0,40,70,F0,20
    10290 DATA C0,00,E0,E0,40,C0,20,80
    10300 DATA 03,03,0F,03,02,0E,0F,04
    10310 DATA 03,00,07,0B,02,02,06,0E
    10320 DATA F0,F0,FC,E8,08,EC,EC,E0
    10330 DATA E0,00,F0,E8,40,40,40,C0
    10340 DATA 03,03,0F,03,02,0E,0F,04
    10350 DATA 03,00,07,07,02,03,04,01
    10360 DATA F0,F0,FC,E8,08,E8,E8,E0
    10370 DATA E0,00,C0,A0,80,80,80,00
    10380 DATA 0F,0F,7F,07,07,0F,0F,0F
    10390 DATA 03,0B,0F,0F,07,07,03,07
    10400 DATA F0,F0,FE,E0,E0,F0,F0,F0
    10410 DATA C0,D0,F0,F0,E0,E0,C0,E0
    10420 DATA 0F,0F,7F,07,07,0F,07,07
    10430 DATA 03,03,07,0F,07,07,03,03
    10440 DATA F0,F0,FE,E0,E0,F0,E0,E0
    10450 DATA C0,C0,E0,F0,E0,E0,C0,C0
    10460 DATA 0F,0F,7F,07,04,04,1F,1F
    10470 DATA 0F,17,0B,07,01,00,00,00
    10480 DATA F0,F0,FE,C0,70,F0,F0,F0
    10490 DATA E0,C0,E0,F0,F8,F8,1C,3C
    10500 DATA 0F,0F,7F,03,0E,0F,0F,0F
    10510 DATA 07,03,07,0F,1F,1F,38,3C
    10520 DATA F0,F0,FE,E0,20,20,F8,F8
    10530 DATA F0,E8,D0,E0,80,00,00,00
    10540 DATA 03,07,07,07,3F,7F,73,79
    10550 DATA 78,7F,3F,3E,06,0C,08,0C
    10560 DATA C0,E0,A0,E0,20,E0,80,F0
    10570 DATA 10,F0,E0,40,40,60,30,00
    10580 DATA 00,03,07,07,07,3F,7F,7B
    10590 DATA 79,78,7F,3F,3E,06,02,03
    10600 DATA 00,C0,E0,A0,E0,20,E0,E0
    10610 DATA E0,30,F0,E0,40,40,40,60
    10620 DATA 03,07,05,07,04,07,01,0F
    10630 DATA 08,0F,07,02,02,06,0C,00
    10640 DATA C0,E0,E0,E0,FC,FE,CE,9E
    10650 DATA 1E,FE,FC,7C,60,30,10,30
    10660 DATA 00,03,07,05,07,04,07,07
    10670 DATA 07,0C,0F,07,02,02,02,06
    10680 DATA 00,C0,E0,E0,E0,FC,FE,DE
    10690 DATA 9E,1E,FE,FC,7C,60,40,C0
    10700 DATA 00,00,00,00,00,00,00,00
    10710 DATA 1C,10,71,5D,7F,1D,1F,07
    10720 DATA 00,00,00,00,00,00,00,00
    10730 DATA 00,9C,76,5E,7E,FE,BC,00
    10740 DATA 00,00,00,FF,FF,AB,FF,AB
    10750 DATA FF,AB,FF,AB,FF,AB,FF,AB
    10760 DATA 00,00,00,FF,FF,D5,FF,D5
    10770 DATA FF,D5,FF,D5,FF,D5,FF,D5
    10780 DATA 00,FF,FF,FF,FF,FF,FF,FF
    10790 DATA 00,FF,FF,FF,FF,FF,FF,FF
    10800 DATA FF,FF,FF,FF,FF,FF,FF,FF
    10810 DATA FF,FF,FF,FF,FF,FF,FF,FF


12990 return


