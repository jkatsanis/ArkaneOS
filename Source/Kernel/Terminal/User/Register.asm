; Enter stuff to create a user
reg_command:
    mov esi, reg_command_msg_1
    call print_string_on_new_line

    call get_input_wait_for_enter       ; Getting the user name

    ; TODO: Check if the user name already exists in the table

    mov esi, input_buffer
    mov edi, user_name
    mov ecx, [current_index]
    call copy_string_size


    ret 