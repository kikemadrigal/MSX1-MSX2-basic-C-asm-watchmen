
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
60 'print #1,"Loading xbasic"
70 'bload"xbasic.bin",r
1 'Cargamos la imagen de carga'
80 bload"loader.S05",s
1 'Cargamos los sprites'
90 print #1,"Loading sprites"
100 gosub 10000
110 'print #1,"Loading tilemap word 0"
120 'dim mf(512,9):gosub 11100
130 print #1,"Cargando tilset en page 1"
140 bload"tileset.S05",s,32768
150 print #1,"Cargando mapa en RAM en page 2"
160 gosub 20300
500 'print #1,"Loading game"
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

20300 restore 21000
20310 FOR T=0 TO 22:READ H$:co=0
    20320 FOR I=0 TO len(H$) STEP 4
        1 'Obtenemos las repeticiones'
        20330 R=VAL("&H"+MID$(H$,I+1,2))   
        1 'Obtenemos el valor'     
        20340 O=VAL("&H"+MID$(H$,I+3,2))
        20350 FOR J=0 TO R
            1 ' repetimos el valor tantas veces como indique R'
            20360 tn=O-1
            20370 if tn >=0 and tn <32 then copy (tn*8,0)-((tn*8)+8,8),1 to (co*8,T*8),2,tpset
            20380 if tn >=32 and tn <64 then copy ((tn-32)*8,8)-(((tn-32)*8)+8,8),1 to (co*8,T*8),2,tpset
            20390 if tn >=32 and tn <64 then copy ((tn-32)*8,1*8)-(((tn-32)*8)+8,(1*8)+8),1 to (co*8,T*8),2,tpset
            20400 if tn >=64 and tn <96 then copy ((tn-64)*8,2*8)-(((tn-64)*8)+8,(2*8)+8),1 to (co*8,T*8),2,tpset
            20410 if tn>=96 and tn <128 then copy ((tn-96)*8,3*8)-(((tn-96)*8)+8,(3*8)+8),1 to (co*8,T*8),2,tpset
            20420 if tn>=128 and tn <160 then copy ((tn-128)*8,4*8)-(((tn-128)*8)+8,(4*8)+8),1 to (co*8,T*8),2,tpset
            20430 if tn>=160 and tn <192 then copy ((tn-160)*8,5*8)-(((tn-160)*8)+8,(5*8)+8),1 to (co*8,T*8),2,tpset
            20440 if tn>=192 and tn <224 then copy ((tn-192)*8,6*8)-(((tn-192)*8)+8,(6*8)+8),1 to (co*8,T*8),2,tpset
            20450 if tn>=224 and tn <256 then copy ((tn-224)*8,7*8)-(((tn-224)*8)+8,(7*8)+8),1 to (co*8,T*8),2,tpset
            20455 co=co+1
        20460 NEXT J
    20470 next I
20490 next T  
20499 return                  



1' Size=1290
21000 data 02000006000701000009000a0800000600070b00
21010 data 02000026002701000029002a08000026002701000028060000650066
21020 data 0200002600270004000508000004000500260027030000010002030000850086
21030 data 0200002600270024002508000024002500260027030000210022030000a500a6
21040 data 01e102e200c100c20ce200c100c209e2
21050 data 040000c100c20006000702000009000a050000c100c20100000600070500
21060 data 040000c100c20026002702000029002a050000c100c20100002600270500
21070 data 040000c100c20026002706000028020000c100c20100002600270500
21080 data 000000040005010000c100c2002600270a0000c100c2010000260027030000040005
21090 data 000000240025010000c100c2002600270a0000c100c2010000260027030000240025
21100 data 09e100c100c212e100e200
21110 data 030000060007030000c100c205000006000701000009000a0700
21120 data 030000260027030000c100c20200002801000026002701000029002a0700
21130 data 030000260027030000c100c20500002600270b00
21140 data 000000040005000000260027030000c100c20500002600270600000100020200
21150 data 000000240025000000260027030000c100c20500002600270600002100220200
21160 data 05e100c100c209e100e201e100c100c203e100e202e100e2
21170 data 050000c100c204000006000701000009000a010000c100c20300000600070200
21180 data 01000028020000c100c204000026002701000029002a010000c100c202000028002600270200
21190 data 050000c100c2040000260027050000c100c20300002600270200
21200 data 050000c100c202000001000200260027050000c100c2030000260027000000040005
21210 data 050000c100c202000021002200260027050000c100c2030000260027000000240025
21220 data 1ee100e2




