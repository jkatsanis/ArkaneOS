wt_command:
    call get_address_input

    push rdi

    mov rsi, rdi
    call add_text_adress

    mov esi, wt_command_enter_value
    call print_string_on_new_line

    call clear_input_buffer
    call get_input_wait_for_enter

    mov ebx, dword [current_index]
    movsx rsi, ebx
    call add_text_adress

    pop rdi       ; adress of the input
    mov ecx, 0

    .wt_loop_write:                     ; Writing the input buffer to the adress
        cmp ecx, [current_index]
        jge .write_done
        mov al, [input_buffer + ecx]
        mov byte [rdi], al
        inc ecx
        inc rdi
        jmp .wt_loop_write

    .write_done:    

    ret

rt_command:
    call get_address_input
    
    mov rsi, rdi
    call get_adress_index

    call read_text_table

    ret