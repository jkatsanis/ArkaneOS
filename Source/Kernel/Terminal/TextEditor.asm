; Create a text at a specifc memory address

section .data
    ; Table of start to end addreses
    ; First "Key -> start" second "Key -> amount of charactersx"
    text_adress_table: dd TEXT_ADRESS_BUFFER_SIZE dup(0)
    text_adress_table_size: dd 0

wt_command:
    call clear_terminal
    call clear_input_buffer
    call get_input_wait_for_enter

    mov edi, 0x0000
    add edi, 555

    mov edx, edi
    call add_text_table

    mov edx, [current_index]
    call add_text_table 

    ; Init
    mov edi, [text_adress_table + 0]
    mov ecx, 0

    .wt_loop_write:
        cmp ecx, [current_index]
        jge .write_done
        mov al, [input_buffer + ecx]
        mov byte [edi], al
        inc ecx
        inc edi
        jmp .wt_loop_write

    .write_done:    




    mov edi, [text_adress_table + 0]
    mov ebx, [text_adress_table + 1]
    mov ecx, 0

    .wt_loop_read:
        cmp ecx, ebx
        jge .read_done
        mov al, byte [edi]
        call print_char
        inc edi
        inc ecx
        call .wt_loop_read

    .read_done

    ret

add_text_table:
    ; input edx (32 bit adress)
    push rdi

    mov edi, text_adress_table
    add edi, [text_adress_table_size]
    mov dword [edi], edx 

    mov dword [text_adress_table_size], 1

    pop rdi
    ret