1 'Varibles'
1 ''



1 'Como clear cierra el open lo volvemos a abrir'
80 defint a-z
1 '------------------START GAME-------------------'
1 'Para ver la descripción de los tiles ir a mapa (línea 20000)'
1 ' Inicializamos variables generales del juego, ponemos el level seleccionado (el 0), el world seleccionado el 0 y los levels maximos por world son 5'
90 ls=0:lm=5:ws=0:wm=1
1 'Incializamos el mapa y los tiles'
100 gosub 20000
1 'Cargamos los datas de la definición de los niveles del mundo en array'
120 gosub 20300
1'pintamos en la page 2 el level 0
125 preset(0,196):print #1,"Pintando en la page 2 level 0"
130 gosub 20500

1 'Inicializamos el personaje'
140 gosub 5000
1 'Inicializamos a los enemigos'
150 gosub 6000
160 bload"musicint.bin",r
1 'inicio de la música'
200 defusr5=&hD100
1 'Parar música'
220 defusr6=&hD12B
1 'Pantalla de bienvenida'
370 cls:preset (80,10):print #1,"!The wathmen"
380 preset (70,20):print #1,"!MSX Murcia 2022"
390 preset (0,70):print #1,"!Debes de atrapar a los ladores por detras, si los coges por delente te matan"
400 preset (0,100):print #1,"!Una vez atrapados, tienes que llamar a la policia y se abrira la puerta de salida"
440 preset (0,130):print #1,"!Segun el ladron que atrapaes obtendras regalos"
450 preset (0,150):print #1,"!El verde: te proporciona unas botas que te permiten saltar."
455 preset (0,170):print #1,"!El rojo: te permite empujar bloques para atrapar a los enemigos"
460 if strig(0)=-1 then goto 470 else goto 460
 1 ' Pintamos el level 0 en la page 0 '
470 a=usr6(0):gosub 20100
1 'Inicializmos las variables globales del juego'
475 gosub 10000
1 'Inicializamos los objetos'
476 gosub 7000
1 'posicionamos los enemigos según el level'
480 gosub 10100
1 'Rutina barra espaciadora pulsada, el player salta
500 strig(0) on:on strig gosub 5100
1 'Habilitamos la interrupción de cuando s pulsa f1'
510 key(1) on: on key gosub 5200
530 on sprite gosub 5300:sprite on
540 gosub 3500
1 'Mostramos el HUD'
550 gosub 2900

1 'Reproducir música'
560 a=usr5(0)

1 ' ----------------------'
1 '      MAIN LOOP
1 ' ----------------------'
    1 'Capturamos las teclas'
    2000 gosub 2500

    1'---------------PLAYER------------------
    1 'render player, el update lo hacemos en el sistema de input'
    2020 put sprite 10,(px,py),,ps
    1 'Chekeo del mapa'
    2030 gosub 3100
    1 'Para ver los tilest, ver el archivo assets/tileset 256x212_8x8px.png
    1 'ts=Los tiles bloque o solid empiezan en la 224 para arriba'
    1 'tl=tile ladder son la 192 y 193'
    1 'th=tile hidden te oculta cuando estás encima'
    1 'tv=tile visible, habilita los sprites on'
    1 'tm=tile money'
    1 'Gravedad del player'
    2040 if t5<ts and t5<>tl(0) and t5<>tl(1) then py=py+pl
    1 ' Si tocamos la puerta cambiamos de pantalla'
    1 '2050 if t0=td(0) or t0=td(1) then lc=1
    1 'Si es un dibán desactivamos las colisiones'
    2060 if t0=th then sprite off 
    2070 if t0=tv then sprite on
    1' si es una moneda, dibujamos un line relleno de blanco y modificamos el array para que se meta un 0 en esa posición
    2080 if t0=tm then re=6:gosub 2300:line (tx*8,(ty+1)*8)-((tx*8)+8,((ty+1)*8)+8),15,bf:m(ty-2,tx,ls)=0:pm=pm+10


    1'---------------ENEMIGOS------------------
    1 'Update enemigo 1'
    2090 if lg>0 then gosub 6500 else put sprite ep(0),(ex(0),212),ec(0),es(0)
 
    1'---------FIN DE-ENEMIGOS------------------

    1 'Si no quedan por detener enemigos:'
    1 '     haremos un efecto para que parpadee, el telefono rojo son los tiles 130, '
    2100 if lg=0 then if time/50 mod 2=0 then copy (0,32)-(16,48),1 to (ox(0),oy(0)),0,tpset else copy (16,32)-(32,48),1 to (ox(0),oy(0)),0,tpset
    1 '     Activamos la para que al tocar la puerta se pueda cambiar de nivel'
    1 '     Pintamos otra puerta'
    2110 if lg=0 and t0=tf(0) or lg=0 and t0=tf(1) then la=1:lg=-1:copy(50,24)-(64,48),1 to (ox(2),oy(2)),0
    1 ' Si tocamos la puerta cambiamos de nivel'
    2120 if la=1 and t0=td(0) or la=1 and t0=td(1) then lc=1
    1' Si el level cambia:
     1 '20500 pintamos el mapa en la page 2 con la información que hay en el array '
     1 '20100 copiamos el mapa de la page 2 en la page 0'
     1 '10100 Inicializamos la posición del player, enemigos, objetos'
     1 '2900 actualizamos el marcador'
    2290 if lc=1 then a=usr6(0):lc=0: ls=ls+1:if ls>lm then wc=1 else preset(40,100):print #1,"Mission complete!!":gosub 20500:gosub 20100:gosub 10100:gosub 2900
    1 '20300 Cargamos los datos de la definición de los niveles del mundo'
    1 '20500 pinta en la page 2 según las definiciones del array'
    1 '20100 pinta en la page 0 la page 2'
    1 '10100 Inicializamos el player, enemigos y objetos'
    1 '2900 mostramos el marcador'
    2295 if wc=1 then ws=ws+1:if ws>wm then print #1,"Game complete!!" else print #1,"World completed":ls=0:wc=0:gosub 20300:gosub 20500:gosub 20100:gosub 10100:gosub 2900
    1 ' marcador'
    2297 'gosub 2900
