;
; DEFINICIONES REGISTROS PSG
;
	;
PSG_PORT0	equ	#a0	; PSG register write port
PSG_PORT1	equ	#a1	; Value wirte port
PSG_PORT2	equ	#a2	; Value read port


PSG_FREQ_A0	equ	#00	; 0-Frecuencia canal A (bajo)
PSG_FREQ_A1	equ	#01	; 1-Frecuencia canal A (alto)
PSG_FREQ_B0	equ	#02	; 2-Frecuencia canal B (bajo)
PSG_FREQ_B1	equ	#03	; 3-Frecuencia canal B (alto)
PSG_FREQ_C0	equ	#04	; 4-Frecuencia canal C (bajo)
PSG_FREQ_C1	equ	#05	; 5-Frecuencia canal C (alto)
PSG_NOISE	equ	#06	; 6-Frecuencia del ruido
PSG_SETTINGS	equ	#07	; 7-Configuracion de canales
PSG_VOL_A	equ	#08	; 8-Volumen canal A
PSG_VOL_B	equ	#09	; 9-Volumen canal B
PSG_VOL_C	equ	#0a	; 10-Volumen canal C
PSG_ENVEL0	equ	#0b	; 11-Ciclo envolvente (bajo)
PSG_ENVEL1	equ	#0c	; 12-Ciclo envolvente (alto)
PSG_PATTERN	equ	#0d	; 13-Patron envolvente
PSG_IOPORT_A	equ	#0e	; 14-Puerto de E/S A
PSG_IOPORT_B	equ	#0f	; 15-Puerto de E/S B




;-----------------------------------------------------------------
;                       VPD
;-----------------------------------------------------------------
;msx1 vpd TMS9958
;
; Hay que saber que en MSX1 tenemos de los registros 0 al 7 de escritura
; en él te permite cambiar, los sprites el modo de screen, poner la pantalla como el color del borde, etc
; y el 8 de lectura que te muestra si hay colisiones de sprites, si estas en una interrupción y si hay más de 4
; sprites en la misma línea (entendiendo que es una de las líneas de 8x8pixeles)
; para más información mira
; Teniendo estos puertos
;
VDP_PORT0	equ	#98	; VRAM read/write
VDP_PORT1	equ	#99	; VDP registers read/write
VDP_PORT2	equ	#9a	; Palette registers write
VDP_PORT3	equ	#9b	; Indirect register write
; Podemos decir que la forma de acceder al vdp si queremos por ejemplo cambiar de modo de pantalla a screen 2
; Como los japos son raros hay que cambiar dos registros del vdp
; ponemos ld ( #99 que es el puerto que te permite escribir o leer), valor y 
; ld ( #99 que es el puerto que te permite escribir o leer), valor
; ahora tenemos que estudiar los registro de escritura de VDP que es cada byte de cada registro
;------ screen 0------
;registro 0: 0000 0000
;registro 1: 0111 0000
;------ screen 1------
;registro 0: 0000 0000
;registro 1: 0110 0000
;------ screen 2------
;registro 0: 0000 0010
;registro 1: 0111 0000

; DEFINICIONES PANTALLAS (VDP)
;
;SC2
SC2_TILEPAT	equ	#0000	; bancos de patrones   (0x1800)
SC2_TILEMAP	equ	#1800	; mapa de patrones     (0x0300)
SC2_SPRITATTR	equ	#1b00	; atributos de sprites (0x0080)
SC2_TILECOL	equ	#2000	; bancos de colores    (0x1800)
SC2_SPRITPAT	equ	#3800	; patrones de sprites  (0x0800)