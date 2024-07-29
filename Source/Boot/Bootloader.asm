[org 0x7C00]
[bits 16]

; Macros
%define KERNEL_SIZE 1024 ; Kernel syze in bytes


section .text
    global main

main:
    cli
    jmp 0x0000:ZeroSeg
ZeroSeg:
    xor ax, ax
    mov ss, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov sp, main
    cld
    sti

    ; setting disk to 0's
    push ax
    xor ax, ax
    mov dl, 0x80
    int 0x13

    ; load sectors	
    call readDisk

    ; Checking if A20 line is enabled
    call testA20 
    mov dx, ax
    call printh

    ; enabling a20 line
    call enableA20
    
    jmp sector_two
    jmp $
        
%include "Printf.asm"
%include "ReadDisk.asm"
%include "Printh.asm"
%include "TestA20.asm"
%include "EnableA20.asm"

STR: db "2ND S", 0x0a, 0x0d, 0
DISK_ERR_MSG: db "Disk !.", 0x0a, 0x0d, 0
DONE_A20: db "A20", 0x0a, 0x0d, 0
NO_A20: db "A20 !", 0x0a, 0x0d, 0
CPU64_NOT_SUPPORTED: db "LM !", 0x0a, 0x0d, 0
CPU64_SUPPORTED: db "LM", 0x0a, 0x0d, 0

times 510-($-$$) db 0   
dw 0xAA55

sector_two: 
    mov si, STR
    call printf
    call checklm
    cli
    mov edi, 0x1000
    mov cr3, edi
    xor eax, eax
    mov ecx, 4096
    rep stosd 
    mov edi, 0x1000    

    mov dword [edi], 0x2003
    add edi, 0x1000
    mov dword [edi], 0x3003
    add edi, 0x1000
    mov dword [edi], 0x4003
    add edi, 0x1000

    mov dword ebx, 3
    mov ecx, 512

.setEntry:
    mov dword [edi], ebx
    add ebx, 0x1000
    add edi, 8
    loop .setEntry

    mov eax, cr4
    or eax, 1 << 5
    mov cr4, eax

    mov ecx, 0xc0000080
    rdmsr
    or eax, 1 << 8  ; Flipping the 8th bit to get into long mode
    wrmsr
    
    mov eax, cr0
    or eax, 1 << 31 ; Protected mode
    or eax, 1 << 0  ; Paging 
    mov cr0, eax

    lgdt [GDT.Pointer]
    
    jmp 0x08:0x8000
    

%include "CheckLM.asm"
%include "Gdt.asm"

times 1024-($-$$) db 0   