2299 goto 2000
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


1 '2 Sistema de input'
    1 'Nos guardamos las posiciones del player antes de cambiarlas'
    2500 on stick(0) gosub 2700,2500,2600,2500,2800,2500,2640
2599 return

1 '3 derecha'
    2600 px=px+pv:pd=3:swap p(0),p(1):ps=p(1):if px>240 then px=240
2630 return
1 '7 izquierda'
    2640 px=px-pv:pd=7:swap p(2),p(3):ps=p(3):if px<0 then px=0
2660 return
1 '1 Arriba'
    2700 if t0=tl(0) or t0=tl(1) then py=py-pl:swap p(4),p(5):ps=p(4)
2750 return
1 '5 abajo
    2800 if t5=tl(0) or t5=tl(1) then py=py+pl:swap p(4),p(5):ps=p(4)
2850 return


1 'Variables'

    2900 PRESET(0,212-40):PRINT#1,"F1-openMSX CTrl+F1 cambia level "
    2960 'if pd=3 and ev(0)>0 then PRESET(0,212-32):PRINT#1,"modo captura "
    2965 'if pd=7 and ev(0)<0 then PRESET(0,212-32):PRINT#1,"modo huida "
    2970 PRESET(0,212-24):PRINT#1,"World: "ws" level: "ls
    1 '2970 PRESET(0,212-16):PRINT#1,"rx: "tx" ty "ty" tw "tw
    2975 PRESET(0,212-16):PRINT#1,"To capture: "lg" $: "pm" live: "pe
    2980 PRESET(0,212-8):PRINT#1,"fre: "fre(0)
    1 '2980 PRESET(0,212-8):PRINT#1,"e5: "e5
3020 return

1'chequeando contorno sprite personaje
    1 ' Siempre hay que tener en cuenta que hemos hecho un copy de 3*8 pixeles hacia abajo'
    1 'Chequeando sobre el tile que está'
    1 'dim m(15,31,lm)
    3100 tx=(px)/8:ty=(py)/8
    3120 t0=m(ty-2,tx,ls)
    1 'Chequeando arriba'
    3140 t1=m(ty-4,tx,ls)
    1 'tile derecha'
    3150 t3=m(ty-3,tx+1,ls)
    1 'Chequeando abajo'
    3170 t5=m(ty-1,tx,ls)
3190 return

1 ' Panel de objetos'
    3500 line(0,19*8)-(256,23*8),7,bf
    3510 PRESET(70,19*8):PRINT#1,"Objects panel"
    3520 copy ((128-128)*8,4*8)-(((128-128)*8)+8,(4*8)+8),2 to (16,8*24),0,tpset
3590 return
















1' ----------------------------------------------------
1' ----------------------PALYER------------------------
1' ----------------------------------------------------


