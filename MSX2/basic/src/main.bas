1 ' ahorro con RLE'
1 'Level 0=1690-1290=400'
1 'Level 1=1502-1215=287'
1 'Level 2=1495-959=536'
1 'Level 3=1495-355=1140, en esta pantalla los tiles se repiten mucho
80 defint a-z
90 'gosub 11000
95 'preset (0,8*3):print #1,"Cagando mapa a page 0!!"
1'metemos en la VRAM page 2 el level 1 y mostramos el level 0 
100 gosub 20300:gosub 20100
1 'Inicializamos el personaje'
130 gosub 5000
1 'Rutina barra espaciadora pulsada
520 strig(0) on:on strig gosub 5200
1 'Mostramos la información en pantalla'
530 'gosub 2900
1 ' ----------------------'
1 '      MAIN LOOP
1 ' ----------------------'
    1 'render player, el update lo hacemos en el sistema de input'
    2000 gosub 5100
    1 'Capturamos las teclas'
    2010 gosub 2500
    1 'Chekeo del mapa'
    2020 'gosub 3100
    2030 if mc=1 then mc=0: preset(40,100):print #1,"Mission complete!!":gosub 20300:gosub 20100
2090 goto 2000
1 ' ----------------------'
1 '    FINAL MAIN LOOP
1 ' ----------------------'





1 'Reproductor de efectos d sonido'
    2300 a=usr2(0)
    2310 if re=1 then PLAY"O5 L8 V4 M8000 A A D F G2 A A A A r60 G E F D C D G R8 A2 A2 A8","o1 v4 c r8 o2 c r8 o1 v6 c r8 o2 v4 c r8 o1 c r8 o2 v6 c r8"
    1 'Tirando el paquete'
    2350 if re=5 then play "l10 o4 v4 g c"
    1 'Paquete cogido'
    2360 if re=6 then play"t250 o5 v12 d v9 e" 
    1 'Pitido normal'
    2370 if re=7 then play "O5 L8 V4 M8000 A A D F G2 A A A A"
    1 'Toque fino'
    2380 if re=8 then PLAY"S1M2000T150O7C32"
    1 'Pasos'
    2390 if re=9 then PLAY"o2 l64 t255 v10 m6500 c"
    2400 if re=10 then sound 6,5:sound 8,16:sound 12,6:sound 13,9
2420 return

1 ' ----------------------'
1 '     INPUT SYSTEM'
1 ' ----------------------'
1 '1 ' 1 Sistema de Input
1 '    1'1 Arriba, 2 arriba derecha, 3 derecha, 4 abajo derecha, 5 abajo, 6 abajo izquierda, 7 izquierda, 8 izquierda arriba
1 '    2500 j=stick(0)
1 '    2520 if j=0 then ps=1
1 '    2530 if j=3 then px=px+pv:ps=4:if co mod 2=0 then ps=ps+1
1 '    2540 if j=7 then px=px-pv:ps=6:if co mod 2=0 then ps=ps+1
1 '    2550 if j=1 then py=py-pv:ps=2:if co mod 2=0 then ps=ps+1
1 '    2560 if j=5 then py=py+pv:ps=2:if co mod 2=0 then ps=ps+1
1 '2590 return

1 '2 Sistema de input'
    1 'Nos guardamos las posiciones del player antes de cambiarlas'
    2500 on stick(0) gosub 2700,2500,2600,2500,2800,2500,2640

    1 'Rutina salto va junto a la línea 120 y subrutina 5200'
    2520 if pa=1 then py=py-pj
    1 '1 '10 es la distancia máxima a la que puede saltar'
    2530 if pa=1 and py<po-10 then pj=-pj
    2540 if pa=1 and py>po then py=po:pj=0:pj=-pj:pa=0:strig(0)on
    1 'Escaneando suelo con point'
    1 '2541 'if point(px+8,py+16+1)<>3 then py=py+pv

    1 'Chequeo contorno con array mapa'
    2590 gosub 3100
    1 'Chequeo escalera-> ver línea 2710

    1 'Chequeo suelo'
    2592 if pa=0 and t5=255 then py=py+pv

    1 'Chequeo limites screen'
    2590 if py>180 then py=180
