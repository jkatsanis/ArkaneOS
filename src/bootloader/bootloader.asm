BITS 16        ; Set the assembly mode to 16-bit
ORG 0x7C00     ; The BIOS loads the bootloader to memory location 0x7C00.

section .text
    global _start

_start:
    jmp $       ; Infinite loop (for now)

times 510-($-$$) db 0   ; Fill the rest of the boot sector with zeros
dw 0xAA55               ; Boot signature (end of the boot sector)
