org $8000


;010T TSSS LLLC CCCC
;0100 0000 0000 0000
main:
    call $0daf
    ld hl,$4000; vamos a meterle en hl esto:0100 0000 0000 0000=$4000
    ld b, $c0 ; Vamos a meterles las 192 líneas de nuestra pantalla en b,1(128)1(64)00 0000=128+64=192
    call loop
fin:
    jr fin
loop:
    ld (hl),$3c; le metemos a la direc. de memoria estos bits 0011 1100, el sin flas, sin brillo, 
    call nextscan
    halt
    halt
    halt
    ;dec b
    ;jr nz, loop
    djnz loop
nextscan:

    inc h ;0100 0001 
    ld a,h ;lo cargo en a
    and $07 ;nos vamos a quedar con el valor que tengan los bits del 1 al 5
            ;0100 0001 and 0000 0111=000 0001
    ret nz ; si no es 0

    ;si es 0 seguimos y es porque al incrementar 1 el resultado es este: 0100 0111 +1=0100 1000
    ; como eso ha pasado lo primero es cargar la línea y como la línea son los bits del 0 al 7 de 0100 0000 0000 0000
    ld a,l
    add a,$20; 0010 0000; es como sumar uno
    ld l,a ;dejamos el valor en l
    ret c

    ld a,h
    sub $08
    ld h,a
    ret

end $8000