1 'Init player'
    1 'Componente position'
    1 'la posición se define en las pantallas, pw=ancho, ph=alto, pv=velocidad, capturas, etc'
    1 'pd=player direction'
    1 'pv=velocidad eje x'
    1 'pl=velocidad eje y'
    1 'p(0)=variables para hacer animación del personaje con los sprites, fíjate en el input system'
    5000 px=256/2:py=8*16:pd=3:pv=4:pl=8
    5010 dim p(6):p(0)=0:p(1)=1:p(2)=2:p(3)=3:p(4)=4:p(5)=5
    1 'Componente render: pp=plano 0 para el personaje, y ps=sprite del personaje
    5020 pp=0:ps=1
    1 'Componente RPG=player energía o vida, pm=player monedas, se define en los niveles'
    5030 pe=10:pm=0
5040 return

1 ' rutina el player salta'
5100 beep
5190 return

1 'Update player'
1 'pasado al sistema de input'


1 ' Rutina tecla f1 pulsada en openMSX control+F1'
    1 'Ponemos un sonido de pegar on la porra'
    5200 re=10: gosub 2300
    5210 lc=1
5290 return


1' si hay una colisión con un enemigo 1 comprobamos si es por detrás o por delante
1 'Si es por detrás matamos al enemigo'
    5300 sprite off
    1 'Lo 1 es sacar al enemigo de la pantlla para que no dé más colosiones'
    5305 put sprite ep(0),(ex(0),212),eo(0),es(0)
    1 ' 1000 reinicia los enemigos y el player según el nivel
    1 ' Si el enemigo es cogido en persecución:
    1 '     Hacemos un sonido'
    1 '     descontamos 1 captura
    1 '     posicionamos al enemigo a la siguiente posición de array ez'
    1 '     Le cambiamos el color'
    5310 if lg>0 then if pd=3 and ev(0)>0 and px<ex(0) or pd=7 and ev(0)<0 and px>ex(0) then re=8:gosub 2300:lg=lg-1:ey(0)=lz(lg):eo(0)=rnd(1)*11:ex(0)=230:put sprite ep(0),(ex(0),ey(0)),eo(0),es(0) else pe=pe-1:gosub 10100:gosub 2900
    1 '5310 if lg>0 then if pd=3 and ev(0)>0 and px<ex(0) or pd=7 and ev(0)<0 and px>ex(0) then re=8:gosub 2300:lg=lg-1:ey(0)=lz(lg):eo(0)=rnd(1)*11:ex(0)=230:put sprite ep(0),(ex(0),ey(0)),eo(0),es(0) else gosub 5100:gosub 10100:gosub 2900

    1 'Actulizar marcador'
    5330 gosub 2900
    5340 sprite on
5390 return




1' ----------------------------------------------------
1' ----------------------ENEMIES-----------------------
1' ----------------------------------------------------

1 ' Crear enemigo 1'
    1 'ep=numero de plano por el cual se dibuja al enemigo muerto'
    1 'eo=para cambiarlos de color'
    6000 ep=10
    6000 dim ew(0),eh(0),es(0),ep(0),ex(0),ey(0),ev(0),el(1),ec(1),eo(1)
    6010 es(0)=8:ep(0)=1
    6110 ev(0)=2
    6160 ec(0)=0
    6170 eo(0)=rnd(1)*(6-4)+4
6390 return



    6500 ex(0)=ex(0)+ev(0)
    1 'Le cambiamos el signo a la velocidad para que rebote cuando salga de la pantalla'
    1 'Si está dentro de la pantallac omprobamos el tile sobre el que está'
    6510 if ex(0)>240 or ex(0)<8 then ev(0)=-ev(0) else e5=m((ey(0)/8)-1,(ex(0)/8),ls):if e5<tl(0) then ev(0)=-ev(0)
    1 'Los sprites del enemigo son el 8 y el 9 derecha y el 10 y el 11 izquierda'
    6520 ec(0)=ec(0)+1
    6530 if ec(0)>1 then ec(0)=0
    6540 if ec(0)=0 then es(0)=8 else es(0)=9
    1 '6550 if ex(0)<256 then if ev(0)>0 then PUT SPRITE ep(0),(ex(0),ey(0)),eo(0),es(0) else PUT SPRITE ep(0),(ex(0),ey(0)),eo(0),es(0)+2 
    1 '6550 if ex(0)<256 then if ev(0)>0 then PUT SPRITE ep(0),(ex(0),ey(0)),eo(0),es(0) else PUT SPRITE ep(0),(ex(0),ey(0)),eo(0),es(0)+2 
    1 'Le ponemos un sprite u otro si la velocidad es negativa o positiva'
    6550 if ev(0)>0 then PUT SPRITE ep(0),(ex(0),ey(0)),eo(0),es(0) else PUT SPRITE ep(0),(ex(0),ey(0)),eo(0),es(0)+2 
