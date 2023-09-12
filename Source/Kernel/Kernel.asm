%define VIDEO_MEM 0xB8000

%include "TextRenderer/Print.asm"

; Strings

t_string: db "Hello Josef", 0

kernel_main:
    mov edi, VIDEO_MEM 
    mov rax, 0x1f201f201f201f20
    mov ecx, 500
    mov [VIDEO_MEM], rax
    rep stosq

    mov esi, t_string
    call print_string

    jmp $

times KERNEL_SIZE+512-($-$$) db 0   ; + 512 bc fucking bootloader
