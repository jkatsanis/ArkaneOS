section .data
    address_value_input_buffer: db 0

; Input a value to a address you specify and have it stored there
wa_command:
    call get_input_wait_for_enter
    
    push rax
    mov esi, input_buffer
    mov edx, [current_index]
    mov ebx, edx
    dec ebx
    call string_to_int
    mov byte [address_value_input_buffer], al            ; Storing the value which i got through the input in the buffer
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

    mov al, [address_value_input_buffer]
    ; Moving the value into the address
    mov byte [edi], al

    mov esi, wa_command_msg_3
    call print_string_on_new_line

    mov esi, input_buffer
    call print_string   

    mov esi, wa_command_msg_4
    call print_string

    ; Getting the value back from the address to print it out
    mov dl, byte [edi]
    movzx ax, dl
    call print_hex_8 

    call .cleanup
    ret

    .cleanup:
        mov byte [address_value_input_buffer], 0
        call clear_input_buffer   ; Clearing the input buffer here anyways, because this method modifies it
        ret

ra_command:
    mov esi, ra_command_msg_1
    call print_string_on_new_line

    call clear_input_buffer
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

    mov dl, byte [edi]
    movzx ax, dl
    call print_hex_8 
    ret