6590 return
1' ----------------------------------------------------
1' ----------------------Objects-----------------------
1' ----------------------------------------------------
1 'ox(0),oy(0)=posición del teléfono en el nivel'
1 'ox(1),oy(1)=posición del dibán en el nivel'
1 'ox(2),oy(2)=posición de la puerta en el nivel'
    7000 dim ox(2), oy(2)
7090 return

1' ----------------------------------------------------
1' ----------------------LEVELS AND WORLD -------------
1' ----------------------------------------------------
1 'ls=level seleccionado, indica el nivel que debe de leerse en el mapa, línea 20530 tn=m(f,c,ls)'
1 'lc=level cambia, indica cuando se tiene que redibijar la pantalla y reiniciar los valores del nivel'
1 'lm=indica cual es el nivel máximo por mundo'
1 'la=mapa activado, indica cuando se puede tocar la puerta para cambiar de nivel'
1 'lg=indica el número de enemigos a capturar por nivel'
1 'lz()=indica la posición del enemigo eje "Y" que varía según el nivel'

1 'ws=world seleccionado, mundo seleccionado, utilizado para cargar con bload el archivo que contiene la definición de niveles'

10000 dim lz(5)
10090 return

1 ' Inicialización level'
    1' level 0'
        1 'Sprite 2 dibán, sprite 3 blanco para ocultarse'
        10100 if ws=0 and ls=0 then gosub 10300
        1' level 1'
        10120 if ws=0 and ls=1 then gosub 10400
        1' level 2'
        10140 if ws=0 and ls=2 then gosub 10500
        1' level 3'
        10160 'if ws=0 and ls=3 then gosub 10600
        1' level 4
        10180 'if ws=0 and ls=4 then gosub 10700
        1' level 5'
        10200 'if ws=0 and ls=5 then gosub 10800
        1' level 6'
        10220 'if ws=0 and ls=6 then gosub 10900
    1' level 1'
        1 'Sprite 2 dibán, sprite 3 blanco para ocultarse'
        10222 'if ws=1 and ls=0 then gosub 11000
        1' level 1'
        10224 'if ws=1 and ls=1 then gosub 11100
        1' level 2'
        10226 'if ws=1 and ls=2 then gosub 11200
        1' level 3'
        10230 'if ws=1 and ls=3 then gosub 11300
        1' level 4
        10232 'if ws=1 and ls=4 then gosub 11400
        1' level 5'
        10234 'if ws=1 and ls=5 then gosub 11500
        1' level 6'
        10236 'if ws=1 and ls=6 then gosub 11600
10240 return

1 'level 1'
    1 'la=0 marcamos como que al tocar la puerta no pasas de nivel'
    1 'lg=3 el numéro de capturas de enemigos serán 3'
    10300 la=0:lg=3
    1 'Posicionamos al enemigo'
    10310 lz(0)=16*8:lz(1)=4*8:lz(2)=10*8
    10320 ex(0)=230:ey(0)=16*8
    1 'posicionamos al player'
    10330 px=0:py=16*8
    1' Recuerda que el tile 3 es donde termina el techo
    1 'teléfono'
    10340 ox(0)=30*8:oy(0)=10*8
    1 'dibán'
    10350 ox(1)=13*8:oy(1)=16*8
    1 'Puerta salida'
    10360 ox(2)=0:oy(2)=3*8
    1 'Pintamos un sprite dibán con un plano superior para ocultar al player'
    10370 put sprite 2,(ox(1),oy(1)),6+32,13
    1 'Pinatmos un sprite en blanco que ocultará por completo al player'
    10380 put sprite 3,(ox(1),oy(1)),15+32,14
10390 return
10400 la=0:lg=3:lz(0)=0:lz(1)=16*8:lz(2)=6*8
    10410 px=4*8:py=16*8
    10420 ex(0)=14*8:ey(0)=11*8
    10430 ox(0)=2*8:oy(0)=16*8
    10435 ox(1)=13*8:oy(1)=11*8
    10440 ox(2)=2*8:oy(2)=5*8
    10450 put sprite 2,(ox(1),oy(1)),6+32,13
    10460 put sprite 3,(ox(1),oy(1)),15+32,14
10490 return
10500 la=0:lg=3
    10510 lz(0)=0:lz(1)=8*8:lz(2)=12*8
    10520 ex(0)=230:ey(0)=16*8
    10530 px=0:py=16*8
    10540 ox(0)=26*8:oy(0)=10*8
    10550 ox(1)=13*8:oy(1)=16*8
    10560 ox(2)=29*8:oy(2)=5*8
    10570 put sprite 2,(ox(1),oy(1)),6+32,13
    10580 put sprite 3,(ox(1),oy(1)),15+32,14
