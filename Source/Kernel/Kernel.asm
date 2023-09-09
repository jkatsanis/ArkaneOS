%define VIDEO_MEM 0xB8000

kernel_main:
    mov edi, VIDEO_MEM 
    mov rax, 0x1f201f201f201f201f20
    mov ecx, 500
    mov [VIDEO_MEM], rax
    rep stosq

    mov rax, 0x1f741f731f651f54
    mov [VIDEO_MEM], rax
    jmp $

times 512 db 0   