2599 return
1 're=8 es el efecto de sonido 8 de la rutina de reprodución de sonidos 2300
1 '3 derecha'
    2600 px=px+pv
    2610 swap p(0),p(1):ps=p(1)
    2620 'gosub 2900
    1 '2620 if px mod 2=0 then ps=ps+1
2630 return
1 '7 izquierda'
    2640 px=px-pv
    2650 swap p(2),p(3):ps=p(3)
    2651 'gosub 2900
    1 '2572 if px mod 2=0  then ps=ps+1
2660 return
1 '1 Arriba'
    2700 beep:'gosub 2900:'pset(px+8,py-1),13
    1 '2710 if point(px+8,py-1)=8 or point(px+8,py+16+1)=8 then ps=p(4):py=py-pv
    2710 'if t1=2 or t5=2 and pa=0 then ps=p(4):py=py-pv
    2720 mc=1
2750 return
1 '5 abajo'
    2800 beep:'gosub 2900:'pset(px+8,py-1),13
    1 '2810 if point(px+8,py-1)=8 or point(px+8,py+16+1)=8 then ps=p(4):py=py+pv
    2810 if t1=2 or t5=2 and pa=0 then ps=p(4):py=py+pv
2850 return


1 'Variables'

    2900 tx=(px+8)/8:ty=(py-1)/8
    2920 gosub 3100
    2960 PRESET(0,212-16):PRINT#1,"tx: "tx" ty: "ty" t1: "t1" "pa
    2970 tx=(px+8)/8:ty=(py+16+1)/8
    2980 gosub 3100
    2990 PRESET(0,212-8):PRINT#1,"tx: "tx" ty: "ty" t5: "t5" "py
3020 return

1'chequeando contorno sprite personaje
    1 'Chequeando arriba'
    3100 tx=(px+8)/8:ty=(py-1)/8
    1 't1 será el tile de arriba'
    3110 t1=m(ty,tx)
    1 'Chequeando abajo'
    3140 tx=(px+8)/8:ty=(py+16+1)/8
    3150 t5=m(ty,tx)
3190 return




1 'Init player'
    1 'Componente position'
    1 'la posición se define en las pantallas, pw=ancho, ph=alto, pv=velocidad, capturas, etc'
    1 'pj=indica si el salto está activado para desactivar la comprobación del teclado'
    1 'po=player y old'
    1 'pa=player salto activado'
    1 'pj=distancia que recorre cuando el salto está activado'
    1 'pa=salta activdo'
    5000 px=16:py=160:pw=16:ph=16:pv=2:pj=0:po=py:pe=100:pa=0
    5010 dim p(6):p(0)=0:p(1)=1:p(2)=2:p(3)=3:p(4)=4:p(5)=5
    1 'Componente render: Plano 1(para el color) y 0 para el personaje, sprite del 0(para el color) y del 1 al 7 para el personaje'
    5020 pp=0:ps=1
    1 'Componente RPG=player capturas y energía o vida, se define en las pantallas'
    5030 pc=0:pe=0
5040 return


1 'Update player'
1 'pasado al sistema de input'

1 'render player'
    1 'El sprite de nuestro personaje es el 1, plano 0'
    5100 put sprite pp,(px,py),,ps
    1 'El sprute 0 es el swter de color amarillo, plano 1'
    5110 'put sprite pp+1,(px,py),11,0
5190 return

1 ' Rutina barra espaciadora pulsada'
    1 'Ponemos un sonido de salto'
    5200 re=10: gosub 2300
    1 'Guardamos la posición vieja de y en po'
    1 'pj=2 distancia en pixeles que se le va a sumar o restar en el input system'
    5210 po=py:pj=2:pa=1:strig(0)off
5290 return

























