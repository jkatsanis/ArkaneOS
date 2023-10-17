; esi -> ptr to buffer
; edx size of buffer
clear_buffer_8:

    mov ecx, 0
    .clear_loop:
        mov byte [esi + ecx], 0
        inc ecx
        cmp ecx, edx
        je .exit

        jmp .clear_loop

    .exit:
    ret

; esi -> ptr to buffer
clear_buffer_null_terminator:

    mov ecx, 0
    .clear_loop:
        mov al, byte [esi + ecx]
        cmp al, 0
        je .exit

        mov byte [esi + ecx], 0
        inc ecx

        jmp .clear_loop

    .exit:
    ret