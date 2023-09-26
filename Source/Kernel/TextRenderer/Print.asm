%define END_OF_LINE 50

section .data
    cursor_x dd 0
    cursor_y dd 0

inc_cursor_x:
    inc dword [cursor_x]
    ret

print_string:
    lodsb
    cmp al, 0
    je done_string 
    call print_char
    inc dword [cursor_x]    
    jmp print_string

print_string_line:
    lodsb
    cmp al, 0
    je done_string_line  
    call print_char
    inc dword [cursor_x]    
    jmp print_string_line

print_string_on_new_line:   
    call create_new_line
    call print_string
    ret

; PLEASE NOTE THAT this method does not push any registers, it will just override em haha
print_char:
    cmp al, ENTER_SYMBOL
    je print_char_exit

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

print_char_exit:
    ret

print_char_line:
    call print_char
    jmp done_string_line
    ret

print_char_column:
    call print_char
    inc dword [cursor_x]
    call check_for_new_line
    ret

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

done_string:
    ret

reset_cursor:
    mov dword [cursor_x], 0
    mov dword [cursor_y], 0
    ret
