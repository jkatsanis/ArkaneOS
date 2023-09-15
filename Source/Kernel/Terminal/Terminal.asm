%include "Commands.asm"

; Write the default ArkaneOS ---> comand top left
write_command:
    mov esi, shell_text
    call print_string_on_new_line
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
    ret

enter_key_found:
    call process_command  
    call clear_input_buffer
    ret    

; process command after pressing enter
process_command:
    call write_command

    call execute_command

    call write_command
    ret

execute_command:
    mov edi, [current_index]
    dec edi

    mov esi, input_buffer
    add esi, edi
    mov byte [esi], 0

    ; Returns in the je instruction usally

    ; HELP
    mov esi, search_help
    mov ebx, SEARCH_HELP_SIZE
    call compare_command_setup
    cmp dl, 1
    je prepare_help_command

    ; ClEAR
    mov esi, search_clear
    mov ebx, CLEAR_COMMAND_SIZE
    call compare_command_setup
    cmp dl, 1
    je prepare_clear_command

    ; Printing a message for not found command
    mov esi, command_not_found 
    call print_string

    ret 

; Clear terminal

clear_terminal:
    mov edi, VIDEO_MEM 
    mov rax, 0x1f201f201f201f20
    mov ecx, 500
    mov [VIDEO_MEM], rax
    rep stosq
    call reset_cursor
    ret
