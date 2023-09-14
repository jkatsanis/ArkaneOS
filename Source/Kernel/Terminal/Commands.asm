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
    ; Printing a message for not found command
    mov esi, command_not_found 
    call print_string

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

; COMMANDS
; HELP
prepare_help_command:
    call help_command
    jmp continue_command_help

help_command:   
    mov esi, help_command_msg
    call print_string
    ret