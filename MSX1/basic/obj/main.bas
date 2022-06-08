
10 'cls
1 'Inicializamos el personaje'
130 gosub 5000
1 'Rutina barra espaciadora pulsada
520 strig(0) on:on strig gosub 5200
530 print #1,"holaaaaa"
1 'Solo se saldrá de este bucle si se ha llegado al final de la pantalla'
1 ' ----------------------'
1 '      MAIN LOOP
1 ' ----------------------'
    1 'bluce principal'
    1 'Capturamos las teclas'
    2000 gosub 2500
    1 'render player, el update lo hacemos en el sistema de input'
    2020 gosub 5100
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
    2520 py=py-pj
    1 '12 es la distancia máxima a la que puede saltar'
    2530 if py<po-10 then pj=-pj
    2540 if py>po then py=po:pj=0:pj=-pj:strig(0)on
2545 return
1 're=8 es el efecto de sonido 8 de la rutina de reprodución de sonidos 2300
1 '3 derecha'
    2600 px=px+pv
    2610 swap p(0),p(1):ps=p(1)
    1 '2620 if px mod 2=0 then ps=ps+1
2630 return
1 '7 izquierda'
    2640 px=px-pv
    2650 swap p(2),p(3):ps=p(3)
    1 '2572 if px mod 2=0  then ps=ps+1
2660 return
1 '1 Arriba'
    2700 if point(px,py-16)=8 then beep: ps=p(4)
2750 return
1 '5 abajo'
    2800 'nada'
2850 return







1 'Init player'
    1 'Componente position'
    1 'la posición se define en las pantallas, pw=ancho, ph=alto, pv=velocidad, capturas, etc'
    1 'pj=indica si el salto está activado para desactivar la comprobación del teclado'
    1 'po=player y old'
    1 'pa=player salto activado'
    1 'pj=distancia que recorre cuando el salto está activado'
    5000 px=32:py=160:pw=16:ph=16:pv=2:pj=0:po=py:pe=100
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
    5100 put sprite pp,(px,py),1,ps
    1 'El sprute 0 es el swter de color amarillo, plano 1'
    5110 'put sprite pp+1,(px,py),11,0
5190 return

1 ' Rutina barra espaciadora pulsada'
    1 'Ponemos un sonido de salto'
    5200 re=10: gosub 2300
    1 'Guardamos la posición vieja de y en po'
    1 'pj=2 distancia en pixeles que se le va a sumar o restar en el input system'
    5210 po=py:pj=2:strig(0)off
5290 return

