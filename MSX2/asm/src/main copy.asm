        output "main.bin"
	
	db   #fe             
	dw   INICIO         
	dw   FINAL-1        
	dw   MAIN   
	org #8200  ; org se utiliza para decirle al z80 en que posición de memoria empieza nuestro programa (es la 33280 en decimal), en hezadecimal sería #8200           
	;también es posible poner page 3 para referenciar la posición

PAGE1_DIR = #8000



INICIO:

MAIN:
	;Almacenamos en el registro a del z80 el valor de 5 que necesita la rutina de la bios CHMOD (ver vars_msxBios.asm)
	ld a,5
	;Cambiamos el modo de vídeo
	call CHGMOD
	;La escritura en VRAM se realiza en 2 pasos 
	;1.Configurar dirección y modo (lectura o escritura)
	call introducir_direccion_y_modo_VRAM
	;2.Escribir los datos
	;La rutina escribir_bytes_en_VRAM necesita que se ponga primero el valor de hl donde están los datos y de con el tamaño de bytes
	ld hl, tileset
	ld de, fin_tileset-tileset
	call escribir_bytes_en_VRAM




	;jr $
	ret



		



introducir_direccion_y_modo_VRAM:
	;1.Se establece el AHL, a=0, hl=#8000
		;Con xor a ponemos a = 0
		xor a
		;Almacenamos en hl el valor 32768 (&h8000) qu es la dirección de la memoria VRAM donde la queremos meter
		ld hl, PAGE1_DIR
	;2 Debemos de introducir en el 1 byte el valor, vamos a poner en el registro 14 del VDP los bits 14,15 y 16 de la dirección de memoria
		;Rotación ciclica hacia la izquierda, en este caso el flag de acarreo no interactúa
		rlc h
		;Rotación aritmética hacia la iquierda
		rla
		rlc h
		rla
		;srl=desplazamiento lógico hacia la derecha, realmente realiza divisiones por 2, el bot 7 se pone a 0 y el bit o va a acarreo
		srl h
		srl h
		;Desactivamos las interrupciones
		di
		;La comunicación con la VRAM es el puerto &h99
		out (#99),a
	;3 Toca introducir el registro que qerermos modificar (el 14),le indicamos con el +128 que el 7 bit sea un 1 para decirle que queremos escribir
		ld a,14 + 128 
		out (#99),a
	;4 El 2 byte será el byte de la dirección de en medio de la VRAM
		ld a,l
		nop
		out (#99),a
	;5 El 3 byte es 1 byte de la dirección de la VRAM
		ld a,h
		or 64
		;ei				;no activamos interrupciones
		out (#99),a
    ret
	
escribir_bytes_en_VRAM:
	ld		a,[hl]							;leemos el dato
	out 	[#98],a							;lo mandamos a VRAM
	inc		hl								;preparate para leer el siguiente dato de la rom
	dec		de								;un byte menos que leer
	ld		a,d
	or		e								;miramos si DE es cero para terminar
	jr.		nz,escribir_bytes_en_VRAM
	ret

;buffer_de_colsiones: ds 768 ;es el mapa o tabla de nombres de VRAM copiada aquí

;include "const-chips.asm"
;include "vars_msxSystem.asm"
;include "pantalla.asm"
include "src/vars_msxBios.asm"
tileset:
	incbin 	"src/TILESET.S05"
fin_tileset: db 0





FINAL: