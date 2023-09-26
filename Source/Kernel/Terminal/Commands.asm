; COMMANDS
; HELP
prepare_help_command:
    call help_command
    ret

help_command:   
    call create_new_line
    mov esi, help_command_msg_1
    call print_string


    call create_new_line
    mov esi, help_command_msg_2
    call print_string

    call create_new_line
    mov esi, help_command_msg_3
    call print_string

    call create_new_line
    mov esi, help_command_msg_4
    call print_string

    ret

; CLEAR

prepare_clear_command:
    call clear_command
    ret
clear_command:
    mov esi, help_command_msg_4
    call print_string
    call clear_terminal
    ret

; WA
prepare_wa_command:
    call clear_input_buffer

    mov esi, wa_command_msg_1   
    call print_string_on_new_line
    
    call wa_command
    ret

section .data
    testi: db 0
    result db 0          ; Initialize to 0
    result_len equ 10 

wa_command:
    call get_input_wait_for_enter

    ; Got a value 
    push rax
    mov esi, input_buffer
    mov edx, [current_index]
    mov ebx, edx
    dec ebx
    call string_to_int
    mov byte [testi], al
    pop rax

    call clear_input_buffer

    mov esi, wa_command_msg_2
    call print_string_on_new_line

    call get_input_wait_for_enter

    push rax
    mov esi, input_buffer
    mov edx, dword [current_index]
    mov ebx, edx
    dec ebx
    call string_to_int
    mov edi, 0x000
    add edi, eax
    pop rax

    mov al, [testi]

    mov byte [edi], al
    mov dl, byte [edi]

    ; dl contains the value from the address of the input
    

    inf_loop:
    jmp inf_loop

    ret
