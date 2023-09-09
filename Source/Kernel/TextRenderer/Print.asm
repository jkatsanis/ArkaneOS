print_char_lm:
    mov edi, VIDEO_MEM  

    mov ah, 0x0F  ; Attribute 0x0F = White text on Black background    
    ; mov al, 'A'  ; Load the ASCII character 'A' into AL

    mov [VIDEO_MEM], ax
    stosw
    ret

