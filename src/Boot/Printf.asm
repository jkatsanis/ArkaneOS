printf:
    pusha
    str_loop: 
        mov al, [si]
        cmp al, 0
        jne print_char
        popa
        ret

    print_char:
        mov ah, 0x0e
        int 0x10
        add si, 1
        jmp str_loop

