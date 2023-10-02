section .data
    adress_table_size: dq 0

    ; First "Key -> start" second "Key -> amount of characters"
    adress_table: dq 20 dup(0)     

wt_command:
    call clear_terminal
    call get_address_input

    mov rsi, rdi
    call add_text_adress_table

    call clear_input_buffer
    call get_input_wait_for_enter

    mov ebx, dword [current_index]
    movsx rsi, ebx
    call add_text_adress_table

    mov rdi, 0          ; Reading back the adres inputed
    call read_taxt_adress_table_index

    mov rdi, rdx
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

    mov rbx, 0
    call read_text

    ret

read_text:
    ; Reads text until the count from the table goes to 0
    ; rbx -> index of the adres

    push rdi
    push rcx
    
    mov rdi, rbx
    call read_taxt_adress_table_index
    mov rdi, rdx

    inc rbx

    push rdi
    mov rdi, rbx
    call read_taxt_adress_table_index
    mov rbx, rdx
    pop rdi

    mov rcx, 0

    .wt_loop_read:
        cmp rcx, rbx
        jge .read_done
        mov al, byte [edi]
        call print_char
        inc rdi
        inc rcx
        call .wt_loop_read

    .read_done:

    pop rdi
    pop rcx
    ret


; Text adres table

read_taxt_adress_table_index:
    ; rdi input -> index
    ; rdx output

    mov rdx, rdi         
    imul rdx, rdx, 8    
    lea rdx, [adress_table + rdx] 
    mov rdx, [rdx]     
    ret

add_text_adress_table:
    ; rsi input -> value

    mov rdx, [adress_table_size]      
    imul rdx, rdx, 8    
    lea rdx, [adress_table + rdx] 
    mov qword [rdx], rsi 
    inc qword [adress_table_size]
    ret
