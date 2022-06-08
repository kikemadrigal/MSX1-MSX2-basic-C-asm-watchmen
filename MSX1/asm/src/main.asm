	db   0FEh             
	dw   INICIO         
	dw   FINAL        
	dw   MAIN   
	org #c000  ; org se utiliza para decirle al z80 en que posición de memoria empieza nuestro programa (es la 33280 en decimal), en hezadecimal sería #8200           
	;también es posible poner page 3 para referenciar la posición
  
INICIO:

MAIN:
    ld hl, mensaje
	call leer_mensaje
	;call cambiar_modo_vdp_wrt






	jr $
leer_mensaje:
	ld a,(hl)
	cp 0
	inc hl
	call 0x00A2
	jr nz, leer_mensaje
	ret
    
mensaje: db "Watchmen",0

	;include "vars_msxBios.asm"
	;include "const-chips.asm"
	;include "vars_msxSystem.asm"
	;include "pantalla.asm"
FINAL: