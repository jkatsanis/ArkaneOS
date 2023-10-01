section .data
    hex_pattern_64: db "0x****", 0
    hex_table_64: db "0123456789abcdef"
    hex_pattern_8: db "0x**", 0

print_hex:
    ; dx input
    mov esi, hex_pattern_64
    mov bx, dx
    shr bx, 12
    mov al, bl
    add al, '0'
    mov [hex_pattern_64 + 2], al

    mov bx, dx
    shr bx, 8
    and bx, 0x000f
    mov al, bl
    add al, '0'
    mov [hex_pattern_64 + 3], al

    mov bx, dx
    shr bx, 4
    and bx, 0x000f
    mov al, bl
    add al, '0'
    mov [hex_pattern_64 + 4], al

    mov bx, dx
    and bx, 0x000f
    mov al, bl
    add al, '0'
    mov [hex_pattern_64 + 5], al

    call print_string
    ret

print_hex_8:  
    ; ax input hex

    push rbx
    push rcx
    push rdx
    push rdi
    mov cx, ax

    .calc_loop:
        mov bl, 16
        div bl ; div ax / bx ; After division, AL = (quotient), AH = (remainder)

        call get_hex_value ; ah contains already the value

        cmp cx, 15          ; Hardcoding it lol
        jle .convert_1_value ;Because hahaaha

        mov [hex_pattern_8 + 3], dl
        cmp al, 16
        jl .calc_done
        movzx ax, al
        jmp .calc_loop

    .calc_done:
        mov ah, al           ; The remainder need to be still in hex 
        call get_hex_value
        call .print_hex_string
        jmp .print_hex_exit
    
    .convert_1_value:
        call .print_hex_string
        jmp .print_hex_exit

    .print_hex_string:
        mov [hex_pattern_8 + 2], dl
        mov esi, hex_pattern_8
        mov rax, SCREEN_COLOR       ; For whatever reason this method modifys rax (screen shit) and i need to reset it
        call print_string
        ret

    .print_hex_exit:
        pop rdi
        pop rdx
        pop rcx
        pop rbx
        call clear_hex_pattern_8
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

clear_hex_pattern_8:
    push rax
    mov al, '*'
    mov [hex_pattern_8 + 3], al
    mov [hex_pattern_8 + 2], al
    pop rax
    ret