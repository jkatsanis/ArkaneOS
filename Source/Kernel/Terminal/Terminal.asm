write_command:
    mov esi, shell_text
    call print_string
    ret

check_for_sent_command:
    mov edi, 0 ; inti counter
    call check_for_sent_command_loop
    ret

check_for_sent_command_loop:
    mov cl, '-' ; 0x9C is the enter released thingy

    cmp cl, [input_buffer + edi]
    je enter_key_found

    inc edi

    cmp edi, INPUT_BUFFER_SIZE
    je enter_key_not_found

    jmp check_for_sent_command_loop

enter_key_not_found:
    ;   mov esi, no_enter
    ; call print_string
    ret

enter_key_found:
    mov esi, pressed_enter
    call print_string
    
    call clear_input_buffer
    ret    