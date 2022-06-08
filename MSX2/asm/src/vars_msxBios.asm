
;http://map.grauw.nl/resources/msxbios.php
; use RST assembler mnemonic to call
CHKRAM equ 0x00 ; RST 0x00 > Check RAM and sets slot for command area.
SYNCHR equ 0x08 ; RST	0x08 > Checks if then current character pointed by HL is one desired.
CHRGTR equ 0x10 ; RST	0x10 > Gets the next character (or token) of the Basic-text
OUTDO  equ 0x18 ; RST	0x18 > Output to current outputchannel (printer, diskfile, etc.)
DCOMPR equ 0x20 ; RST	0x20 > Compares HL with DE
GETYPR equ 0x28 ; RST	0x28 > Returns Type of DAC
CALLF  equ 0x30 ; RST	0x30 > Executes an interslot call
KEYINT equ 0x38 ; RST	0x38 > Executes the timer interrupt process routine

; use CALL assembler mnemonic
RDSLT  equ 0x000C ; Reads the value of an address in another slot
WRSLT  equ 0x0014 ; Writes a value to an address in another slot
CALSLT equ 0x001C ; Executes inter-slot call
ENASLT equ 0x0024 ; Switches indicated slot at indicated page on perpetual

; Initialization-routines
INITIO equ 0x003B ; Initialises the device
INIFNK equ 0x003E ; Initialises the contents of the function keys








; VDP routines
;--------------
DISSCR equ 0x0041 ; inhibits the screen display
ENASCR equ 0x0044 ; displays the screen
WRTVDP equ 0x0047 ; write data in the VDP-register
;Input    : B  - Data to write
;           C  - Number of the register
RDVRM  equ 0x004A ; Reads the content of VRAM
WRTVRM equ 0x004D ; Writes data in VRAM
SETRD  equ 0x0050 ; Enable VDP to read
SETWRT equ 0x0053 ; Enable VDP to write
FILVRM equ 0x0056 ; fill VRAM with value
LDIRMV equ 0x0059 ; Block transfer to memory from VRAM
; transfiere bloques de datos de RAM a VRAM
LDIRVM equ 0x005C ; Block transfer to VRAM from memory
; transfiere bloques de datos de VRAM a RAM
CHGMOD equ 0x005F ; Switches to given screenmode
;Cambia el modo de screen
;Input    : A  - Screen mode
CHGCLR equ 0x0062 ; Changes the screencolors
;Cambia el color_texto,pantalla y borde, necesita que antes les pongas en las variables
;forclr(0xF3E9),baklr(0xF3EA) y bdrclr(0xF3EB) sus valores
;Input    : Foreground color in FORCLR
;           Background color in BAKCLR
;           Border color in BDRCLR 

CLRSPR equ 0x0069 ; Initialises all sprites
INITXT equ 0x006C ; Switches to SCREEN 0 (text screen with 40 * 24 characters)
INIT32 equ 0x006F ; Switches to SCREEN 1 (text screen with 32*24 characters)
INIGRP equ 0x0072 ; Switches to SCREEN 2 (high resolution screen with 256*192 pixels)
INIMLT equ 0x0075 ; Switches to SCREEN 3 (multi-color screen 64*48 pixels)
SETTXT equ 0x0078 ; Switches to VDP in SCREEN 0 mode
SETT32 equ 0x007B ; Switches VDP in SCREEN mode 1
SETGRP equ 0x007E ; Switches VDP to SCREEN 2 mode
;Input    : GRPNAM, GRPCGP, GRPCOL, GRPATR, GRPPAT
SETMLT equ 0x0081 ; Switches VDP to SCREEN 3 mode
CALPAT equ 0x0084 ; Returns the address of the sprite pattern table
CALATR equ 0x0087 ; Returns the address of the sprite attribute table
GSPSIZ equ 0x008A ; Returns current sprite size
GRPPRT equ 0x008D ; Displays a character on the graphic screen
        









; PSG routines
GICINI equ 0x0090 ; Initialises PSG and sets initial value for the PLAY statement
WRTPSG equ 0x0093 ; Writes data to PSG-register
;Input    : A  - PSG el número del registro del puerto o registro del psg
;           E  - Data write
RDPSG  equ 0x0096 ; Reads value from PSG-register
STRTMS equ 0x0099 ; Tests whether the PLAY statement is being executed as a background task. If not, begins to execute the PLAY statement  */

; Console routines, rutinas de consola
CHSNS  equ 0x009C ; Tests the status of the keyboard buffer
CHGET  equ 0x009F ; One character input (waiting)
CHPUT  equ 0x00A2 ; Displays one character
LPTOUT equ 0x00A5 ; Sends one character to printer
LPTSTT equ 0x00A8 ; Tests printer status
CNVCHR equ 0x00AB ; tests for the graphic header and transforms the code
PINLIN equ 0x00AE ; Stores in the specified buffer the character codes input until the return key or STOP key is pressed     */
INLIN  equ 0x00B1 ; Same as PINLIN except that AUGFLG (#F6AA) is set
QINLIN equ 0x00B4 ; Prints a questionmark andone space
BREAKX equ 0x00B7 ; Tests status of CTRL-STOP 
ISCNTC equ 0x00BA ; Tests status of SHIFT-STOP 
CKCNTC equ 0x00BD ; Same as ISCNTC. used in Basic
BEEP   equ 0x00C0 ; generates beep
BCLS   equ 0x00C3 ; Clears the screen
POSIT  equ 0x00C6 ; Places the cursor at the specified location
FNKSB  equ 0x00C9 ; Tests whether the function key display is active (FNKFLG)If so, displays them, otherwise erase them */
ERAFNK equ 0x00CC ; Erase functionkey display
DSPFNK equ 0x00CF ; Displays the function keys
TOTEXT equ 0x00D2 ; Forces the screen to be in the text mode

; Controller routines                      
GTSTCK equ 0x00D5 ; Returns the joystick status
GTTRIG equ 0x00D8 ; Returns current trigger status
GTPAD  equ 0x00DB ; Returns current touch pad status
GTPDL  equ 0x00DE ; Returns currenct value of paddle

; Tape device routines                      
TAPION equ 0x00E1 ; Reads the header block after turning the cassette motor on
TAPIN  equ 0x00E4 ; Read data from the tape
TAPIOF equ 0x00E7 ; Stops reading from the tape
TAPOON equ 0x00EA ; Turns on the cassette motor and writes the header
TAPOUT equ 0x00ED ; Writes data on the tape
TAPOOF equ 0x00F0 ; Stops writing on the tape
STMOTR equ 0x00F3 ; Sets the cassette motor action

; Queue routines                      
LFTQ equ 0x00F6 ; Gives number of bytes in queue
PUTQ equ 0x00F9 ; Put byte in queue

; Graphic routines
;More info (MSX Assembly Page): http:;map.grauw.nl/resources/msxbios.php                      
RIGHTC equ 0x00FC ; Shifts screenpixel to the right
LEFTC  equ 0x00FF ; Shifts screenpixel to the left
UPC    equ 0x0102 ; Shifts screenpixel up
TUPC   equ 0x0105 ; Tests whether UPC is possible, if possible, execute UPC
DOWNC  equ 0x0108 ; Shifts screenpixel down
TDOWNC equ 0x010B ; Tests whether DOWNC is possible, if possible, execute DOWNC
SCALXY equ 0x010E ; Scales X and Y coordinates
MAPXY  equ 0x0111 ; Places cursor at current cursor address
FETCHC equ 0x0114 ; Gets current cursor addresses mask pattern
STOREC equ 0x0117 ; Record current cursor addresses mask pattern
SETATR equ 0x011A ; Set attribute byte
READC  equ 0x011E ; Reads attribute byte of current screenpixel
SETC   equ 0x0120 ; Returns currenct screenpixel of specificed attribute byte
NSETCX equ 0x0123 ; Set horizontal screenpixels
GTASPC equ 0x0126 ; Gets screen relations
PNTINI equ 0x0129 ; Initalises the PAINT instruction
SCANR  equ 0x012C ; Scans screenpixels to the right
SCANL  equ 0x012F ; Scans screenpixels to the left

; Graphic routines MSX2 
;More info (MSX Assembly Page): http:;map.grauw.nl/resources/msxbios.php#msx2bios
CHKNEW equ 0x0165 ;Tests screen mode > C-flag set if screenmode = 5, 6, 7 or 8
BIGFIL equ 0x016B ;fill VRAM with value (total VRAM can be reached) HL address, BC length, A data
NSETRD equ 0x016E ;Enable VDP to read.(with full 16 bits VRAM-address)
NSTWRT equ 0x0171 ;Enable VDP to write.(with full 16 bits VRAM-address) 
NRDVRM equ 0x0174 ;Reads VRAM like in RDVRM.(with full 16 bits VRAM-address)
NWRVRM equ 0x0177 ;Writes to VRAM like in WRTVRM.(with full 16 bits VRAM-address)

                     
; Misc routines
CHGCAP equ 0x0132 ; Alternates the CAP lamp status
CHGSND equ 0x0135 ; Alternates the 1-bit sound port status
RSLREG equ 0x0138 ; Reads the primary slot register
WSLREG equ 0x013B ; Writes value to the primary slot register
RDVDP  equ 0x013E ; Reads VDP status register
SNSMAT equ 0x0141 ; Returns the value of the specified line from the keyboard matrix
; 0   1          2           3           4           5           6           7           8       9       10
;0    1          2                      4           5           6
;1   ; fin grabr ' grabar                                                    Ñ
;2                                      \grabar2  DEADfingrabar2 A           B
;3 C                        F           G           H
;4                          N
;5 S                        V                       X                       Z
;6SHIFtONTROL    GRAPH      CAPS        CODE
;7              ESCAPE                              BS                      RET
;8                                               Cursor ^    Cursor v
PHYDIO equ 0x0144 ; Executes I/O for mass-storage media like diskettes
FORMAT equ 0x0147 ; Initialises mass-storage media like formatting of diskettes
ISFLIO equ 0x014A ; Tests if I/O to device is taking place
OUTDLP equ 0x014E ; Printer output
GETVCP equ 0x0150 ; Returns pointer to play queue
GETVC2 equ 0x0153 ; Returns pointer to variable in queue number VOICEN (byte op #FB38)
KILBUF equ 0x0156 ; Clear keyboard buffer
CALBAS equ 0x0159 ; Executes inter-slot call to the routine in BASIC interpreter
        
