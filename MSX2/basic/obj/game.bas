80 defint a-z
100 print #1,"Cagando mapas 0-6 en array"
110 ms=0:mm=6:dim m(15,31,mm):gosub 20300
120 ts=224:dim tl(1):tl(0)=192:tl(1)=193:dim td(1):td(0)=164:td(1)=165
125 preset(0,196):print #1,"Pintando en la page 2 level 0"
130 gosub 20500
140 gosub 5000
150 gosub 6000
370 cls:preset (80,10):print #1,"!The wathmen"
380 preset (70,20):print #1,"!MSX Murcia 2022"
390 preset (0,70):print #1,"!Debes de atrapar a los ladores por detras, si los coges por delente te matan"
400 preset (0,100):print #1,"!Una vez atrapados, tienes que llamar a la policia y se abrira la puerta de salida"
440 preset (0,130):print #1,"!Segun el ladron que atrapaes obtendras regalos"
450 preset (0,150):print #1,"!El verde: te proporciona unas botas que te permiten saltar."
455 preset (0,170):print #1,"!El rojo: te permite empujar bloques para atrapar a los enemigos"
460 if strig(0)=-1 then goto 470 else goto 460
470 gosub 20100
480 gosub 10000
500 strig(0) on:on strig gosub 5200
530 on sprite gosub 5300:sprite on
540 gosub 3500
550 gosub 2900
  
    2000 'nada'
    2010 gosub 2500
    2020 put sprite 10,(px,py),,ps
    2030 gosub 3100
    2040 if t5<ts and t5<>tl(0) and t5<>tl(1) then py=py+pl
    2050 if t0=td(0) or t0=td(1) then mc=1
    2060 if t0=37 then sprite off 
    2070 if t0=104 then sprite on
    2080 if t0=4 then beep:line (tx*8,(ty+1)*8)-((tx*8)+8,((ty+1)*8)+8),15,bf:m(ty-2,tx,ms)=0
    2090 if ec>0 then gosub 6500
    
    2180 if ec=0 then  copy ((130-128)*8,4*8)-(((130-128)*8)+8,(4*8)+8),2 to (ox(0),oy(0)),0,tpset else copy ((128-128)*8,4*8)-(((128-128)*8)+8,(4*8)+8),2 to (ox(0),oy(0)),0,tpset
    
    2290 if mc=1 then mc=0: ms=ms+1:if ms>mm then preset(40,100):print #1,"game completed":ms=-1:mc=1 else preset(40,100):print #1,"Mission complete!!":gosub 20500:gosub 20100:gosub 10000:gosub 2900
    2295 'gosub 2900
2299 goto 2000
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
2599 return
    2600 px=px+pv:pd=3:swap p(0),p(1):ps=p(1):if px>240 then px=240
2630 return
    2640 px=px-pv:pd=7:swap p(2),p(3):ps=p(3):if px<0 then px=0
2660 return
    2700 if t0=tl(0) or t0=tl(1) then py=py-pl:swap p(4),p(5):ps=p(4)
2750 return
    2800 if t5=tl(0) or t5=tl(1) then py=py+pl:swap p(4),p(5):ps=p(4)
2850 return
    2900 'PRESET(0,212-40):PRINT#1,ex(0)
    2960 'if pd=3 and ev(0)>0 then PRESET(0,212-32):PRINT#1,"modo captura "
    2965 'if pd=7 and ev(0)<0 then PRESET(0,212-32):PRINT#1,"modo huida "
    2970 PRESET(0,212-24):PRINT#1,"Level: "ms
    2975 PRESET(0,212-16):PRINT#1,"To capture: "ec" $: "pm" live: "pe
    2980 PRESET(0,212-8):PRINT#1,"fre: "fre(0)
3020 return
    3100 tx=(px)/8:ty=(py)/8
    3120 t0=m(ty-2,tx,ms)
    3140 t1=m(ty-4,tx,ms)
    3150 t3=m(ty-3,tx+1,ms)
    3170 t5=m(ty-1,tx,ms)
3190 return
    3500 line(0,19*8)-(256,23*8),7,bf
    3510 PRESET(70,19*8):PRINT#1,"Objects panel"
    3520 copy ((128-128)*8,4*8)-(((128-128)*8)+8,(4*8)+8),2 to (16,8*24),0,tpset
3590 return
    5000 px=256/2:py=8*16:pw=16:ph=16:pd=3:pv=4:pl=8:pe=100:pm=0
    5010 dim p(6):p(0)=0:p(1)=1:p(2)=2:p(3)=3:p(4)=4:p(5)=5
    5020 pp=0:ps=1
    5030 pe=10:pm=0
5040 return
    5200 re=10: gosub 2300
    5210 mc=1
5290 return
    5300 sprite off:beep
    5310 if ec>0 then if pd=3 and ev(0)>0 and px<ex(0) or pd=7 and ev(0)<0 and px>ex(0) then re=8:gosub 2300:ec=ec-1:ey(0)=ez(ec):eo(0)=rnd(1)*11:put sprite 1,(260,ey(0)),,es(0) else gosub 10000:re=5:gosub 2300:put sprite 10,(0,16*8),,pp
    5330 gosub 2900
    5340 sprite on
5390 return
    6000 ep=10:ec=0:dim ez(5)
    6000 dim ew(1),eh(1),es(1),ep(1),ex(1),ey(1),ev(1),el(1),ec(1),eo(1),ea(1)
    6010 ew(0)=8:eh(0)=8:es(0)=8:ep(0)=1:ea(0)=1
    6020 ex(0)=0:ey(0)=0
    6110 ev(0)=2
    6160 ec(0)=0
    6170 eo(0)=rnd(1)*(6-4)+4
6390 return
    6500 ex(0)=ex(0)+ev(0)
    6510 if ex(0)>240 or ex(0)<8 then ev(0)=-ev(0) else e5=m((ey(0)/8)-1,(ex(0)/8),ms)
    6520 ec(0)=ec(0)+1
    6530 if ec(0)>1 then ec(0)=0
    6540 if ec(0)=0 then es(0)=8 else es(0)=9
    6550 if ex(0)<256 then if ev(0)>0 then PUT SPRITE 1,(ex(0),ey(0)),eo(0),es(0) else PUT SPRITE 1,(ex(0),ey(0)),eo(0),es(0)+2 
    6560 if e5<tl(0) then ev(0)=-ev(0)
6590 return
    10000 if ms=0 then ec=3:ez(0)=16*8:ez(1)=4*8:ez(2)=10*8:px=0:py=16*8:ex(0)=230:ey(0)=16*8:ox(0)=30*8:oy(0)=7*8:put sprite 2,(13*8,16*8),6+32,13:put sprite 3,(13*8,16*8),15+32,14
    10020 if ms=1 then px=256/2:py=16*8:ex(0)=14*8:ey(0)=11*8
    10040 if ms=2 then px=256/2:py=16*8:ex(0)=16*8:ey(0)=14*8
    10060 if ms=3 then px=256/2:py=16*8:ex(0)=14*8:ey(0)=14*8
    10080 if ms=4 then px=256/2:py=16*8:ex(0)=12*8:ey(0)=5*8
    10100 if ms=5 then px=256/2:py=16*8:ex(0)=14*8:ey(0)=11*8
    10120 if ms=6 then px=256/2:py=16*8:ex(0)=14*8:ey(0)=10*8
10140 return
    20100 cls
    20110 copy(0,64)-(256,86),1 to (0,0),0,tpset
    20120 copy (0,0)-(32*8,23*8),2 to (0,3*8),0,tpset
20190 return
    20300 for mf=0 to mm
        20350 for f=0 to 15:mp$=""
            20360 READ mp$:co=0
            20370 for c=0 to len(mp$) step 4
                20375 R=VAL("&H"+MID$(mp$,c+1,2))   
                20380 O=VAL("&H"+MID$(mp$,c+3,2))
                20385 FOR J=0 TO R
                    20390 if co<32 then m(f,co,mf)=O-1
                    20395 co=co+1
                20460 NEXT J
            20480 next c
        20490 next f
    20495 next mf
