10 'cls
130 gosub 5000
520 strig(0) on:on strig gosub 5200
530 print #1,"holaaaaa"
    2000 gosub 2500
    2020 gosub 5100
2090 goto 2000
    2300 a=usr2(0)
    2310 if re=1 then PLAY"O5 L8 V4 M8000 A A D F G2 A A A A r60 G E F D C D G R8 A2 A2 A8","o1 v4 c r8 o2 c r8 o1 v6 c r8 o2 v4 c r8 o1 c r8 o2 v6 c r8"
    2350 if re=5 then play "l10 o4 v4 g c"
    2360 if re=6 then play"t250 o5 v12 d v9 e" 
    2370 if re=7 then play "O5 L8 V4 M8000 A A D F G2 A A A A"
    2380 if re=8 then PLAY"S1M2000T150O7C32"
    2390 if re=9 then PLAY"o2 l64 t255 v10 m6500 c"
    2400 if re=10 then sound 6,5:sound 8,16:sound 12,6:sound 13,9
2420 return
    2500 on stick(0) gosub 2700,2500,2600,2500,2800,2500,2640
    2520 py=py-pj
    2530 if py<po-10 then pj=-pj
    2540 if py>po then py=po:pj=0:pj=-pj:strig(0)on
2545 return
    2600 px=px+pv
    2610 swap p(0),p(1):ps=p(1)
2630 return
    2640 px=px-pv
    2650 swap p(2),p(3):ps=p(3)
2660 return
    2700 if point(px,py-16)=8 then beep: ps=p(4)
2750 return
    2800 'nada'
2850 return
    5000 px=32:py=160:pw=16:ph=16:pv=2:pj=0:po=py:pe=100
    5010 dim p(6):p(0)=0:p(1)=1:p(2)=2:p(3)=3:p(4)=4:p(5)=5
    5020 pp=0:ps=1
    5030 pc=0:pe=0
5040 return
    5100 put sprite pp,(px,py),1,ps
    5110 'put sprite pp+1,(px,py),11,0
5190 return
    5200 re=10: gosub 2300
    5210 po=py:pj=2:strig(0)off
5290 return
