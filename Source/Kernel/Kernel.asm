%define VIDEO_MEM 0xB8000

%include "TextRenderer/Print.asm"
%include "KeyBoard/KeyBoard.asm"

; Strings

t_string: db "Hello Josef", 0

kernel_setup:
    mov edi, VIDEO_MEM 
    mov rax, 0x1f201f201f201f20
    mov ecx, 500
    mov [VIDEO_MEM], rax
    rep stosq
    call kernel_main

kernel_main:

    call read_key

    jmp kernel_main

times KERNEL_SIZE+512-($-$$) db 0   ; + 512 bc fucking bootloader
