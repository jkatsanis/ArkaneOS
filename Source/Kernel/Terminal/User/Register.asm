; Enter stuff to create a user
reg_command:
    mov esi, reg_command_msg_1
    call print_string_on_new_line

    call get_input_wait_for_enter       ; Getting the user name

    ; TODO: Check if the user name already exists in the table
    dec byte [current_index]              ; Decrement the input buffer size by 1 because we dont care about the enter key being pressed lmao

    mov esi, input_buffer
    mov edi, users
    mov ebx, [current_index]
    mov ecx, [users_size]
    call add_to_string

    add dword [users_size], ebx
    inc dword [users_size]          ; Inc to add the 0 terminator
    ret 


log_command:
    mov esi, log_command_msg_1
    call print_string_on_new_line
    
    call get_input_wait_for_enter
    dec byte [current_index]
    
    ; search value parameters
    mov edx, [users_size]
    mov dword [str_arr_size_params + 0], edx

    mov edx, [current_index]
    mov dword [str_arr_size_params + 1], edx

    mov esi, users
    mov edi, input_buffer

    call search_value
    ; Return value
    cmp dl, 1
    je .found

    .not_found:
        mov esi, log_command_msg_3
        call print_string_on_new_line
        ret

    .found:
        mov esi, log_command_msg_2
        call print_string_on_new_line

        ; Login as (user)
        mov esi, input_buffer
        mov edi, user_name
        mov ecx, [current_index]
        call copy_string_size

    ret     


out_command:
    mov esi, user_name
    call clear_buffer_null_terminator
    call user_name_setup
    ret