20499 return
    20500 set page 0,2:cls
    20505 _TURBO ON (m(),ms)
    20510 for f=0 to 15
        20520 for c=0 to 31
            20530 tn=m(f,c,ms)
            20540 if tn >=0 and tn <32 then copy (tn*8,0)-((tn*8)+8,8),1 to (c*8,f*8),2,tpset
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
21000 data 006500661d00
21010 data 008500861d00
21020 data 00a500a61c000005
21030 data 09e100c100c212e100e2
21040 data 090000c100c21300
21050 data 090000c100c21300
21060 data 090000c100c21300
21070 data 090000c100c2110000810082
21080 data 0005080000c100c2110000a100a2
21090 data 05e200c100c20ce200c100c208e2
21100 data 050000c100c20c0000c100c20800
21110 data 050000c100c20c0000c100c20800
21120 data 050000c100c203000369040000c100c20800
21130 data 050000c100c20300006901480069040000c100c20800
21140 data 0005040000c100c20300006901260069040000c100c20800
21150 data 1ee100e2
21230 data 1fe2
21240 data 00e300e41300001000300500000e003e003
21250 data 00e300e4006500661100001000300500000e003e003
21260 data 00e300e4008500860e00000400050000001000300500000e003e003
21270 data 00e300e400a500a60e0000240025080001e3
21280 data 09e100c100c2030000c100c205e1020000c100c202e1
21290 data 00e300e4070000c100c2030000c100c2080000c100c2000000e300e4
21300 data 00e300e4070000c100c2030000c100c2080000c100c2000000e300e4
21310 data 00e300e400040005050000c100c2030000c100c2080000c100c2000000e300e4
21320 data 00e300e400240025050000c100c2030000c100c2080000c100c2000000e300e4
21330 data 17e200c100c205e2
21340 data 00e300e4150000c100c2030000e300e4
21350 data 00e300e4150000c100c2030000e300e4
21360 data 00e300e400810082130000c100c201000004000500e300e4
21370 data 00e300e400a100a2130000c100c201000024002500e300e4
21380 data 1fe1
21500 data 1fe1
21510 data 01e1050000e10d0000e104000065006600e1
21520 data 00e1060000e1000400050b0000e104000085008600e1
21530 data 00e1010001e1020000e1002400250b0000e1040000a500a600e1
21540 data 00e1020000e1020008e1050000e1020004e1
21550 data 01e1010000e1020000e1070000e1040000e1020000e100040005000000e1
21560 data 00e1020000e1020000e1080000e1030000e1020000e100240025000000e1
21570 data 00e1010001e1020002e100c100c200e1030002e100c100c200e1020000e1020000e1
21580 data 00e1020000e1050000c100c2070000c100c2030000e1020000e1
21590 data 01e1010000e1050000c100c2070000c100c201000081008200e1020000e1
21600 data 00e1020000e1050000c100c2070000c100c2010000a100a200e1020000e1
21610 data 00e1010002e100c100c200e101000be100c100c202e1010001e1
21620 data 00e1040000c100c200e10d0000c100c2050000e1
21630 data 00e100040005020000c100c200e10d0000c100c2050000e1
21640 data 00e100240025020000c100c200e10d0000c100c2050000e1
21650 data 1fe1
22000 data 1f00
22010 data 006500661d00
22020 data 008500861900000400050100
22030 data 00a500a61900002400250100
22040 data 06e100c100c202e10c0004e10100
22050 data 060000c100c20f0000e10500
22060 data 00040005040000c100c20c0003e1030000040005
22070 data 00240025040000c100c20c0000e1060000240025
22080 data 00e107e2060006e1030000c100c202e2
22090 data 00e10e0000e1090000c100c2010000e1
22100 data 00e1090000c100c203e1090000c100c2010000e1
22110 data 0a0000c100c2050000a900aa07e2010000e1
22120 data 0a0000c100c2050000c900ca00e2080000e1
22130 data 040009e2030000e900ea00e200810082060000e1
22140 data 140000e200a100a2060000e1
22150 data 1fe1
22300 data 1fe3
22310 data 00e3006500661b0000e3
22320 data 00e30085008619000004000500e3
22330 data 00e300a500a619000024002500e3
22340 data 05e100c100c201e10c0001e100c100c204e1
22350 data 00e3040000c100c2100000c100c2030000e3
22360 data 00e3040000c100c2010004e1030003e1010000c100c2030000e3
22370 data 00e3040000c100c2050000e101000004000500e1040000c100c2030000e3
22380 data 00e3040000c100c2050000e101000024002500e1040000c100c2030000e3
22390 data 00e300810082020000c100c2050005e1040000c100c2030000e3
22400 data 00e300a100a2020000c100c2100000c100c2030000e3
22410 data 09e10c0008e1
22420 data 00e31d0000e3
22430 data 00e3000400051b0000e3
22440 data 00e3002400251b0000e3
22450 data 00e31ee1
22600 data 01e30065006617000081008201e3
22610 data 01e300850086170000a100a201e3
22620 data 01e300a500a6130000c100c203e101e3
22630 data 01e305e100c100c20d0000c100c200040005010001e3
22640 data 01e3050000c100c20d0000c100c200240025010001e3
22650 data 01e3050006e1030007e1020001e3
22660 data 01e31b0001e3
22670 data 01e31b0001e3
22680 data 01e300040005190001e3
22690 data 01e300240025190001e3
22700 data 01e304e1040003e100c100c203e1020004e101e3
22710 data 01e30d0000c100c20b0001e3
22720 data 01e30d0000c100c20b0001e3
22730 data 01e30d0000c100c209000004000501e3
22740 data 01e30d0000c100c209000024002501e3
22750 data 1fe3
22900 data 1fe1
22910 data 00e1180000040005020000e1
22920 data 00e1040002e100c100c201e10c0000240025020000e1
22930 data 00e1010000e1040000c100c20d0003e1010000e1
22940 data 00e1010000e1040000c100c2100000e1010000e1
22950 data 00e1010000e1040000c100c2100000e1000001e1
22960 data 00e1010000e1040000c100c2100000e1010000e1
22970 data 00e1000003e1020000c100c20d0003e1010000e1
22980 data 00e1010000e1040000c100c2100000e1010000e1
22990 data 00e10004000500e104000ee1030000e1010000e1
23000 data 00e10024002500e1170000e1010000e1
23010 data 01e1000000e1170001e1000000e1
23020 data 00e10065006604e10f0004e1010000e1
23030 data 00e10085008600e115000004000500e10081008200e1
23040 data 00e100a500a600e115000024002500e100a100a200e1
23050 data 1fe1
