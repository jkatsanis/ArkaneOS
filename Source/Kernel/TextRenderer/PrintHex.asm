HEX_PREFIX: db "0x", 0

print_hex:
    mov esi, HEX_PREFIX
    call print_string

    ; al input
    mov al, 0x8F

    mov dl, al
    shr dl, 4
    and dl, 0x0F

    cmp dl, 10         
    jae greater_than_9 

    add dl, 48
    call print_char   

    ret

greater_than_9:
    ADD al, 55  
    call print_char
    ret