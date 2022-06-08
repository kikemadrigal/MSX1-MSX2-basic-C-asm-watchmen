        output "main.bin"
	
	db   #fe             
	dw   INICIO         
	dw   FINAL-1        
	dw   INICIO   
	org #8200  ; org se utiliza para decirle al z80 en que posición de memoria empieza nuestro programa (es la 33280 en decimal), en hezadecimal sería #8200           
	;también es posible poner page 3 para referenciar la posición
  
			
			
CHGMOD	equ #005F

STRUCTURA_COPY_HMMM		EQU	#C000
	
			
			




INICIO:
    ;di
    ;im 		1
    ;ld 		sp,#F380
    
    
    ;nos ponemos en screen 5 256x192/212x16 colores.
    ld		a,5
    call	CHGMOD		
    
    ;establecemos la paleta
    ;ld		hl,palette
    ;call	SetPalette
    
    
    ;vamos a pintar todo el bitmap con las escenas en la segunda página de VRAM (va desde #08000
    
    ;establecemos donde empezamos a mandar datos a VRAM (#08000)
    xor		a
    ld		hl,#8000			;AHL establecido
    call	SetVdp_Write
            
    ;mandamos los datos
    ld		hl,raw_bitmap					;el bitmap empieza aquí
    ;ld		de,500			;esto es sólo el tamaño del bitmpa (número de bytes)
    ld		de,fin_raw-raw_bitmap			;esto es sólo el tamaño del bitmpa (número de bytes)
    ;ld		de,palette-raw_bitmap			;esto es sólo el tamaño del bitmpa (número de bytes)
.loop:
    ld		a,[hl]							;leemos el dato
    out 	[#98],a							;lo mandamos a VRAM
    inc		hl								;preparate para leer el siguiente dato de la rom
    dec		de								;un byte menos que leer
    ld		a,d
    or		e								;miramos si DE es cero para terminar
    jr.		nz,.loop
    






	;inicializamos la estructura del copy
	ld		hl,init_COMMAND_HMMM
	ld		de,STRUCTURA_COPY_HMMM
	ld		bc,15
	ldir	
	
	ld		hl,0							;inicializamos la SX
	ld		[STRUCTURA_COPY_HMMM],hl
	
	ei
bucle_principal:
		
[12]	halt									;retardo y sincronización
		
		ld		hl,STRUCTURA_COPY_HMMM
		call	DoCopy							;haz el copy HMMM 

		ld		hl,[STRUCTURA_COPY_HMMM]		;actualizamos el origen  X
		ld		de,28
		add		hl,de
		ld		a,l								;sólo miro el byte bajo, puesto que nunca va ser mayor de 256
		cp		28*6	
		jr		nz,.no_reset
		ld		hl,0
.no_reset:
		ld		[STRUCTURA_COPY_HMMM],hl
		jr.		bucle_principal					;volvemos
		








;http://map.grauw.nl/articles/vdp_tut.php
;
; Set the palette to the one HL points to...
; Modifies: AF, BC, HL (=updated)
;No activa interrupciones al salir
;
;SetPalette:
;    xor a           ; set p#pointer to zero.
;    di
;    out (#99),a
;    ld a,16+128
;;    ei
;    out (#99),a
;    ld bc,#209A     ; out 32x to port #9A
;    otir
;    ret



;http://map.grauw.nl/articles/vdp_tut.php       
; Set VDP address counter to write from address AHL (17-bit)
; no activa interrupciones al salir
;
SetVdp_Write:
    rlc h
    rla
    rlc h
    rla
    srl h
    srl h
    di
    out (#99),a
    ld a,14 + 128
    out (#99),a
    ld a,l
    nop
    out (#99),a
    ld a,h
    or 64
    ;ei				;no activamos interrupciones
    out (#99),a
    ret






;
;Fast DoCopy, by Grauw
;http://map.grauw.nl/articles/vdp_tut.php
;In:  HL = pointer to 15-byte VDP command data
;Out: HL = updated
;
DoCopy:		ld	a,32
			di
			out	(#99),a
			ld	a,17+128
			out	(#99),a
			ld	c,#9B

VDPready:
			ld	a,2
			di
			out	(#99),a		;select s#2
			ld	a,15+128
			out	(#99),a
			in	a,(#99)
			rra
			ld 	a,0		;back to s#0, enable ints
			out	(#99),a
			ld	a,15+128
			ei
			out	(#99),a		;loop if vdp not ready (CE)
			jp	c,VDPready
			
			;call	VDPready_wait
			DW	#A3ED,#A3ED,#A3ED,#A3ED	  ;15x OUTI
			DW	#A3ED,#A3ED,#A3ED,#A3ED	  ; (faster than OTIR)
			DW	#A3ED,#A3ED,#A3ED,#A3ED
			DW	#A3ED,#A3ED,#A3ED
			ret










raw_bitmap:
			incbin		"Guybrush_Threepwood_16indexed_256x47.raw"
			;incbin		"TILESET.S05"
fin_raw: db 0
;palette:
;			incbin		"Guybrush_Threepwood_16indexed.pal"
			



init_COMMAND_HMMM:
	DW	0,256											;sx,sy
	DW	100,100											;dx,dy	
	DW	28,47											;nx,ny
	DB	0,0,#D0											;HMMM IMP




	;ds	#C000 - $
FINAL:
