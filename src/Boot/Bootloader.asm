org 0x7C00
bits 16

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
    mov dl, 0x80
    mov al, 2		
    mov cl, 2		
    mov bx, sector_two		
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

STR: db "Hello OS, 2ND sector", 0x0a, 0x0d, 0
DISK_ERR_MSG: db "Error Loading Disk.", 0x0a, 0x0d, 0
DONE_A20: db "A20 DONE", 0x0a, 0x0d, 0
NO_A20: db "A20 FAILED", 0x0a, 0x0d, 0
CPU64_NOT_SUPPORTED: db "LM !", 0x0a, 0x0d, 0
CPU64_SUPPORTED: db "LM", 0x0a, 0x0d, 0

times 510-($-$$) db 0   
dw 0xAA55

;;;;;;;;;;;;;;;; S TWO ;;;;;;;;

sector_two:
    mov si, STR
    call printf
    call checklm
    jmp $

%include "CheckLM.asm"

times 512 db 0