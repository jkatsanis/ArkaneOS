%define VIDEO_MEM 0xB8000

%include "Data/Macros.asm"
%include "TextRenderer/Print.asm"
%include "KeyBoard/KeyBoard.asm"
%include "Data/String.asm"
%include "Terminal/Terminal.asm"

kernel_setup:
    mov edi, VIDEO_MEM 
    mov rax, 0x1f201f201f201f20
    mov ecx, 500
    mov [VIDEO_MEM], rax
    rep stosq
    call write_command
    call kernel_main

kernel_main:

    call read_key
    call check_for_sent_command


    jmp kernel_main

times KERNEL_SIZE+512-($-$$) db 0   ; + 512 bc fucking bootloader
