section .data
    HEX_PATTERN_64: db "0x****", 0
    HEX_TABLE_64: db "0123456789abcdef"
    HEX_PATTERN_8: db "0x**", 0

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

print_hex_8:    
    mov cx, ax

    .calc_loop:
        mov bl, 16
        div bl ; div ax / bx

        call get_hex_value ; ah contains already the value

        cmp cx, 15          ; Hardcoding it lol
        jle .convert_1_value ;Because hahaaha

        mov [HEX_PATTERN_8 + 3], dl
        cmp al, 16
        jl .calc_done
        movzx ax, al
        jmp .calc_loop

    .calc_done:
        ; The remainder need to be still in hex 
        mov ah, al
        call get_hex_value
        mov [HEX_PATTERN_8 + 2], dl
        mov esi, HEX_PATTERN_8
        call print_string
        ret
    
    .convert_1_value:
        mov [HEX_PATTERN_8 + 2], dl
        mov esi, HEX_PATTERN_8
        call print_string
        ret


get_hex_value:
    ; output dl
    ; ah the hex number index of the hex table
    push rax
    mov esi, HEX_TABLE
    movzx eax, ah
    add esi, eax

    mov dl, [esi] ; dl contains the actual value in ASCII
    pop rax
    ret