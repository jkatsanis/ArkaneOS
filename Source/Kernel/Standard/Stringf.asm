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
    ; esi pointer to input buffer (containing only numeric values)
    ; edx 
    mov esi, input_buffer      ; ESI points to the beginning of the string
    xor ecx, ecx       ; Clear ECX to use as a counter
    xor eax, eax       ; Clear EAX to store the result

    .parse_digit:
        movzx edx, byte [esi + ecx]   ; Load the next character into EDX
        test  edx, edx                ; Check if it's the null terminator
        jz    .parse_done

        sub   edx, '0'                ; Convert ASCII character to integer
        imul  eax, eax, 10            ; Multiply the current result by 10
        add   eax, edx                ; Add the new digit to the result

        inc   ecx                      ; Move to the next character
        jmp   .parse_digit

    .parse_done:
        ret