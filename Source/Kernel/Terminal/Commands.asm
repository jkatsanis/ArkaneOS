; COMMANDS
; HELP
prepare_help_command:
    call help_command
    ret

help_command:   
    mov esi, help_command_msg_1
    call print_string

    call write_command

    mov esi, help_command_msg_2
    call print_string

    call write_command
    mov esi, help_command_msg_3
    call print_string

    call write_command
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
    call wa_command
    ret

wa_command:
    mov al, 'A'
    call print_char
    ret
