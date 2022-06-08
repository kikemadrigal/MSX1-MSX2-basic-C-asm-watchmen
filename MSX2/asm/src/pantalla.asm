;Existen 2 formas de inicializar la pantalla
;1. utilizando las rutinas de la bios
;2. Utilizando los puertos del x80

;1.
;precondición:
    ;d=registro
    ;a=valor a escribir en registro
escribir_en_registro_vdp:
	;di
	out	(VDP_PORT1),a;set bits 15-17
	ld	a,128 + 14	; 128=1000 0000b, registro VDP
	;ei
	out	(VDP_PORT1),a
    ld a,1 ;set bits 0-7
    ret


cambiar_modo_vdp_chmod:
    ld a,2
	call CHGMOD;rutina de la bios que cambia el modo de screen, (ver vars_msxBios.asm)
    ret

;precondition
;   b=dato
;   c=registro del vdp
cambiar_modo_vdp_wrt:
        ;ld a,(RG0SAV)
        ;ld a,0
        ld a,00000010b ;con or 0+1=1, por la tanto estamos respectando los unos que hayan en a 
                    ;y obligando a que el 2 bit sea 1
        
        ld b,a
        ld c,0;queremos modificar el registro 0
        call WRTVDP ; escribe el dato (B) en el registro dado (C)

        ;ld a,(RG1SAV)
        ;ld a,0
        ld a,11001000b ;con or 0+1=1, por la tanto estamos respectando los unos que hayan en a 
                    ;Ya de paso le decimos qie queremos sprites de 16x16 con 011100(1)0
                    ;y obligando a que el 2 bit sea 1
        ld b,a
        ld c,1;queremos modificar el registro 1
        call WRTVDP ; escribe el dato (B) en el registro dado (C)

        ;ahora falta meterle las direcciones de las tablas
    ret

cambiar_modo_de_video_inigrp:
    call INIGRP; necesita que hayan los valores en estas variables GRPNAM, GRPCGP, GRPCOL, GRPATR, GRPPAT
    ret