1' ----------------------------------------------------
1' ----------------------MAPS--------------------------
1' ----------------------------------------------------



1 'Init map'
    20000 dim m(25,31)
20010 return

20100 cls
20110 copy (0,0)-(32*8,23*8),2 to (0,0),0,tpset
20190 return

1 'Guardar_mapa_en_array
    20200 'dim  m(25,31)
    1 'md=mapa dirección, la dirección c001 se la he puesto yo en el archivo binario cuando lo creé'
    1 'El archivo tan solo contiene los datos de la definición de los mapas'
    20205 md=&hd001
    1 'ahora leemos las filas o la posición x
    20210 for f=0 to 22
    1 'ahora leemos las columnas c o la posicion y
        20220 for c=0 to 31
            1 '11330 m(f,c)=peek(md):md=md+1
            20225 tn=peek(md):md=md+1
        20230 next c
    20240 next f
    1 'Pintamos el mapa'
    20250 'gosub 11500
20290 return

1' Rutia pintar mapa
20300 preset(0,23*8):print #1,"Saving on page 2, wait..."
20305 set page 0,2:cls
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
20494 set page 0,0
20495 preset(0,23*8):print #1,"                         " 
20499 return       

1'Level 1
21000 data 1ee300e4
21010 data 01e30600002803000001000209000009000a010000e300e4
21020 data 01e30b000021002209000029002a010001e3
21030 data 01e303e101000ae1010001e100c100c206e1
21040 data 00e300e400650066001000300200009000a00b00000c001c00200300000e003e
21050 data 00e300e4008500860010003001000002009200a00b00000c001c00200300000e003e
21060 data 01e400a500a6001000301000000c001c00200300000e003e
21070 data 0ae2010002e200c100c202e2010008e2
21080 data 00e300e401000009000a090000c100c20300001000300000009000a00200000e003e
21090 data 00e300e401000029002a02000028050000c100c2010000280000001000300002009200a00200000e003e
21100 data 00e300e40d0000c100c201000001000200100030030000080018002e003e
21110 data 00e300e40d0000c100c2010000210022001000300300000a001a002e003e
21120 data 0be1010001e100c100c205e1010000e100c100c202e1
21130 data 00e300e404000009000a060000c100c2080000c100c2000000e300e4
21140 data 00e300e404000029002a060000c100c2080000c100c2000000e300e4
21150 data 00e300e4030000010002070000c100c204000028020000c100c2000000e300e4
21160 data 00e300e4030000210022070000c100c2080000210022000000e300e4
21170 data 00e100e201e100c100c202e2010007e2010002e200c100c205e2
21180 data 00e300e4010000c100c207000009000a070000c100c201000009000a00e300e4
21190 data 00e300e4010000c100c20100002804000029002a070000c100c201000029002a00e300e4
21200 data 00e300e4010000c100c20a0000010002040000c100c2030000e300e4
21210 data 00e300e4010000c100c20a0000210022040000c100c2030000e300e4
21220 data 1fe1



1 'map 1
1 '21230 data 226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,227
1 '21240 data 226,226,-1,-1,-1,-1,-1,-1,-1,39,-1,-1,-1,-1,0,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,8,9,-1,-1,226,227
1 '21250 data 226,226,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,32,33,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,40,41,-1,-1,226,226
1 '21260 data 226,226,224,224,224,224,-1,-1,224,224,224,224,224,224,224,224,224,224,224,-1,-1,224,224,192,193,224,224,224,224,224,224,224
1 '21270 data 226,227,100,101,258,-1,-1,-1,8,9,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,226,227
1 '21280 data 226,227,132,133,258,-1,-1,-1,40,41,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,226,227
1 '21290 data 227,227,164,165,258,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,226,227
1 '21300 data 225,225,225,225,225,225,225,225,225,225,225,-1,-1,225,225,225,192,193,225,225,225,-1,-1,225,225,225,225,225,225,225,225,225
1 '21310 data 226,227,-1,-1,8,9,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,258,-1,8,9,-1,-1,-1,-1,226,227
1 '21320 data 226,227,-1,-1,40,41,-1,-1,-1,39,-1,-1,-1,-1,-1,-1,192,193,-1,-1,39,-1,258,-1,40,41,-1,-1,-1,-1,226,227
1 '21330 data 226,227,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,0,1,258,-1,-1,-1,-1,-1,128,129,226,227
1 '21340 data 226,227,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,32,33,258,-1,-1,-1,-1,-1,160,161,226,227
1 '21350 data 224,224,224,224,224,224,224,224,224,224,224,224,-1,-1,224,224,192,193,224,224,224,224,224,224,-1,-1,224,192,193,224,224,224
1 '21360 data 226,227,-1,-1,-1,-1,-1,8,9,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,226,227
1 '21370 data 226,227,-1,-1,-1,-1,-1,40,41,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,226,227
1 '21380 data 226,227,-1,-1,-1,-1,0,1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,39,-1,-1,-1,192,193,-1,226,227
1 '21390 data 226,227,-1,-1,-1,-1,32,33,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,-1,-1,32,33,-1,226,227
1 '21400 data 224,225,224,224,192,193,225,225,225,-1,-1,225,225,225,225,225,225,225,225,-1,-1,225,225,225,192,193,225,225,225,225,225,225
1 '21410 data 226,227,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,-1,8,9,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,8,9,226,227
1 '21420 data 226,227,-1,-1,192,193,-1,-1,39,-1,-1,-1,-1,-1,40,41,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,40,41,226,227
1 '21430 data 226,227,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,226,227
1 '21440 data 226,227,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,32,33,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,226,227
1 '21450 data 224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224'

1 'level 2'
21230 data 1fe1
21240 data 00e1006500661b0000e1
21250 data 00e1008500861b0000e1
21260 data 00e100a500a61b0000e1
21270 data 06e101000ae100c100c205e1020000e1
21280 data 00e1020000e10e0000c100c2040000e1020000e1
21290 data 00e1020000e10e0000c100c2040000e1020000e1
21300 data 00e1020000e10e0000c100c2040000e1020000e1
21310 data 01e1010000e1020002e1010000e100c100c207e1020000e1020000e1
21320 data 00e1020000e1020000e1040000c100c2060000e1020000e1020000e1
21330 data 00e1010001e1020000e1040000c100c2060000e1020000e1020000e1
21340 data 00e1020000e1020008e1050000e1020000e1020000e1
21350 data 01e1010000e1020000e1070000e1040000e1020000e1020000e1
21360 data 00e1020000e1020000e1080000e1030000e1020000e1020000e1
21370 data 00e1010001e1020002e100c100c200e1030002e100c100c200e1020000e1020000e1
21380 data 00e1020000e1050000c100c2070000c100c2030000e1020000e1
21390 data 01e1010000e1050000c100c2070000c100c201000081008200e1020000e1
21400 data 00e1020000e1050000c100c2070000c100c2010000a100a200e1020000e1
21410 data 00e1010002e100c100c200e101000be100c100c202e1020000e1
21420 data 00e1040000c100c20e0000c100c2050000e1
21430 data 01e1030000c100c20e0000c100c2050000e1
21440 data 00e1040000c100c20e0000c100c2050000e1
21450 data 1fe1


1'map 2
1 '21460 data 224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224
1 '21470 data 224,100,101,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,224
1 '21480 data 224,132,133,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,224
1 '21490 data 224,164,165,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,224
1 '21490 data 224,224,224,224,224,224,224,-1,-1,224,224,224,224,224,224,224,224,224,224,224,192,193,224,224,224,224,224,224,-1,-1,-1,224
1 '21500 data 224,-1,-1,-1,224,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,224,-1,-1,-1,224
1 '21510 data 224,-1,-1,-1,224,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,224,-1,-1,-1,224
1 '21520 data 224,-1,-1,-1,224,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,224,-1,-1,-1,224
1 '21530 data 224,224,-1,-1,224,-1,-1,-1,224,224,224,-1,-1,224,192,193,224,224,224,224,224,224,224,224,-1,-1,-1,224,-1,-1,-1,224
1 '21540 data 224,-1,-1,-1,224,-1,-1,-1,224,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,224,-1,-1,-1,224,-1,-1,-1,224
1 '21550 data 224,-1,-1,224,224,-1,-1,-1,224,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,224,-1,-1,-1,224,-1,-1,-1,224
1 '21560 data 224,-1,-1,-1,224,-1,-1,-1,224,224,224,224,224,224,224,224,224,-1,-1,-1,-1,-1,-1,224,-1,-1,-1,224,-1,-1,-1,224
1 '21570 data 224,224,-1,-1,224,-1,-1,-1,224,-1,-1,-1,-1,-1,-1,-1,-1,224,-1,-1,-1,-1,-1,224,-1,-1,-1,224,-1,-1,-1,224
1 '21580 data 224,-1,-1,-1,224,-1,-1,-1,224,-1,-1,-1,-1,-1,-1,-1,-1,-1,224,-1,-1,-1,-1,224,-1,-1,-1,224,-1,-1,-1,224
1 '21590 data 224,-1,-1,224,224,-1,-1,-1,224,224,224,192,193,224,-1,-1,-1,-1,224,224,224,192,193,224,-1,-1,-1,224,-1,-1,-1,224
1 '21600 data 224,-1,-1,-1,224,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,224,-1,-1,-1,224
1 '21610 data 224,224,-1,-1,224,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,128,129,224,-1,-1,-1,224
1 '21620 data 224,-1,-1,-1,224,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,160,161,224,-1,-1,-1,224
1 '21630 data 224,-1,-1,224,224,224,192,193,224,-1,-1,224,224,224,224,224,224,224,224,224,224,224,224,192,193,224,224,224,-1,-1,-1,224
1 '21640 data 224,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,224
1 '21650 data 224,224,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,224
1 '21660 data 224,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,224
1 '21670 data 224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224

22000 data 1fe1
22010 data 1e0000e1
22020 data 0009000a1c0000e1
22030 data 0029002a1c0000e1
22040 data 03e1020003e1010007e1010003e1030000e1
22050 data 1e0000e1
22060 data 1a0004e1
22070 data 190005e1
22080 data 1be10300
22090 data 14e10a00
22100 data 10e10e00
22110 data 0be10c0004e10100
22120 data 08e10f0004e10100
22130 data 06e10e0004e10400
22140 data 03e1110004e10400
22150 data 02e10c000ae10400
22160 data 01e10d000ae1010002e1
22170 data 00e109000fe1010002e1
22180 data 0a0007e100a900aa070002e1
22190 data 05000ce100c900ca070002e1
22200 data 05000ce100e900ea070002e1
22210 data 00001ee1
22220 data 1fe1





1 'Mapa 0'
1 '22000 data -1,-1,-1,5,6,-1,-1,8,9,-1,-1,-1,-1,-1,-1,-1,-1,-1,5,6,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
1 '22010 data -1,-1,-1,37,38,-1,-1,40,41,-1,-1,-1,-1,-1,-1,-1,-1,-1,37,38,-1,-1,39,-1,-1,-1,-1,-1,-1,-1,100,101
1 '22020 data -1,-1,-1,37,38,3,4,-1,-1,-1,-1,-1,-1,-1,-1,-1,3,4,37,38,-1,-1,-1,-1,0,1,-1,-1,-1,-1,132,133
1 '22030 data -1,-1,-1,37,38,35,36,-1,-1,-1,-1,-1,-1,-1,-1,-1,35,36,37,38,-1,-1,-1,-1,32,33,-1,-1,-1,-1,164,165
1 '22040 data 224,224,225,225,225,192,193,225,225,225,225,225,225,225,225,225,225,225,225,225,192,193,225,225,225,225,225,225,225,225,225,225
1 '22050 data -1,-1,-1,-1,-1,192,193,5,6,-1,-1,-1,8,9,-1,-1,-1,-1,-1,-1,192,193,-1,-1,5,6,-1,-1,-1,-1,-1,-1
1 '22060 data -1,-1,-1,-1,-1,192,193,37,38,-1,-1,-1,40,41,-1,-1,-1,-1,-1,-1,192,193,-1,-1,37,38,-1,-1,-1,-1,-1,-1
1 '22070 data -1,-1,-1,-1,-1,192,193,37,38,-1,-1,-1,-1,-1,-1,-1,39,-1,-1,-1,192,193,-1,-1,37,38,-1,-1,-1,-1,-1,-1
1 '22080 data -1,3,4,-1,-1,192,193,37,38,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,37,38,-1,-1,-1,-1,3,4
1 '22090 data -1,35,36,-1,-1,192,193,37,38,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,37,38,-1,-1,-1,-1,35,36
1 '22100 data 224,224,224,224,224,224,224,224,224,224,192,193,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,225
1 '22110 data -1,-1,-1,-1,5,6,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,5,6,-1,-1,8,9,-1,-1,-1,-1,-1,-1,-1,-1
1 '22120 data -1,-1,-1,-1,37,38,-1,-1,-1,-1,192,193,-1,-1,-1,39,-1,-1,37,38,-1,-1,40,41,-1,-1,-1,-1,-1,-1,-1,-1
1 '22130 data -1,-1,-1,-1,37,38,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,37,38,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
1 '22140 data -1,3,4,-1,37,38,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,37,38,-1,-1,-1,-1,-1,-1,-1,0,1,-1,-1,-1
1 '22150 data -1,35,36,-1,37,38,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,37,38,-1,-1,-1,-1,-1,-1,-1,32,33,-1,-1,-1
1 '22160 data 224,224,224,224,224,224,192,193,224,224,224,224,224,224,224,224,224,224,225,224,224,192,193,224,224,224,224,225,224,224,224,225
1 '22170 data -1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,5,6,-1,-1,8,9,-1,-1,192,193,-1,-1,-1,-1,5,6,-1,-1,-1
1 '22180 data -1,-1,39,-1,-1,-1,192,193,-1,-1,-1,-1,-1,37,38,-1,-1,40,41,-1,-1,192,193,-1,-1,-1,39,37,38,-1,-1,-1
1 '22190 data -1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,37,38,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,37,38,-1,-1,-1
1 '22200 data -1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,0,1,37,38,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,37,38,-1,3,4
1 '22210 data -1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,32,33,37,38,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,37,38,-1,35,36
1 '22220 data 224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,225

