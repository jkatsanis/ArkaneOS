section .data
    cursor_x dd 0
    cursor_y dd 0


print_string:
    lodsb
    cmp al, 0
    je done  
    call print_char
    inc dword [cursor_x]    
    jmp print_string

print_char:
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

done:
    mov dword [cursor_x], 0
    inc dword [cursor_y]
    ret