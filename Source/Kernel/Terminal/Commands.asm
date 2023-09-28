; COMMANDS
; HELP
prepare_help_command:
    call .help_command
    ret

    .help_command:   
        mov esi, help_command_msg_1
        call print_string_on_new_line

        mov esi, help_command_msg_2
        call print_string_on_new_line

        mov esi, help_command_msg_3
        call print_string_on_new_line

        mov esi, help_command_msg_4
        call print_string_on_new_line

        ret

; CLEAR

prepare_clear_command:
    call .clear_command
    ret

    .clear_command:
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