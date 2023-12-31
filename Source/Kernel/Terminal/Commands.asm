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

        mov esi, help_command_msg_5
        call print_string_on_new_line

        mov esi, help_command_msg_6
        call print_string_on_new_line

        mov esi, help_command_msg_user
        call print_string_on_new_line

        mov esi, help_command_msg_7
        call print_string_on_new_line

        
        mov esi, help_command_msg_8
        call print_string_on_new_line

        mov esi, help_command_msg_9
        call print_string_on_new_line

        mov esi, help_command_msg_10
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
    call wa_command
    ret

; RA

prepare_ra_command:
    call ra_command
    ret

; WT

prepare_wt_command:
    call wt_command
    ret

; RT

prepare_rt_command:
    call rt_command
    ret

; USR

prepare_usr_command:
    call usr_command
    ret

; REG

prepare_reg_command:
    call reg_command
    ret

; LOG

prepare_log_command:
    call log_command
    ret

prepare_out_command:
    call out_command
    ret