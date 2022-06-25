        output "musicint.bin"
;music.bin necestia 800 bytes para alojarse en la RAM, en basic tenemos hasta la direccion &hf380-800= eb00
    db   #fe               ; ID archivo binario, siempre hay que poner el mismo 0FEh
    dw   INICIO            ; dirección de inicio
    dw   FINAL - 1         ; dirección final
    dw   INICIO            ; dircción del programa de ejecución (para cuando pongas r en bload"nombre_programa", r)

    org #D100 ; org se utiliza para decirle al z80 en que posición de memoria empieza nuestro programa (es la 33280 en decimal), en hezadecimal sería #8200
    ; Las variables del pt3_player está definidas en el archivo PT3_player.asm en la dirección #f000
HKEYI equ #FD9A
;inerrupcón de rutina d refresco vertical Vblank
;HTIMI equ #FD9F 
HTIMI equ #FD9A
INICIO:
inicilizar_tracker:


    ;Deactivamos las interrupciones
    di	
	ld		hl,SONG-99		; hl vale la direccion donde se encuentra la cancion - 99
	call	PT3_INIT			; Inicia el reproductor de PT3
    
    
    ;Salvamos la rutina ISR(Interrupt service routine) si hubiese alguna.Son 5 bytes
    ld hl,HTIMI
    ld de,rutina_previa
    ld bc,5
    ldir


    ;instalamos nuestra rutina
    ld a,#c3
    ld hl, reproducir_bloque_musica
    ld (HTIMI),a
    ld (HTIMI+1), hl
    ;Activamos las interrupciones
	ei 
    ;Volvemos al basic
    ret

reproducir_bloque_musica:
    ;------------------Reproducir Bloque de múscia--------
    ;halt						;sincronizacion
	di
	call	PT3_ROUT			;Borrar el valor anterior
	call	PT3_PLAY			;Reproduce el siguiente trozo de canción
    ;lanzamos la rutina que había
    jp rutina_previa
    ei
    ;--------------Fin de reproducir bloque de música-----

    ;Volvemos al basic
    ret
para_cancion:
    ;volvemos a poner los 5 bytes que tenía
    ld hl,rutina_previa
    ld de,HTIMI
    ld bc,5
    ldir

    call PT3_MUTE
    ret
evitar_repeticion_cancion:
    ld a, (#f7f8)
    ld (PT3_SETUP),a
    ret
tracker:
	include	"./src/PT3_player.asm"					;replayer de PT3
SONG:
	incbin "./src/song.pt3"			;musica de ejemplo


;definición de variables
;contador: db 0
                            ;bytes
;contador_vblanks equ #f200    ;1
;contador_de_segundos equ #f201;1
rutina_previa equ #f200     ;5
FINAL:











