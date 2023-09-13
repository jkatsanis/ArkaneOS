read_key:
    in al, 0x60
    call check_key
    cmp rbx, 1
    jne read_key

    ; Sending ack flag
    mov al, 0xFA 
    out 0x60, al 

    mov al, 'A'
    call print_char_line
    ret

check_key:
    call check_a_released
    ret

    key_return:
        mov rbx, 1
        ret

    key_exit:
        mov rbx, 0
        ret

check_a_released
    cmp al, 0x9E  ; A released
    jne key_exit
    call key_return
    ret
        