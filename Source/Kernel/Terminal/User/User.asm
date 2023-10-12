section .data
    user_name: db MAX_USER_NAME_SIZE dup(0)
    user_password: db MAX_USER_PW_SIZE dup(0)

    ; MAP of users
        ; Name;Password
    users: db 100 dup(0)
    users_size: dd 0

usr_setup:
    push rdi
    mov esi, user_name
    mov byte [esi], '<' 
    mov byte [esi+1], '!' 
    mov byte [esi+2], '>'  
    mov byte [esi+3], 0   
    pop rdi
    ret

; Gives information about the user
usr_command:

    mov esi, usr_command_msg_1
    call print_string_on_new_line

    mov esi, user_name
    call print_string
    ret