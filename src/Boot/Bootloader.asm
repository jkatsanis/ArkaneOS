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

    ; Checking if A20 line is enabled
    call testA20 
    mov dx, ax
    call printh
    jmp $

    ; reading the 2nd sector
    ; mov al, 1
    ; mov cl, 2
    ; call readDisk

    ; mov dx, [0x7C00 + 510]
    ; call printh
        
%include "Printf.asm"
%include "ReadDisk.asm"
%include "Printh.asm"
%include "TestA20.asm"

STR: db "Hello OS, 2ND sector", 0       
DISK_ERR_MSG: db "Error Loading Disk.", 0x0a, 0x0d, 0
A20_ENABLED: db "A20 Enabled", 0

times 510-($-$$) db 0   
dw 0xAA55

times 512 db 0