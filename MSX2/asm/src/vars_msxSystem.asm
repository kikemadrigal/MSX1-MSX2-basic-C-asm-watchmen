
; For details see the WEB document at:  http://map.grauw.nl/resources/dos2_functioncalls.php


TRANSPARENT  equ  0
BLACK        equ  1
GREEN        equ  2
LIGHT_GREEN  equ  3
DARK_BLUE    equ  4
LIGHT_BLUE   equ  5
DARK_RED     equ  6
CYAN         equ  7
RED          equ  8
LIGHT_RED    equ  9
DARK_YELLOW  equ 10
LIGHT_YELLOW equ 11
DARK_GREEN   equ 12
MAGENTA      equ 13
GRAY         equ 14
GREY         equ 14
WHITE        equ 15



; MSX System Variables v0.9 17/05/2018
; definitions & texts by MSX Assembly Page
; http://map.grauw.nl/resources/msxsystemvars.php





; MSX System Variables
VDPDR equ 0x0006 ;Base port address for VDP data read
VDPDW equ 0x0007 ;Base port address for VDP data write

;0x002B	//1	Basic ROM version

;7 6 5 4 3 2 1 0
;| | | | +-+-+-+-- Character set
;| | | |           0 = Japanese, 1 = International, 2=Korean
;| +-+-+---------- Date format
;|                 0 = Y-M-D, 1 = M-D-Y, 2 = D-M-Y
;+---------------- Default interrupt frequency
;                  0 = 60Hz, 1 = 50Hz

                  
MSXROM equ 0x002C	;1	Basic ROM version

;7 6 5 4 3 2 1 0
;| | | | +-+-+-+-- Keyboard type
;| | | |           0 = Japanese, 1 = International
;| | | |           2 = French (AZERTY), 3 = UK, 4 = German (DIN)
;+-+-+-+---------- Basic version
;                  0 = Japanese, 1 = International


MSXVER  equ 0x002D	;1	MSX version number
;0 = MSX 1
;1 = MSX 2
;2 = MSX 2+
;3 = MSX turbo R


;0x002E	//1	Bit 0: if 1 then MSX-MIDI is present internally (MSX turbo R only)




RDPRIM	equ 0xF380	;5	Routine that reads from a primary slot
WRPRIM	equ 0xF385	;7	Routine that writes to a primary slot
CLPRIM	equ 0xF38C	;14	Routine that calls a routine in a primary slot
USRTAB	equ 0xF39A	;2	Address to call with Basic USR0

;#F39C	2	Address to call with Basic USR1
;#F39E	2	Address to call with Basic USR2
;#F3A0	2	Address to call with Basic USR3
;#F3A2	2	Address to call with Basic USR4
;#F3A4	2	Address to call with Basic USR5
;#F3A6	2	Address to call with Basic USR6
;#F3A8	2	Address to call with Basic USR7
;#F3AA	2	Address to call with Basic USR8
;#F3AC	2	Address to call with Basic USR9




;VDP variables

LINL40	equ 0xF3AE	;1	Width for SCREEN 0 (default 37)
LINL32	equ 0xF3AF	;1	Width for SCREEN 1 (default 29)
LINLEN	equ 0xF3B0	;1	Width for the current text mode
CRTCNT	equ 0xF3B1	;1	Number of lines on screen
CLMLST	equ 0xF3B2	;1	Column space. It’s uncertain what this address actually stores
TXTNAM	equ 0xF3B3	;2	BASE(0) - SCREEN 0 name table
TXTCOL	equ 0xF3B5	;2	BASE(1) - SCREEN 0 color table
TXTCGP	equ 0xF3B7	;2	BASE(2) - SCREEN 0 character pattern table
TXTATR	equ 0xF3B9	;2	BASE(3) - SCREEN 0 Sprite Attribute Table
TXTPAT	equ 0xF3BB	;2	BASE(4) - SCREEN 0 Sprite Pattern Table
T32NAM	equ 0xF3BD	;2	BASE(5) - SCREEN 1 name table
T32COL	equ 0xF3BF	;2	BASE(6) - SCREEN 1 color table
T32CGP	equ 0xF3C1	;2	BASE(7) - SCREEN 1 character pattern table
T32ATR	equ 0xF3C3	;2	BASE(8) - SCREEN 1 sprite attribute table
T32PAT	equ 0xF3C5	;2	BASE(9) - SCREEN 1 sprite pattern table
GRPNAM	equ 0xF3C7	;2	BASE(10) - SCREEN 2 name table
GRPCOL	equ 0xF3C9	;2	BASE(11) - SCREEN 2 color table
GRPCGP	equ 0xF3CB	;2	BASE(12) - SCREEN 2 character pattern table
GRPATR	equ 0xF3CD	;2	BASE(13) - SCREEN 2 sprite attribute table
GRPPAT	equ 0xF3CF	;2	BASE(14) - SCREEN 2 sprite pattern table
MLTNAM	equ 0xF3D1	;2	BASE(15) - SCREEN 3 name table
MLTCOL	equ 0xF3D3	;2	BASE(16) - SCREEN 3 color table
MLTCGP	equ 0xF3D5	;2	BASE(17) - SCREEN 3 character pattern table
MLTATR	equ 0xF3D7	;2	BASE(18) - SCREEN 3 sprite attribute table
MLTPAT	equ 0xF3D9	;2	BASE(19) - SCREEN 3 sprite pattern table
CLIKSW	equ 0xF3DB	;1	
                        ; =0 when key press click disabled
                        ; =1 when key press click enabled
                        ; SCREEN ,,n will write to this address
CSRY    equ 0xF3DC	    ;1	Current row-position of the cursor
CSRX    equ 0xF3DD	    ;1	Current column-position of the cursor
CNSDFG equ	0xF3DE	    ;1	=0 when function keys are not displayed
                        ;  =1 when function keys are displayed
RG0SAV	equ 0xF3DF	;1	Content of VDP(0) register (R#0)
RG1SAV	equ 0xF3E0	;1	Content of VDP(1) register (R#1)
RG2SAV	equ 0xF3E1	;1	Content of VDP(2) register (R#2)
RG3SAV	equ 0xF3E2	;1	Content of VDP(3) register (R#3)
RG4SAV	equ 0xF3E3	;1	Content of VDP(4) register (R#4)
RG5SAV	equ 0xF3E4	;1	Content of VDP(5) register (R#5)
RG6SAV	equ 0xF3E5	;1	Content of VDP(6) register (R#6)
RG7SAV	equ 0xF3E6	;1	Content of VDP(7) register (R#7)
STATFL	equ 0xF3E7	;1	Content of VDP(8) status register (S#0)

TRGFLG	equ 0xF3E8	;1	Information about trigger buttons and space bar state

;7 6 5 4 3 2 1 0
;| | | |       +-- Space bar, trig(0) (0 = pressed)
;| | | +---------- Stick 1, Trigger 1 (0 = pressed)
;| | +------------ Stick 1, Trigger 2 (0 = pressed)
;| +-------------- Stick 2, Trigger 1 (0 = pressed)
;+---------------- Stick 2, Trigger 2 (0 = pressed)


FORCLR equ	0xF3E9	;1	Foreground color
BAKCLR equ	0xF3EA	;1	Background color
BDRCLR equ	0xF3EB	;1	Border color
MAXUPD equ	0xF3EC	;3	Jump instruction used by Basic LINE command. The routines used are: RIGHTC, LEFTC, UPC and DOWNC
MINUPD equ	0xF3EF	;3	Jump instruction used by Basic LINE command. The routines used are: RIGHTC, LEFTC, UPC and DOWNC
ATRBYT equ	0xF3F2	;1	Attribute byte (for graphical routines it’s used to read the color)
QUEUES equ	0xF3F3	;2	Address of the queue table
FRCNEW equ	0xF3F5	;1	CLOAD flag
;=0 when CLOAD
;=255 when CLOAD?
SCNCNT	equ 0xF3F6	;1	Key scan timing
;When it’s zero, the key scan routine will scan for pressed keys so characters can be written to the keyboard buffer
REPCNT	equ 0xF3F7	;1	This is the key repeat delay counter
;When it reaches zero, the key will repeat
PUTPNT	equ 0xF3F8	;2	Address in the keyboard buffer where a character will be written
GETPNT	equ 0xF3FA	;2	Address in the keyboard buffer where the next character is read

CS120	  equ 0xF3FC	;5	Cassette I/O parameters to use for 1200 baud
CS240	 equ 0xF401	;5	Cassette I/O parameters to use for 2400 baud
LOW	   equ 0xF406	;2	Signal delay when writing a 0 to tape
HIGH	equ  0xF408	;2	Signal delay when writing a 1 to tape
HEADER	equ 0xF40A	;1	Delay of tape header (sync.) block

ASPCT1	equ 0xF40B	;2	Horizontal / Vertical aspect for CIRCLE command
ASPCT2	equ 0xF40D	;2	Horizontal / Vertical aspect for CIRCLE command
ENDPRG	equ 0xF40F	;5	Pointer for the RESUME NEXT command
ERRFLG	equ 0xF414	;1	Basic Error code
LPTPOS equ 0xF415	;1	Position of the printer head
;Is read by Basic function LPOS and used by LPRINT Basic command
PRTFLG	equ 0xF416	;1	Printer output flag is read by OUTDO
;=0 to print to screen
;=1 to print to printer
NTMSXP	equ 0xF417	;1	Printer type is read by OUTDO. SCREEN ,,,n writes to this address
;=0 for MSX printer
;=1 for non-MSX printer
RAWPRT	equ 0xF418	;1	Raw printer output is read by OUTDO
;=0 to convert tabs and unknown characters to spaces and remove graphical headers
;=1 to send data just like it gets it
VLZADR	equ 0xF419	;2	Address of data that is temporarilly replaced by ‘O’ when Basic function VAL("") is running
VLZDAT	equ 0xF41B	;1	Original value that was in the address pointed to with VLZADR
CURLIN	equ 0xF41C	;2	Line number the Basic interpreter is working on, in direct mode it will be filled with #FFFF
;#F91F	1	Character set SlotID
;#F920	2	Character set address
EXBRSA	equ 0xFAF8	;1	Slot address of the SUBROM (EXtended Bios-Rom Slot Address)

DRVINF	equ 0xFB21	;(1B)	Nr. of drives connected to disk interface 1
              ;0xFB22	  (1B)	Slot address of disk interface 1
              ;0xFB23	  (1B)	Nr. of drives connected to disk interface 2
              ;0xFB24	  (1B)	Slot address of disk interface 2
              ;0xFB25	  (1B)	Nr. of drives connected to disk interface 3
              ;0xFB26	  (1B)	Slot address of disk interface 3
              ;0xFB27	  (1B)	Nr. of drives connected to disk interface 4
              ;0xFB28	  (1B)	Slot address of disk interface 4

EXPTBL	equ 0xFCC1	;(1B)	Slot 0: #80 = expanded, 0 = not expanded. Also slot address of the main BIOS-ROM.
              ;0xFCC2	  (1B)	Slot 1: #80 = expanded, 0 = not expanded.
              ;0xFCC3	  (1B)	Slot 2: #80 = expanded, 0 = not expanded.
              ;0xFCC4	  (1B)	Slot 3: #80 = expanded, 0 = not expanded.

SLTTBL	 equ 0xFCC5	;(1B)	Mirror of slot 0 secondary slot selection register.
                ;0xFCC6    (1B)	Mirror of slot 1 secondary slot selection register.
                ;0xFCC7    (1B)	Mirror of slot 2 secondary slot selection register.
                ;0xFCC8    (1B)	Mirror of slot 3 secondary slot selection register.


;VDP variables

RG08SAV   equ 0xFFE7    ;Content of VDP(09) register (R#08)
RG09SAV   equ 0xFFE8    ;Content of VDP(10) register (R#09)
RG10SAV   equ 0xFFE9    ;Content of VDP(11) register (R#10)
RG11SAV   equ 0xFFEA    ;Content of VDP(12) register (R#11)
RG12SAV   equ 0xFFEB    ;Content of VDP(13) register (R#12)
RG13SAV   equ 0xFFEC    ;Content of VDP(14) register (R#13)
RG14SAV   equ 0xFFED    ;Content of VDP(15) register (R#14)
RG15SAV   equ 0xFFEE    ;Content of VDP(16) register (R#15)
RG16SAV   equ 0xFFEF    ;Content of VDP(17) register (R#16)
RG17SAV   equ 0xFFF0    ;Content of VDP(18) register (R#17)
RG18SAV   equ 0xFFF1    ;Content of VDP(19) register (R#18)
RG19SAV   equ 0xFFF2    ;Content of VDP(20) register (R#19)
RG20SAV   equ 0xFFF3    ;Content of VDP(21) register (R#20)
RG21SAV   equ 0xFFF4    ;Content of VDP(22) register (R#21)
RG22SAV   equ 0xFFF5    ;Content of VDP(23) register (R#22)
RG23SAV   equ 0xFFF6    ;Content of VDP(24) register (R#23)
ROMSLT    equ 0xFFF7    ;Slotadress of Main-ROM

RG25SAV   equ 0xFFFA    ;Content of VDP(26) register (R#25) MSX2+
RG26SAV   equ 0xFFFB    ;Content of VDP(27) register (R#26) MSX2+
RG27SAV   equ 0xFFFC    ;Content of VDP(28) register (R#27) MSX2+



SLTSL   equ 0xFFFF ;(all slots)	1	Secondary slot select register. Reading returns the inverted previously written value.