1 '1 'Cargamos screen en page 2
1 '    20300 restore 21000
1 '    1 'md=mapa dirección, la dirección d001 se la he puesto yo en el archivo binario cuando lo creé'
1 '      1 'El archivo tan solo contiene los datos de la definición de los mapas'
1 '    20304 'bload "world0.bin",r:md=&hd001
1 '    1 'ahora leemos las filas o la posición x
1 '    1 '23 del 0-22 filas'
1 '    1 '32 columnas del 0-31'
1 '    20310 for f=0 to 22:read fi$
1 '    1 'ahora leemos las columnas c o la posicion y
1 '        20320 for c=0 to len(fi$) step 2
1 '            20321 tn$=mid$(fi$,c+1,2)
1 '            20325 tn=val("&h"+tn$)
1 '            20326 tn=tn-1
1 '            20380 if tn >=0 and tn <32 then copy (tn*8,0)-((tn*8)+8,8),1 to ((c*8)/2,f*8),2,tpset
1 '            20390 if tn >=32 and tn <64 then copy ((tn-32)*8,8)-(((tn-32)*8)+8,16),1 to ((c*8)/2,f*8),2,tpset
1 '            20390 if tn >=32 and tn <64 then copy ((tn-32)*8,1*8)-(((tn-32)*8)+8,(1*8)+8),1 to ((c*8)/2,f*8),2,tpset
1 '            20400 if tn >=64 and tn <96 then copy ((tn-64)*8,2*8)-(((tn-64)*8)+8,(2*8)+8),1 to ((c*8)/2,f*8),2,tpset
1 '            20410 if tn>=96 and tn <128 then copy ((tn-96)*8,3*8)-(((tn-96)*8)+8,(3*8)+8),1 to ((c*8)/2,f*8),2,tpset
1 '            20420 if tn>=128 and tn <160 then copy ((tn-128)*8,4*8)-(((tn-128)*8)+8,(4*8)+8),1 to ((c*8)/2,f*8),2,tpset
1 '            20430 if tn>=160 and tn <192 then copy ((tn-160)*8,5*8)-(((tn-160)*8)+8,(5*8)+8),1 to ((c*8)/2,f*8),2,tpset
1 '            20440 if tn>=192 and tn <224 then copy ((tn-192)*8,6*8)-(((tn-192)*8)+8,(6*8)+8),1 to ((c*8)/2,f*8),2,tpset
1 '            20450 if tn>=224 and tn <256 then copy ((tn-224)*8,7*8)-(((tn-224)*8)+8,(7*8)+8),1 to ((c*8)/2,f*8),2,tpset
1 '        20460 next c
1 '    20470 next f
1 '20490 return

1 'Size=1690'
1 '21000 data 00000006070000090a0000000000000000000607000000000000000000000000
1 '21010 data 00000026270000292a0000000000000000002627000028000000000000006566
1 '21020 data 0000002627040500000000000000000004052627000000000102000000008586
1 '21030 data 000000262724250000000000000000002425262700000000212200000000a5a6
1 '21040 data e1e1e2e2e2c1c2e2e2e2e2e2e2e2e2e2e2e2e2e2c1c2e2e2e2e2e2e2e2e2e2e2
1 '21050 data 0000000000c1c20607000000090a000000000000c1c200000607000000000000
1 '21060 data 0000000000c1c22627000000292a000000000000c1c200002627000000000000
1 '21070 data 0000000000c1c226270000000000000028000000c1c200002627000000000000
1 '21080 data 0004050000c1c226270000000000000000000000c1c200002627000000000405
1 '21090 data 0024250000c1c226270000000000000000000000c1c200002627000000002425
1 '21100 data e1e1e1e1e1e1e1e1e1e1c1c2e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e2
1 '21110 data 00000000060700000000c1c200000000000006070000090a0000000000000000
1 '21120 data 00000000262700000000c1c200000028000026270000292a0000000000000000
1 '21130 data 00000000262700000000c1c20000000000002627000000000000000000000000
1 '21140 data 00040500262700000000c1c20000000000002627000000000000000102000000
1 '21150 data 00242500262700000000c1c20000000000002627000000000000002122000000
1 '21160 data e1e1e1e1e1e1c1c2e1e1e1e1e1e1e1e1e1e1e2e1e1c1c2e1e1e1e1e2e1e1e1e2
1 '21170 data 000000000000c1c2000000000006070000090a0000c1c2000000000607000000
1 '21180 data 000028000000c1c2000000000026270000292a0000c1c2000000282627000000
1 '21190 data 000000000000c1c200000000002627000000000000c1c2000000002627000000
1 '21200 data 000000000000c1c200000001022627000000000000c1c2000000002627000405
1 '21210 data 000000000000c1c200000021222627000000000000c1c2000000002627002425
1 '21220 data e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e2






