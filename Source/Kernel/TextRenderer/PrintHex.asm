HEX_PATTERN_64: db '0x****', 0

HEX_PATTERN_8: db '0x*', 0

print_hex:
    ; dx input
    mov esi, HEX_PATTERN_64
    mov bx, dx
    shr bx, 12
    mov al, bl
    add al, '0'
    mov [HEX_PATTERN_64 + 2], al

    mov bx, dx
    shr bx, 8
    and bx, 0x000f
    mov al, bl
    add al, '0'
    mov [HEX_PATTERN_64 + 3], al

    mov bx, dx
    shr bx, 4
    and bx, 0x000f
    mov al, bl
    add al, '0'
    mov [HEX_PATTERN_64 + 4], al

    mov bx, dx
    and bx, 0x000f
    mov al, bl
    add al, '0'
    mov [HEX_PATTERN_64 + 5], al

    call print_string
    ret

