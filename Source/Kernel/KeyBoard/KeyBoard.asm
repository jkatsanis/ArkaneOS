read_key:
    call .read_key_setup
    ret
    
    .read_key_loop:
        in al, 0x60
        call .check_key     ; Calls the check key routine, the key will be in dl
        cmp bl, 1           ; If a key gets found bl will be set to 1
        jne .read_key_loop
        ret

        .check_key:
            mov esi, 0
            call .check_key_released
            ret

        .check_key_released:
            cmp al, [map + esi] 
            je .continue

            cmp esi, MAP_SIZE
            je .key_not_found

            add esi, 2

            jmp .check_key_released

            .continue:
            mov dl, al      ; Moving the KeyCode into dl to find the actual char representation4
            call find_value

            cmp al, 0xFF    ; Find value returns 0xFF when its NOT found
            jne .key_found
            jmp .key_not_found

            .key_not_found:
                mov bl, 0
                ret
            
            .key_found:
                mov bl, 1
                ret

     
    .send_ack_flag:
        push rax
        mov al, 0xFA 
        out 0x60, al 
        pop rax
        ret

    .read_key_setup:
        push rbx
        push rcx
        push rdx 
        
        call .read_key_loop
        call .send_ack_flag
        mov dl, al
        call add_to_buffer    

        call print_char_column

        pop rbx
        pop rcx
        pop rdx
        ret

