; Enter stuff to create a user
reg_command:
    mov esi, reg_command_msg_1
    call print_string_on_new_line

    call get_input_wait_for_enter       ; Getting the user name

    ; TODO: Check if the user name already exists in the table

    mov esi, input_buffer
    mov edi, users
    mov ecx, [current_index]
    call copy_string_size

    dec byte [current_index]              ; Decrement the input buffer size by 1 because we dont care about the enter key being pressed lmao
    mov al, [current_index]
    add byte [users_size], al

    mov esi, usr_command_msg_1
    call print_string
    
    call get_input_wait_for_enter

    dec byte [current_index]                ; Decrement the input buffer size by 1 because we dont care about the enter key being pressed lmao

    mov ecx, 0                              ; user counter
    mov esi, users                          ; Users array

    mov ebx, 0,                             ; input buffer counter
    mov edi, input_buffer

    mov edx, [current_index]

    .compare:
        mov al, byte [esi + ecx]             ; Users
        mov dl, byte [edi + ebx]             ; Input

        cmp ebx, edx           ; Comparing the input buffer counter to the size, when we reached it says we counted up                             
        je .found_setup                         ; all the chars we need to find (Note, need to check for the end of the other string)
        .cont_f:

        cmp ecx, [users_size]                ; Comparing the array counter to the array size, at this point we iterated over the whoel array and couldnt 
        je .not_found                           ; find a single string equal to the search

        cmp al, dl                            ; Comparin the input buffer with the string array
        je .increment                            ; Incrementing the counter of the input buffer if a char fron the str array was found
        .cont:

        inc ecx                               ; Incrementing the user array counter
        jmp .compare

        .cont_f_s:
            dec ecx
            mov ebx, 0
            jmp .cont_f

        .increment:
            inc ebx
            jmp .cont

        .found_setup:   
            inc ecx
            mov al, byte [esi + ecx]    ; Users
            cmp al, 0
            jne .cont_f_s

            mov esi, string_array_found
            call print_string

            jmp .exit


        .not_found:
            mov esi, string_array_not_found
            call print_string

        .exit:


    .inf:
        jmp .inf

    ret 