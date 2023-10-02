; Returns 1 in cl if found the value in that string
; esi, the string which should be equal to the input buffer
; ebx the size of the string
compare_string:
    mov ecx, 0
    call .compare_command_loop
    ret

    .compare_command_loop:
        lodsb
        stosb

        cmp ecx, [current_index]
        je .compare_command_loop_final

        cmp al, [input_buffer, ecx]
        jne .compare_command_loop_not_found

        inc ecx

        jmp .compare_command_loop

        .compare_command_loop_not_found:
            mov dl, 0
            ret

        .compare_command_loop_found:
            mov dl, 1
            ret

        .compare_command_loop_final:
            dec ecx
            cmp ecx, ebx
            je .compare_command_loop_found
            jmp .compare_command_loop_not_found

string_to_int_32:
    ; Push and pop rax (safety) -> (pop after using lol)
    ; Input esi -> buffer
    ; Input ebx -> size of buffer
    ; Output eax
    push rcx
    push rbx
    push rdx

    xor ecx, ecx       
    xor eax, eax       

    .parse_digit:
        movzx edx, byte [esi + ecx]   
        cmp ecx, ebx           
        jz .parse_done

        sub edx, '0'            
        imul eax, eax, 10            
        add eax, edx              

        inc ecx                      
        jmp .parse_digit

    .parse_done:
        pop rdx
        pop rbx
        pop rcx
        ret

copy_string_size:
    ; esi pointer to the src string
    ; edi pointer to the dest string
    ; ecx size of src string

    push rdx
    push rax
    mov edx, 0 ; Counter 

    .copy_string_loop:
        mov al, [esi]
        mov byte [edi], al

        inc edi
        inc esi
        inc edx
        cmp edx, ecx
        jl .copy_string_loop

    pop rax
    pop rdx

    ; Adding the 0 terminator
    mov byte [esi], 0

    ret


get_address_input:
    ; edi output of the input address

    push rdx
    push rbx

    call clear_input_buffer

    mov esi, adress_input
    call print_string_on_new_line

    call get_input_wait_for_enter

    push rax
    mov esi, input_buffer
    mov edx, dword [current_index]
    mov ebx, edx
    dec ebx
    call string_to_int_32
    movsx rdx, eax   ; Sign-extend eax into rdx
    mov rdi, 0x000
    add rdi, rdx
    pop rax

    pop rbx
    pop rdx
    ret