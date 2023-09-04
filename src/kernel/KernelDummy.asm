org 1000
bits 16

section .text
    global _start

_start:
    mov ah, 0x0e
    mov al, "?"
    mov bh, 0x1000
    int 0x10
    jmp _start

.done
    hlt

times 510-($-$$) db 0   ; Fill the rest of the boot sector with zeros
dw 0xAA55               ; Boot signature (end of the boot sector)
