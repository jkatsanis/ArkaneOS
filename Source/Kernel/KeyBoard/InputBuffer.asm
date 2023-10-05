; Note that the input buffer does not control the UI a bit 

section .data
    bEnter_key_found: db 0
    current_index dd 0
    input_buffer db INPUT_BUFFER_SIZE dup(0)    

add_to_buffer:
    ; dl the data of the buffer
    mov cl, [current_index]
    cmp cl, INPUT_BUFFER_SIZE
    jge .add_buffer_overflow     

    mov edi, input_buffer  
    add edi, [current_index]
    mov byte [edi], dl

    inc dword [current_index]    
    ret

    .add_buffer_overflow:
        mov esi, input_buffer_overflow
        call print_string
        ret


print_input_buffer:
    mov esi, input_buffer

    mov ecx, dword [current_index]
    mov edx, ecx
    dec edx

    mov ecx, 0

    .print_loop:      
        mov al, [esi]
        cmp ecx, edx
        je .print_done

        call print_char
        
        inc esi
        inc ecx
        jmp .print_loop

    .print_done:
        ret

; Clear buffer

clear_input_buffer:

    mov byte [bEnter_key_found], 0
    mov edi, input_buffer
    mov cl, 0
    call .clear_input_buffer_loop
    mov dword [current_index], 0
    .done_clearing_input_buffer:
    ret

    .clear_input_buffer_loop: 
        cmp cl, INPUT_BUFFER_SIZE
        je .done_clearing_input_buffer
        mov byte [edi], 0
        inc edi
        inc cl
        jmp .clear_input_buffer_loop