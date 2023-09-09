kernel_main:
    mov rax, 0x1f741f731f651f54
    mov [0xB8000], rax
    jmp $
    hlt    

times 512 db 0   
