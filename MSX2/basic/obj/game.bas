80 defint a-z
100 print #1,"Cagando mapas 0-9 en array"
110 ms=0:mm=5:dim m(23,31,mm):gosub 20300
125 preset(0,196):print #1,"Pintando en la page 2 level 0"
130 gosub 20500
135 gosub 20100
140 gosub 5000
520 strig(0) on:on strig gosub 5200
530 gosub 2900
    2000 gosub 5100
    2010 gosub 2500
    2020 'gosub 3100
    2030 'gosub 2900
    2080 if mc=1 then mc=0: ms=ms+1:if ms>mm then preset(40,100):print #1,"game completed":ms=-1:mc=1 else preset(40,100):print #1,"Mission complete!!":gosub 20500:gosub 20100:gosub 2900
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
    2520 if pa=1 then py=py-pj
    2530 if pa=1 and py<po-10 then pj=-pj
    2540 if pa=1 and py>po then py=po:pj=0:pj=-pj:pa=0:strig(0)on
    2590 gosub 3100
    2592 if pa=0 and t5=255 then py=py+pv
    2590 if py>180 then py=180
2599 return
    2600 px=px+pv
    2610 swap p(0),p(1):ps=p(1)
    2620 'gosub 2900
2630 return
    2640 px=px-pv
    2650 swap p(2),p(3):ps=p(3)
2660 return
    2700 beep:'gosub 2900:'pset(px+8,py-1),13
    2710 'if t1=2 or t5=2 and pa=0 then ps=p(4):py=py-pv
    2720 mc=1
2750 return
    2800 beep:'gosub 2900:'pset(px+8,py-1),13
    2810 if t1=2 or t5=2 and pa=0 then ps=p(4):py=py+pv
2850 return
    2900 'tx=(px+8)/8:ty=(py-1)/8'
    2960 PRESET(0,212-24):PRINT#1,hex$(varptr(m(0,0,0)))"             "
    2970 PRESET(0,212-16):PRINT#1,"Level: "ms
    2980 PRESET(0,212-8):PRINT#1,"fre: "fre(0)
3020 return
    3100 tx=(px+8)/8:ty=(py-1)/8
    3110 t1=m(ty,tx)
    3140 tx=(px+8)/8:ty=(py+16+1)/8
    3150 t5=m(ty,tx)
3190 return
    5000 px=16:py=160:pw=16:ph=16:pv=2:pj=0:po=py:pe=100:pa=0
    5010 dim p(6):p(0)=0:p(1)=1:p(2)=2:p(3)=3:p(4)=4:p(5)=5
    5020 pp=0:ps=1
    5030 pc=0:pe=0
5040 return
    5100 put sprite pp,(px,py),,ps
    5110 'put sprite pp+1,(px,py),11,0
5190 return
    5200 re=10: gosub 2300
    5210 po=py:pj=2:pa=1:strig(0)off
5290 return
    20000 'dim m(25,31)
20010 return
20100 cls
20110 copy (0,0)-(32*8,23*8),2 to (0,0),0,tpset
20190 return
    20300 for mf=0 to mm
        20310 for f=0 to 22:mp$=""
            20330 READ mp$:co=0
            20340 for c=0 to len(mp$) step 4
                20350 R=VAL("&H"+MID$(mp$,c+1,2))   
                20360 O=VAL("&H"+MID$(mp$,c+3,2))
                20370 FOR J=0 TO R
                    20380 if co<32 then m(f,co,mf)=O-1
                    20390 co=co+1
                20460 NEXT J
            20480 next c
        20490 next f
    20495 next mf
20499 return
    20500 set page 0,2:cls
    20505 _TURBO ON (m(),ms)
    20510 for f=0 to 22
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
21100 data 09e100c100c212e100e2
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
21230 data 1ee300e4
21240 data 01e30600002803000001000209000009000a010000e300e4
21250 data 01e30b000021002209000029002a010001e3
21260 data 01e303e101000ae1010001e100c100c206e1
21270 data 00e300e400650066001000300200009000a00b00000c001c00200300000e003e
21280 data 00e300e4008500860010003001000002009200a00b00000c001c00200300000e003e
21290 data 01e400a500a6001000301000000c001c00200300000e003e
21300 data 0ae2010002e200c100c202e2010008e2
21310 data 00e300e401000009000a090000c100c20300001000300000009000a00200000e003e
21320 data 00e300e401000029002a02000028050000c100c2010000280000001000300002009200a00200000e003e
21330 data 00e300e40d0000c100c201000001000200100030030000080018002e003e
21340 data 00e300e40d0000c100c2010000210022001000300300000a001a002e003e
21350 data 0be1010001e100c100c205e1010000e100c100c202e1
21360 data 00e300e404000009000a060000c100c2080000c100c2000000e300e4
21370 data 00e300e404000029002a060000c100c2080000c100c2000000e300e4
21380 data 00e300e4030000010002070000c100c204000028020000c100c2000000e300e4
21390 data 00e300e4030000210022070000c100c2080000210022000000e300e4
21400 data 00e100e201e100c100c202e2010007e2010002e200c100c205e2
21410 data 00e300e4010000c100c207000009000a070000c100c201000009000a00e300e4
21420 data 00e300e4010000c100c20100002804000029002a070000c100c201000029002a00e300e4
21430 data 00e300e4010000c100c20a0000010002040000c100c2030000e300e4
21440 data 00e300e4010000c100c20a0000210022040000c100c2030000e300e4
21450 data 1fe1
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
22000 data 1fe1
22010 data 1a000009000a010000e1
22020 data 000400050700002804000001000208000029002a010000e1
22030 data 002400250d00002100220c0000e1
22040 data 03e1020003e1010000c100c205e1010003e101000004000500e1
22050 data 0c0000c100c20d000024002500e1
22060 data 06000028040000c100c20b0004e1
22070 data 0c0000c100c20a0001e10300
22080 data 020012e100c100c202e10400
22090 data 000100020b000009000a050000c100c20700
22100 data 002100220b000029002a050000c100c20700
22110 data 06e100c100c202e1090000c100c2000004e10100
22120 data 060000c100c20c0000c100c2000000e10500
22130 data 00040005040000c100c208000028020003e1030000040005
22140 data 00240025040000c100c20c0000e1060000240025
22150 data 00e107e2060006e1030000c100c202e2
22160 data 00e101000009000a0a0000e100000009000a060000c100c2010000e1
22170 data 00e101000029002a050000c100c203e100000029002a060000c100c2010000e1
22180 data 05000028030000c100c2050000a900aa07e2010000e1
22190 data 0a0000c100c2050000c900ca00e2080000e1
22200 data 000000010002010009e2030000e900ea00e200810082060000e1
22210 data 000000210022110000e200a100a2060000e1
22220 data 1fe1
22300 data 1fe3
22310 data 00e30065006608000028110000e3
22320 data 00e30085008619000004000500e3
22330 data 00e300a500a60ce100c100c20ae10024002500e3
22340 data 00e302e101000009000a070000c100c207000009000a02e100e3
22350 data 00e304000029002a070000c100c207000029002a020000e3
22360 data 00e309000028030000c100c20c0000e3
22370 data 00e30e0000c100c2000000040005090000e3
22380 data 00e30e0000c100c200000024002504000028030000e3
22390 data 00e30001000205000ee1030000010002000000e3
22400 data 00e300210022050000e104000009000a050000e1030000210022000000e3
22410 data 00e304e100c100c201e104000029002a050001e100c100c203e100e3
22420 data 00e301000009000a000000c100c2100000c100c2030000e3
22430 data 00e301000029002a000000c100c2040001e1030001e1030000c100c2030000e3
22440 data 00e3040000c100c2050000e1000100020004000500e1040000c100c2030000e3
22450 data 00e3040000c100c2050000e1002100220024002500e101000028010000c100c2030000e3
22460 data 00e300810082020000c100c2050005e1040000c100c2030000e3
22470 data 00e300a100a2020000c100c2100000c100c2030000e3
22480 data 00e308e10c0007e100e3
22490 data 00e309000028120000e3
22500 data 00e300040005180000010002000000e3
22510 data 00e300240025180000210022000000e3
22520 data 00e31ee1
22600 data 1fe3
22610 data 01e30900000400050f0001e3
22620 data 01e30900002400250f0001e3
22630 data 01e300650066070001e200e1030001e2080001e3
22640 data 01e300850086060001e20006000703000006000701e2030000810082000001e3
22650 data 01e300a500a6050001e2000000260027030000260027000001e2020000a100a2000001e3
22660 data 01e3000004e200c100c200e2010000260027030000260027010001e200c100c201e2000001e3
22670 data 01e3050000c100c2020000260027030000260027030000c100c2020001e3
22680 data 01e3050000c100c2020000260027030000260027030000c100c2020001e3
22690 data 01e3050001e2020000260027030000260027030001e2020001e3
22700 data 01e3040003e2010000260027030000260027020000e2010000e2010001e3
22710 data 01e3030001e2010001e2000000260027030000260027010001e2010001e2000001e3
22720 data 01e3030000e2030000e203e1020003e101e20004000501e2000001e3
22730 data 01e3030001e2010001e20b0000e20024002500e2010001e3
22740 data 01e3040003e20d0001e2020001e3
22750 data 01e300040005030001e2020000e104000001000200e1070001e3
22760 data 01e300240025080000e104000021002200e1070001e3
22770 data 01e304e100010002030002e100c100c203e1030003e101e3
22780 data 01e3030000e100210022060000c100c2070000e1020001e3
22790 data 01e3030004e1040000c100c2040003e1020001e3
22800 data 01e30d0000c100c209000004000501e3
22810 data 01e30d0000c100c209000024002501e3
22820 data 1fe3
23210 data 1fe3
23220 data 00e31b000065006600e3
23230 data 00e30004000519000085008600e3
23240 data 00e3002400250600000100020e0001e100a500a600e1
23250 data 00e301e100c100c2040000210022100001e200e3
23260 data 00e3010000c100c2040008e100c100c201e1070000e3
23270 data 00e3010000c100c20d0000c100c2090000e3
23280 data 00e3010000c100c2080000810082020000c100c2090000e3
23290 data 00e3010000c100c2080000a100a2020000c100c2090000e3
23300 data 00e3010000c100c2060003e1020002e1080000e3
23310 data 00e3010000c100c2060000c100c2060001e1070000e3
23320 data 00e3010000c100c2060000c100c2100000e3
23330 data 00e3010000c100c2060000c100c2100000e3
23340 data 00e3010005e1020000c100c2090003e1020000e3
23350 data 00e30a0000c100c2050000010002080000e3
23360 data 00e30a0000c100c2050000210022080000e3
23370 data 00e300000001000206000be105000004000500e3
23380 data 00e300000021002218000024002500e3
23390 data 00e304e1130004e100e3
23400 data 00e3030000e1130000e1030000e3
23410 data 00e300040005010000e1130000e1030000e3
23520 data 00e3002400251b0000e3
23430 data 1fe3
