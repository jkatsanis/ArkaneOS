write_command:
    mov esi, shell_text
    call print_string
    ret

check_for_sent_command:
    mov edi, 0 ; inti counter
    call check_for_sent_command_loop
    ret

; receive command (controlled by enter)

check_for_sent_command_loop:
    mov cl, ENTER_SYMBOL ; 0x9C is the enter released thingy

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
    call process_command  
    
    ; Clearing the input buffer
    call clear_input_buffer
    ret    

; process command after pressing enter

process_command:
    call create_new_line
    mov esi, shell_text
    call print_string

    call execute_command

    call create_new_line
    mov esi, shell_text
    call print_string

    ret

execute_command:
    mov edi, [current_index]
    dec edi

    mov esi, input_buffer
    add esi, edi
    mov byte [esi], 0

    mov esi, search_help
    mov ebx, SEARCH_HELP_SIZE
    call compare_command_setup
    cmp dl, 1
    je prepare_help_command
    continue_command_help:

    ret 

; Returns 1 in cl if found a value in that string
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
    mov esi, command_not_found
    call print_string

    mov dl, 0
    ret

compare_command_loop_found:
    ; mov esi, command_found
    ; call print_string

    mov dl, 1
    ret

compare_command_loop_final:
    dec ecx
    cmp ecx, ebx
    je compare_command_loop_found
    jmp compare_command_loop_not_found


prepare_help_command:
    mov esi, help_command_msg
    call print_string
    ; call help_command
    jmp continue_command_help

help_command:   
    mov esi, help_command_msg
    call print_string
    ret