org 0x8000
attr_s: equ $5c8d ;FBPPPIII  flash bright paper ink, atributos globales; 
                  ;coolores:1.azul oscuro,2.rojo,3 magenta,4 verde,5 azul claro,6 amarillo,7 blanco,0 negro
                  ;0000 1110=$0e= 0 sin flas,0 sin modo brillo, paper 001=1 azul, ink=110=6 amarillo
attr_t: equ $5c8f ;atributos que se están usando temporales
locate: equ $0dd9 ;necesita en b=como está al revés la posición 24-y y en c=la posición 33-x
                  ;en total hay 2 pantallas que sumadas son 24 ($18) de alto y 33 ($33) de ancho 
cls: equ $0daf


Inicio:
    ; poniendo el color de fondo azul temporales
    ld a,$0e
    ld hl, attr_t
    ld (hl),a
    ; poniendo el color de fondo azul permanentes
    ld hl,attr_s
    ld (hl),a
    call cls

    ;ponemos el borde en azul
    ld a,$01
    out ($fe),a 

    ;centramos el mensaje
    ld b,24-10
    ld c,33-2
    call $0dd9

    ld hl, mensaje
	call leer_mensaje
	;call cambiar_modo_vdp_wrt

    ; la pantalla del s
fin:
    jr fin

leer_mensaje:
	ld a,(hl)
	or a
    jr z, fin
    rst $10
    inc hl
	jr leer_mensaje
	ret
   
mensaje: db "Watchmen",0

	;include "vars_msxBios.asm"
	;include "const-chips.asm"
	;include "vars_msxSystem.asm"
	;include "pantalla.asm"
end 0x8000