1 'map 1
1 '22230 data 226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,227
1 '22240 data 226,226,-1,-1,-1,-1,-1,-1,-1,39,-1,-1,-1,-1,0,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,8,9,-1,-1,226,227
1 '22250 data 226,226,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,32,33,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,40,41,-1,-1,226,226
1 '22260 data 226,226,224,224,224,224,-1,-1,224,224,224,224,224,224,224,224,224,224,224,-1,-1,224,224,192,193,224,224,224,224,224,224,224
1 '22270 data 226,227,100,101,258,-1,-1,-1,8,9,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,226,227
1 '22280 data 226,227,132,133,258,-1,-1,-1,40,41,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,226,227
1 '22290 data 227,227,164,165,258,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,226,227
1 '22300 data 225,225,225,225,225,225,225,225,225,225,225,-1,-1,225,225,225,192,193,225,225,225,-1,-1,225,225,225,225,225,225,225,225,225
1 '22310 data 226,227,-1,-1,8,9,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,258,-1,8,9,-1,-1,-1,-1,226,227
1 '22320 data 226,227,-1,-1,40,41,-1,-1,-1,39,-1,-1,-1,-1,-1,-1,192,193,-1,-1,39,-1,258,-1,40,41,-1,-1,-1,-1,226,227
1 '22330 data 226,227,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,0,1,258,-1,-1,-1,-1,-1,128,129,226,227
1 '22340 data 226,227,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,32,33,258,-1,-1,-1,-1,-1,160,161,226,227
1 '22350 data 224,224,224,224,224,224,224,224,224,224,224,224,-1,-1,224,224,192,193,224,224,224,224,224,224,-1,-1,224,192,193,224,224,224
1 '22360 data 226,227,-1,-1,-1,-1,-1,8,9,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,226,227
1 '22370 data 226,227,-1,-1,-1,-1,-1,40,41,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,226,227
1 '22380 data 226,227,-1,-1,-1,-1,0,1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,39,-1,-1,-1,192,193,-1,226,227
1 '22390 data 226,227,-1,-1,-1,-1,32,33,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,-1,-1,32,33,-1,226,227
1 '22400 data 224,225,224,224,192,193,225,225,225,-1,-1,225,225,225,225,225,225,225,225,-1,-1,225,225,225,192,193,225,225,225,225,225,225
1 '22410 data 226,227,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,-1,8,9,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,8,9,226,227
1 '22420 data 226,227,-1,-1,192,193,-1,-1,39,-1,-1,-1,-1,-1,40,41,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,40,41,226,227
1 '22430 data 226,227,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,226,227
1 '22440 data 226,227,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,32,33,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,226,227
1 '22450 data 224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224'


1'map 2
1 '22460 data 224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224
1 '22470 data 224,100,101,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,224
1 '22480 data 224,132,133,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,224
1 '22490 data 224,164,165,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,224
1 '22490 data 224,224,224,224,224,224,224,-1,-1,224,224,224,224,224,224,224,224,224,224,224,192,193,224,224,224,224,224,224,-1,-1,-1,224
1 '22500 data 224,-1,-1,-1,224,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,224,-1,-1,-1,224
1 '22510 data 224,-1,-1,-1,224,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,224,-1,-1,-1,224
1 '22520 data 224,-1,-1,-1,224,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,224,-1,-1,-1,224
1 '22530 data 224,224,-1,-1,224,-1,-1,-1,224,224,224,-1,-1,224,192,193,224,224,224,224,224,224,224,224,-1,-1,-1,224,-1,-1,-1,224
1 '22540 data 224,-1,-1,-1,224,-1,-1,-1,224,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,224,-1,-1,-1,224,-1,-1,-1,224
1 '22550 data 224,-1,-1,224,224,-1,-1,-1,224,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,224,-1,-1,-1,224,-1,-1,-1,224
1 '22560 data 224,-1,-1,-1,224,-1,-1,-1,224,224,224,224,224,224,224,224,224,-1,-1,-1,-1,-1,-1,224,-1,-1,-1,224,-1,-1,-1,224
1 '22570 data 224,224,-1,-1,224,-1,-1,-1,224,-1,-1,-1,-1,-1,-1,-1,-1,224,-1,-1,-1,-1,-1,224,-1,-1,-1,224,-1,-1,-1,224
1 '22580 data 224,-1,-1,-1,224,-1,-1,-1,224,-1,-1,-1,-1,-1,-1,-1,-1,-1,224,-1,-1,-1,-1,224,-1,-1,-1,224,-1,-1,-1,224
1 '22590 data 224,-1,-1,224,224,-1,-1,-1,224,224,224,192,193,224,-1,-1,-1,-1,224,224,224,192,193,224,-1,-1,-1,224,-1,-1,-1,224
1 '22600 data 224,-1,-1,-1,224,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,224,-1,-1,-1,224
1 '22610 data 224,224,-1,-1,224,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,128,129,224,-1,-1,-1,224
1 '22620 data 224,-1,-1,-1,224,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,160,161,224,-1,-1,-1,224
1 '22630 data 224,-1,-1,224,224,224,192,193,224,-1,-1,224,224,224,224,224,224,224,224,224,224,224,224,192,193,224,224,224,-1,-1,-1,224
1 '22640 data 224,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,224
1 '22650 data 224,224,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,224
1 '22660 data 224,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,224
1 '22670 data 224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224


1 'Mapa 0'
1 '23000 data -1,-1,-1,5,6,-1,-1,8,9,-1,-1,-1,-1,-1,-1,-1,-1,-1,5,6,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
1 '23010 data -1,-1,-1,37,38,-1,-1,40,41,-1,-1,-1,-1,-1,-1,-1,-1,-1,37,38,-1,-1,39,-1,-1,-1,-1,-1,-1,-1,100,101
1 '23020 data -1,-1,-1,37,38,3,4,-1,-1,-1,-1,-1,-1,-1,-1,-1,3,4,37,38,-1,-1,-1,-1,0,1,-1,-1,-1,-1,132,133
1 '23030 data -1,-1,-1,37,38,35,36,-1,-1,-1,-1,-1,-1,-1,-1,-1,35,36,37,38,-1,-1,-1,-1,32,33,-1,-1,-1,-1,164,165
1 '23040 data 224,224,225,225,225,192,193,225,225,225,225,225,225,225,225,225,225,225,225,225,192,193,225,225,225,225,225,225,225,225,225,225
1 '23050 data -1,-1,-1,-1,-1,192,193,5,6,-1,-1,-1,8,9,-1,-1,-1,-1,-1,-1,192,193,-1,-1,5,6,-1,-1,-1,-1,-1,-1
1 '23060 data -1,-1,-1,-1,-1,192,193,37,38,-1,-1,-1,40,41,-1,-1,-1,-1,-1,-1,192,193,-1,-1,37,38,-1,-1,-1,-1,-1,-1
1 '23070 data -1,-1,-1,-1,-1,192,193,37,38,-1,-1,-1,-1,-1,-1,-1,39,-1,-1,-1,192,193,-1,-1,37,38,-1,-1,-1,-1,-1,-1
1 '23080 data -1,3,4,-1,-1,192,193,37,38,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,37,38,-1,-1,-1,-1,3,4
1 '23090 data -1,35,36,-1,-1,192,193,37,38,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,192,193,-1,-1,37,38,-1,-1,-1,-1,35,36
1 '23100 data 224,224,224,224,224,224,224,224,224,224,192,193,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,225
1 '23110 data -1,-1,-1,-1,5,6,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,5,6,-1,-1,8,9,-1,-1,-1,-1,-1,-1,-1,-1
1 '23120 data -1,-1,-1,-1,37,38,-1,-1,-1,-1,192,193,-1,-1,-1,39,-1,-1,37,38,-1,-1,40,41,-1,-1,-1,-1,-1,-1,-1,-1
1 '23130 data -1,-1,-1,-1,37,38,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,37,38,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
1 '23140 data -1,3,4,-1,37,38,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,37,38,-1,-1,-1,-1,-1,-1,-1,0,1,-1,-1,-1
1 '23150 data -1,35,36,-1,37,38,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,-1,37,38,-1,-1,-1,-1,-1,-1,-1,32,33,-1,-1,-1
1 '23160 data 224,224,224,224,224,224,192,193,224,224,224,224,224,224,224,224,224,224,225,224,224,192,193,224,224,224,224,225,224,224,224,225
1 '23170 data -1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,5,6,-1,-1,8,9,-1,-1,192,193,-1,-1,-1,-1,5,6,-1,-1,-1
1 '23180 data -1,-1,39,-1,-1,-1,192,193,-1,-1,-1,-1,-1,37,38,-1,-1,40,41,-1,-1,192,193,-1,-1,-1,39,37,38,-1,-1,-1
1 '23190 data -1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,-1,37,38,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,37,38,-1,-1,-1
1 '23200 data -1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,0,1,37,38,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,37,38,-1,3,4
1 '23210 data -1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,32,33,37,38,-1,-1,-1,-1,-1,-1,192,193,-1,-1,-1,-1,37,38,-1,35,36
1 '23220 data 224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,225



