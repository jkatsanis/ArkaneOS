write_sector:
    mov al, 0xA0
    out 0x1F6, al

    mov al, 1
    out 0x1F2, al

    mov al, 3
    out 0x1F3, al

    mov al, 0
    out 0x1F4, al

    mov al, 0
    out 0x1F5, al

    mov al, 0x20
    out 0x1F7, al

    mov al, 'A'
    out 0x30, al

    ret

read_sector:
    mov al, 0xA0
    out 0x1F6, al

    mov al, 1
    out 0x1F2, al

    mov al, 3
    out 0x1F3, al

    mov al, 0
    out 0x1F4, al

    mov al, 0
    out 0x1F5, al

    mov al, 0x20
    out 0x1F7, al


    in al, 0x20
    call print_char

    ret
