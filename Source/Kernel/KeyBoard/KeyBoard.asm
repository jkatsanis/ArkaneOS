section .data
   map db 0x9E, 65    ; Key: 1, Value: 10  

read_key:
    in al, 0x60
    call check_key
    cmp bl, 1
    jne read_key

    call send_ack_flag

    call print_char_line
    ret

check_key:
    call check_a_released
    check_key_exit:
    ret

key_exit:
    mov bl, 0
    jmp check_key_exit

check_a_released:
    mov bl, 1
    cmp al, 0x9E  ; A released
    jne key_exit

    mov dl, al
    call find_value
    ret

send_ack_flag:
    push ax
    mov al, 0xFA 
    out 0x60, al 
    pop ax
    ret

find_value:
    mov edi, 0
    cmp dl, [map + edi]
    je found
    add edi, 2
    ret

found:
    mov al, [map + edi + 1]
    ret

not_found:
    mov al, 0xFF

