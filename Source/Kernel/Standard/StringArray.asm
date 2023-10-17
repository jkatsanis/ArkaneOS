section .data
    str_arr_size_params dd 2 dup(0)

; Adds the buffer to the string
; esi, src buffer
; edi, dst buffer
; 
; ebx, src sice
; ecx dst size
add_to_string:

    mov edx, 0

    .add_loop:
        mov al, byte [esi + edx]
        mov byte [edi + ecx], al         ; TO user

        inc edx
        inc ecx

        cmp edx, ebx
        je .exit
        jmp .add_loop

    .exit:
    
    inc ecx
    mov byte [edi + ecx], 0

    ret

; String array size
; ecx, size
; esi, buffer
print_string_array:
    push rdx
    mov edx, 0

    cmp ecx, edx
    je .exit

    call create_new_line

    .print_loop:
        mov al, byte [esi + edx]
        call print_char

        inc edx

        cmp edx, ecx
        je .exit
        jmp .print_loop

    .exit:
    pop rdx
    ret

; Searches a value in the str array user str_arr_params for the size and  stuff
; str_arr_params[0] -> size of the str array
; str_arr_params[1] -> size of the str to search for
; esi -> the string array
; edi -> the string to search for
; returns 0 in dl if not found 1 if found
search_value:
    push rcx
    push rbx
    push rax

    mov ecx, 0                              ; user counter (byte cuz yk)
    mov ebx, 0,                             ; input buffer counter

    .compare:
        mov al, byte [esi + ecx]             ; Users
        mov dl, byte [edi + ebx]             ; Input

        cmp ebx, [str_arr_size_params + 1]                        ; Comparing the input buffer counter to the size, when we reached it says we counted up                             
        je .found_setup                         ; all the chars we need to find (Note, need to check for the end of the other string)
        .cont_f:

        cmp ecx, [str_arr_size_params + 0]             ; Comparing the array counter to the array size, at this point we iterated over the whoel array and couldnt 
        je .not_found                           ; find a single string equal to the search

        cmp al, dl                            ; Comparin the input buffer with the string array
        je .increment                            ; Incrementing the counter of the input buffer if a char fron the str array was found
        .cont:

        inc ecx                               ; Incrementing the user array counter
        jmp .compare

        .cont_f_s:
            mov ebx, 0
            jmp .cont_f

        .increment:
            inc ebx
            jmp .cont

        .found_setup:   
            mov al, byte [esi + ecx]    ; Users
            cmp al, 0
            jne .cont_f_s

            mov dl, 1
            jmp .exit


        .not_found:
            mov dl, 0

    .exit:

    mov esi, str_arr_size_params
    mov byte [esi], 0
    inc esi
    mov byte [esi], 0
    xor esi, esi

    pop rax
    pop rbx
    pop rcx

    ret