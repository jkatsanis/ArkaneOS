%include "KeyTable.asm"
%include "InputBuffer.asm"

read_key:
    in al, 0x60
    call check_key
    cmp bl, 1
    jne read_key
    
    call send_ack_flag

    mov dl, al
    call add_to_buffer
    
    call print_char_column
    ret

check_key:
    mov esi, 0
    call check_key_released
    check_key_exit:
    ret

key_not_found:
    mov bl, 0
    jmp check_key_exit

key_found:
    mov bl, 1
    jmp check_key_exit

check_key_released:
    cmp al, [map + esi] 
    je test

    cmp esi, MAP_SIZE
    je key_not_found

    add esi, 2

    jmp check_key_released

    test:
    mov dl, al
    call find_value

    cmp al, 0xFF
    jne key_found

send_ack_flag:
    push ax
    mov al, 0xFA 
    out 0x60, al 
    pop ax
    ret
