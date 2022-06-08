	
; definitions & descriptions by MSX Assembly Page For details see the WEB document at:  http://map.grauw.nl/resources/dos2_functioncalls.php

;MSX-DOS1
_TERM0  equ 0x00	;Program terminate
_CONIN  equ 0x01	;Console input
_CONOUT equ 0x02	;Console output
_AUXIN  equ 0x03	;Auxiliary input
_AUXOUT equ 0x04	;Auxiliary output
_LSTOUT equ 0x05	;Printer output
_DIRIO  equ 0x06	;Direct console I/O
_DIRIN  equ 0x07	;Direct console input
_INNOE  equ 0x08	;Console input without echo
_STROUT equ 0x09	;String output
_BUFIN  equ 0x0A	;Buffered line input
_CONST  equ 0x0B	;Console status
_CPMVER equ 0x0C	;Return version number
_DSKRST equ 0x0D	;Disk reset
_SELDSK equ 0x0E	;Select disk
_FOPEN  equ 0x0F	;Open file (FCB)
_FCLOSE equ 0x10	;Close file (FCB)
_SFIRST equ 0x11	;Search for first entry (FCB)
_SNEXT  equ 0x12	;Search for next entry (FCB)
_FDEL   equ 0x13	;Delete file (FCB)
_RDSEQ  equ 0x14	;Sequential read (FCB)
_WRSEQ  equ 0x15	;Sequential write (FCB)
_FMAKE  equ 0x16	;Create file (FCB)
_FREN   equ 0x17	;Rename file (FCB)
_LOGIN  equ 0x18	;Get login vector
_CURDRV equ 0x19	;Get current drive
_SETDTA equ 0x1A	;Set disk transfer address
_ALLOC  equ 0x1B	;Get allocation information
_RDRND  equ 0x21	;Random read (FCB)
_WRRND  equ 0x22	;Random write (FCB)
_FSIZE  equ 0x23	;Get file size (FCB)
_SETRND equ 0x24	;Set random record (FCB)
_WRBLK  equ 0x26	;Random block write (FCB)
_RDBLK  equ 0x27	;Random block read (FCB)
_WRZER  equ 0x28	;Random write with zero fill (FCB)
_GDATE  equ 0x2A	;Get date
_SDATE  equ 0x2B	;Set date
_GTIME  equ 0x2C	;Get time
_STIME  equ 0x2D	;Set time
_VERIFY equ 0x2E	;Set/reset verify flag
_RDABS  equ 0x2F	;Absolute sector read
_WRABS  equ 0x30	;Absolute sector write


;MSX-DOS2
_DPARM    equ 0x31	;Get disk parameters
_FFIRST   equ 0x40	;Find first entry
_FNEXT    equ 0x41	;Find next entry
_FNEW     equ 0x42	;Find new entry
_OPEN     equ 0x43	;Open file handle
_CREATE   equ 0x44	;Create file handle
_CLOSE    equ 0x45	;Close file handle
_ENSURE   equ 0x46	;Ensure file handle
_DUP      equ 0x47	;Duplicate file handle
_READ     equ 0x48	;Read from file handle
_WRITE    equ 0x49	;Write to file handle
_SEEK     equ 0x4A	;Move file handle pointer
_IOCTL    equ 0x4B	;I/O control for devices
_HTEST    equ 0x4C	;Test file handle
_DELETE   equ 0x4D	;Delete file or subdirectory
_RENAME   equ 0x4E	;Rename file or subdirectory
_MOVE     equ 0x4F	;Move file or subdirectory
_ATTR     equ 0x50	;Get/set file attributes
_FTIME    equ 0x51	;Get/set file date and time
_HDELETE  equ 0x52	;Delete file handle
_HRENAME  equ 0x53	;Rename file handle
_HMOVE    equ 0x54	;Move file handle
_HATTR    equ 0x55	;Get/set file handle attributes
_HFTIME   equ 0x56	;Get/set file handle date and time
_GETDTA   equ 0x57	;Get disk transfer address
_GETVFY   equ 0x58	;Get verify flag setting
_GETCD    equ 0x59	;Get current directory
_CHDIR    equ 0x5A	;Change current directory
_PARSE    equ 0x5B	;Parse pathname
_PFILE    equ 0x5C  ;Parse filename
_CHKCHR   equ 0x5D	;Check character
_WPATH    equ 0x5E	;Get whole path string
_FLUSH    equ 0x5F	;Flush disk buffers
_FORK     equ 0x60	;Fork a child process
_JOIN     equ 0x61	;Rejoin parent process
_TERM     equ 0x62	;Terminate with error code
_DEFAB    equ 0x63	;Define abort exit routine
_DEFER    equ 0x64	;Define disk error handler routine
_ERROR    equ 0x65	;Get previous error code
_EXPLAIN  equ 0x66	;Explain error code
_FORMAT   equ 0x67	;Format a disk
_RAMD     equ 0x68	;Create or destroy RAM disk
_BUFFER   equ 0x69	;Allocate sector buffers
_ASSIGN   equ 0x6A	;Logical drive assignment
_GENV     equ 0x6B	;Get environment item
_SENV     equ 0x6C	;Set environment item
_FENV     equ 0x6D	;Find environment item
_DSKCHK   equ 0x6E	;Get/set disk check status
_DOSVER   equ 0x6F	;Get MSX-DOS version number
_REDIR    equ 0x70	;Get/set redirection status

; MSX_DOS ERROR CODES

__INTER	equ 0xDF	; Internal error
_NORAM	equ 0xDE	; Not Enough Memory
__IBDOS	equ 0xDC	; Invalid MSX-DOS Call  
__IDRV	equ 0xDB	; Invalid drive
__IFNM	equ 0xDA	; Invalid filename 
__IPATH	equ 0xD9	; Invalid pathname 
__PLONG	equ 0xD8	; Pathname too long
__NOFIL	equ 0xD7	; File not found
__NODIR	equ 0xD6	; Directory not found 
__DRFUL	equ 0xD5	; Root directory full
__DKFUL	equ 0xD4	; Disk full
__DUPF	equ 0xD3	; Duplicate filename 
__DIRE	equ 0xD2	; Invalid directory move
__FILRO	equ 0xD1	; Read only file
__DINE	equ 0xD0	; Directory not empty
__IATTR	equ 0xCF	; Invalid attributes
__DOT	equ 0xCE	; Invalid . or .. operation
__SYSX	equ 0xCD	; System file exists
__DIRX	equ 0xCC	; Directory exists
__FILEX	equ 0xCB	; File exists
__FOPEN	equ 0xCA	; File already in use 
__OV64K	equ 0xC9	; Cannot transfer above 64K
__FILE	equ 0xC8	; File allocation error
__EOF	equ 0xC7	; End of file 
__ACCV	equ 0xC6	; File access violation 
__IPROC	equ 0xC5	; Invalid process id 
__NHAND	equ 0xC4	; No spare file handles
__IHAND	equ 0xC3	; Invalid file handle
__NOPEN	equ 0xC2	; File handle not open
__IDEV	equ 0xC1	; Invalid device operation
__IENV	equ 0xC0	; Invalid environment string
__ELONG	equ 0xBF	; Environment string too long
__IDATE	equ 0xBE	; Invalid date
_ITIME	equ 0xBD	; Invalid time
__RAMDX	equ 0xBC	; RAM disk (drive H:) already exists
__NRAMD	equ 0xBB	; RAM disk does not exist
__HDEAD	equ 0xBA	; File handle has been deleted
__ISBFN	equ 0xB8	; Invalid sub-function number