10590 return
10500 la=0:lg=3
    10510 lz(0)=0:lz(1)=10*8:lz(2)=16*8
    10520 ex(0)=230:ey(0)=4*8
    10530 px=0:py=16*8
    10540 ox(0)=26*8:oy(0)=10*8
    10550 ox(1)=25*8:oy(1)=14*8
    10560 ox(2)=0*8:oy(2)=5*8
    10570 put sprite 2,(ox(1),oy(1)),6+32,13
    10580 put sprite 3,(ox(1),oy(1)),15+32,14
10590 return




















1' ----------------------------------------------------
1' ----------------------MAP AND TILES-----------------
1' ----------------------------------------------------
1 'Initialize'
1 'm(tx,ty,ls)=mapa, el mapa es utilizado para comprobar cuando el player o enemigo choca contra algo'
1 'ts=Los tiles bloque o solid empiezan en la 224 para arriba'
1 'tl=tile ladder son la 192 y 193'
1 'th=tile hidden te oculta cuando estás encima'
1 'tv=tile visible, habilita los sprites on'
1 'tf=tiles teléfono'
1 'tm=tile money'
    20000 dim m(15,31,lm)
    20010 ts=224:dim tl(1):tl(0)=192:tl(1)=193:dim td(1):td(0)=164:td(1)=165:th=37:tv=104:tm=4:dim tf(1):tf(0)=160:tf(1)=161
20090 return 

1 'Rutina copiar page 2 a page 0'
    20100 cls
    1 ' copiamos el tejado'
    20110 copy(0,64)-(256,86),1 to (0,0),0,tpset
    20120 copy (0,0)-(32*8,23*8),2 to (0,3*8),0,tpset
20190 return


1 'Rutina cargar archivo.bin con los datas y almacenar datas en array'
    1' cargamos solo en el array el mapa seleccionado
    20300 print #1,"Cagando mapa "ws" levels 0-6 en array"
    20305 if ws=0 then bload"world0.bin",r
    20310 if ws=1 then bload"world1.bin",r
    20320 if ws=2 then bload"world2.bin",r
    20330 md=&hc001
    20390 for mf=0 to lm
        20400 for f=0 to 15
            1 ' ahora leemos las columnas c
            20420 for c=0 to 31 
                20430 va=peek(md):md=md+1
                1 'El programa tiled asgna -1 a los tiles vacíos y nosotros no queremos el 255'
                20450 if va=255 then va=0
                20460 m(f,c,mf)=va 
            20480 next c
        20490 next f
    20495 next mf   
20499 return



1 'Pintando mapa en page 2 según la información del array'
    20500 set page 0,2:cls
    20505 _TURBO ON (m(),ls)
    20510 for f=0 to 15
    1 'ahora leemos las columnas c o la posicion y
        20520 for c=0 to 31
            20530 tn=m(f,c,ls)
            1 '20535 print #1,tn",";
            20540 if tn >0 and tn <32 then copy (tn*8,0)-((tn*8)+8,8),1 to (c*8,f*8),2,tpset
            20550 if tn >=32 and tn <64 then copy ((tn-32)*8,8)-(((tn-32)*8)+8,8),1 to (c*8,f*8),2,tpset
            20560 if tn >=32 and tn <64 then copy ((tn-32)*8,1*8)-(((tn-32)*8)+8,(1*8)+8),1 to (c*8,f*8),2,tpset
            20570 if tn >=64 and tn <96 then copy ((tn-64)*8,2*8)-(((tn-64)*8)+8,(2*8)+8),1 to (c*8,f*8),2,tpset
            20580 if tn>=96 and tn <128 then copy ((tn-96)*8,3*8)-(((tn-96)*8)+8,(3*8)+8),1 to (c*8,f*8),2,tpset
            20590 if tn>=128 and tn <160 then copy ((tn-128)*8,4*8)-(((tn-128)*8)+8,(4*8)+8),1 to (c*8,f*8),2,tpset
            20600 if tn>=160 and tn <192 then copy ((tn-160)*8,5*8)-(((tn-160)*8)+8,(5*8)+8),1 to (c*8,f*8),2,tpset
            20610 if tn>=192 and tn <224 then copy ((tn-192)*8,6*8)-(((tn-192)*8)+8,(6*8)+8),1 to (c*8,f*8),2,tpset
            20620 if tn>=224 and tn <256 then copy ((tn-224)*8,7*8)-(((tn-224)*8)+8,(7*8)+8),1 to (c*8,f*8),2,tpset
        20630 next c
    20640 next f
    20645 _TURBO off
    20650 set page 0,0
20690 return
