section .data
    adress_table_size: dq 0

    ; First "Key -> start" second "Key -> amount of characters"
    adress_table: dq 20 dup(0)     

wt_command:
    call get_address_input

    push rdi

    mov rsi, rdi
    call add_text_adress_table

    call clear_input_buffer
    call get_input_wait_for_enter

    mov ebx, dword [current_index]
    movsx rsi, ebx
    call add_text_adress_table

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
    call get_index

    call read_text_table

    ret

get_index:
    ; Searches for the index with the inputed adres
    ; input -> rsi
    ; output -> rbx (index)
    ; dl 1 when found 0 when not found

    push rdi
    mov rbx, 0 ; counter

    .search_loop:
        mov rdi, rbx
        call read_taxt_adress_table_index

        cmp rdx, rsi
        je .found

        cmp rbx, [adress_table_size]
        je .not_found

        inc rbx
        jmp .search_loop

    .found:
        pop rdi
        mov dl, 1
        ret

    .not_found:
        pop rdi

        ; Error codes
        mov esi, rt_not_found
        call print_string
        mov dl, 0
        ret

read_text_table:
    ; Reads text until the count from the table goes to 0
    ; rbx -> index of the adres
    ; changes the value of the rbx register
    cmp dl, 0
    je .exit

    push rdi
    push rcx
    push rdx
    
    mov rdi, rbx

    call read_taxt_adress_table_index
    mov rdi, rdx

    inc rbx

    push rdi
    mov rdi, rbx
    call read_taxt_adress_table_index
    mov rbx, rdx
    pop rdi

    mov ecx, 0

    .wt_loop_read:
        cmp rcx, rbx
        jge .read_done
        mov al, byte [edi]
        call print_char
        inc rdi
        inc rcx
        jmp .wt_loop_read

    .read_done:

    pop rdx
    pop rcx
    pop rdi

    .exit:
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
    ; rdx output

    mov rdx, [adress_table_size]      
    imul rdx, rdx, 8    
    lea rdx, [adress_table + rdx] 
    mov qword [rdx], rsi 
    inc qword [adress_table_size]
    ret
