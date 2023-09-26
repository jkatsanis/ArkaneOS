; Returns 1 in cl if found the value in that string
; esi, the string which should be equal to the input buffer
; ebx the size of the string
compare_command_setup:
    mov ecx, 0
    call compare_command_loop
    ret

compare_command_loop:
    lodsb
    stosb

    cmp ecx, [current_index]
    je compare_command_loop_final

    cmp al, [input_buffer, ecx]
    jne compare_command_loop_not_found

    inc ecx

    jmp compare_command_loop

compare_command_loop_not_found:
    mov dl, 0
    ret

compare_command_loop_found:
    mov dl, 1
    ret

compare_command_loop_final:
    dec ecx
    cmp ecx, ebx
    je compare_command_loop_found
    jmp compare_command_loop_not_found

string_to_int:
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