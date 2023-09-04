BITS 16        ; Set the assembly mode to 16-bit
ORG 0x7C00     ; The BIOS loads the bootloader to memory location 0x7C00.

boot:
    mov ah, 0x02
    mov al, 0x01
    mov ch, 0x00
    mov cl, 0x02
    mov dh, 0x00
    mov dl, 0x00
    mov bx, 0x1000
    int 0x13
    jc disk_error
    mov ah, 0x0e
    mov al, "$"
    mov bh, 0
    int 0x10
    jmp 0x1000

disk_error:
    mov ah, 0x0c
    mov al, "!"
    mov bh, 0
    int 0x10
    hlt

times 510-($-$$) db 0   ; Fill the rest of the boot sector with zeros
dw 0xAA55               ; Boot signature (end of the boot sector)
