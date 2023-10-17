section .data
    cursor_x dd 0
    cursor_y dd 0

; String 

print_string:
    push rax
    push rdi
    push rbx
    push rcx
    push rdx
    call .setup_buffer
    jmp .print_string_loop
    .done_loop:
    pop rbx
    pop rcx
    pop rdx
    pop rdi
    pop rax
    ret

    ; returns here already
    .print_string_loop:
        lodsb
        cmp al, 0
        je .done_loop 
        call .print_char_string
        call inc_cursor_x   
        jmp .print_string_loop

    ; PLEASE NOTE THAT this method does not push any registers, it will just override em haha   
    .print_char_string:
        cmp al, ENTER_SYMBOL
        je .print_char_exit_string

        cmp al, 0
        je .zero_add
        .cont:

        mov edi, VIDEO_MEM    
        mov ecx, [cursor_y]    
        mov edx, [cursor_x]      
        mov ebx, 80     
        imul ecx, ebx      
        add ecx, edx       
        shl ecx, 1 
        add edi, ecx    
        stosw
        ret 

        .zero_add:
        sub al, 12
        jmp .cont

    .setup_buffer:
        mov rax, SCREEN_COLOR
        ret

    .print_char_exit_string:
        ret


print_string_on_new_line:   
    call create_new_line
    call print_string
    ret

; Char

print_char:
    push rdi
    push rax
    push rbx
    push rcx
    push rdx
    cmp al, ENTER_SYMBOL
    je .print_char_exit

    cmp al, 0
    je .zero_add
    .cont:

    mov edi, VIDEO_MEM  
    
    mov ecx, [cursor_y]    
    mov edx, [cursor_x]      
    mov ebx, 80 
    
    imul ecx, ebx      
    add ecx, edx       
    shl ecx, 1 
    add edi, ecx
    stosw 
 
    .print_char_exit:
        pop rdx
        pop rcx
        pop rbx
        pop rax
        pop rdi
        call inc_cursor_x
        ret

    .zero_add:
        mov al, CHAR_ZERO_MARK
        jmp .cont

print_char_on_new_line:
    call create_new_line
    call print_char
    jmp done_string_line
    ret

; Line

check_for_new_line:
    mov al, [cursor_x]
    cmp al, END_OF_LINE
    jae create_new_line
    ret

create_new_line:
    inc dword [cursor_y]
    mov dword [cursor_x], 0
    ret

done_string_line:
    mov dword [cursor_x], 0
    inc dword [cursor_y]
    ret

; Cursor

reset_cursor:
    mov dword [cursor_x], 0
    mov dword [cursor_y], 0
    ret

inc_cursor_x:
    inc dword [cursor_x]
    mov al, [cursor_x]
    cmp al, END_OF_LINE
    jne .exit

    call create_new_line

    .exit:
    ret 
