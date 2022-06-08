
1 'Inicilizamos dispositivo: 003B, inicilizamos teclado: 003E'
10 defusr=&h003B:a=usr(0):defusr1=&h003E:a=usr1(0):defusr2=&H90:a=usr2(0)
20 defusr3=&H41:defusr4=&H44
1 ' color letra negro, fondo letra: azul claro, borde blanco, quitamos las letras que aparecen abajo'
30 color 1,15,15:key off:defint a-z
40 screen 2,2,0
50 open "grp:" as #1
60 'print #1,"Loading xbasic"
70 'bload"xbasic.bin",r
80 print #1,"Loading sprites"
1 'Cargamos los sprites'
90 gosub 10000
100 'print #1,"Loading tilemap word 0"
110 'dim mf(512,9):gosub 11100
120 print "Cargando tilset y mapa"
130 bload"tileset.bin",s
140 bload "world0.bin",r
1 'Metemos el mapa en la VRAM'
150 gosub 11330
500 'print #1,"Loading game"
510 load"game.bas",r



1 '---------------------------------------------------------'
1 '------------------------Carga de srites------------------'
1 '---------------------------------------------------------'


1 ' Patrones:'
1 'Plano 0. Player--sprites del 1 al 7'
1 'Rutina cargar sprites con datas basic'
    10000 RESTORE
    1 ' vamos a meter 5 definiciones de sprites nuevos que serán 4 para el personaje y uno para la bola'
    10010 FOR I=0 TO 5:SP$=""
        10020 FOR J=1 TO 32:READ A$
            10025 SP$=SP$+CHR$(VAL("&H"+A$))
        10030 NEXT J
        10040 SPRITE$(I)=SP$
    10050 NEXT I
    10060 return 
    10120 DATA 0F,0F,7F,1F,28,67,77,37
    10130 DATA 37,03,07,0F,1F,1F,38,3C
    10140 DATA F0,F0,FE,E0,20,20,F8,F8
    10150 DATA F8,F8,C0,FC,E0,F8,E0,F0

    10160 DATA 0F,0F,7F,1F,28,67,77,37
    10170 DATA 37,03,07,0F,1F,1F,07,07
    10180 DATA F0,F0,FE,E0,20,20,F8,F8
    10190 DATA F8,F8,C0,FC,E0,F8,38,BC

    10200 DATA 0F,0F,7F,07,04,04,1F,1F
    10210 DATA 1F,1F,03,3F,07,1F,07,0F
    10220 DATA F0,F0,FE,F8,14,E6,EE,EC
    10230 DATA EC,C0,E0,F0,F8,F8,1C,3C

    10240 DATA 0F,0F,7F,07,04,04,1F,1F
    10250 DATA 1F,1F,03,3F,07,1F,1C,3D
    10260 DATA F0,F0,FE,F8,14,E6,EE,EC
    10270 DATA EC,C0,E0,F0,F8,F8,E0,E0

    10280 DATA 00,07,1F,0F,0F,0F,07,03
    10290 DATA 03,03,1F,17,07,07,06,06
    10300 DATA 00,E0,F8,F0,F0,F0,E0,C0
    10310 DATA D0,D0,F0,E0,E0,E0,70,70

    10320 DATA 00,07,1F,0F,0F,0F,07,03
    10330 DATA 13,13,1F,07,07,07,0C,0C
    10340 DATA 00,E0,F8,F0,F0,F0,E0,C0
    10350 DATA C0,C0,F8,E8,E0,E0,60,60
11590 return



1 '1 'Cargar mundo con los mapas de los niveles en el buffer o array'
1 '    11100 bload"world0.bin",r
1 '    11110 md=&hc001
1 '    11120 for i=0 to mm-1
1 '        1 'Esto se podría poner desde 0 hasta 512'
1 '        11130 for j=0 to 511
1 '            11140 tn=peek(md):md=md+1
1 '            11150 mf(j,i)=tn
1 '        11170 next j
1 '    11180 next i
1 '11190 return



1 'Cargar mapa de disco y meterlo en la VRAM
    11330 md=&hd001
    11350 for j=6144 to 6912
            1 'Como los tiles los habíamos cargado previamente en RAM ahora solo los pasamos a VRAM'
            11360 vpoke j,peek(md)
            11370 md=md+1
    11380 next j  
11490 return