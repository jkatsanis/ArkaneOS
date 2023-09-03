BITS 16        ; Set the assembly mode to 16-bit
ORG 0x7C00     ; The BIOS loads the bootloader to memory location 0x7C00.

section .text
    global _start

_start:
    xor ax, ax     ; Clear the ax register
    mov ds, ax     ; Initialize the data segment (ds) to 0
    mov es, ax     ; Initialize the extra segment (es) to 0

    ; Set up the video memory location
    mov ah, 0x0E   ; Function to print a character with attribute
    mov al, 'H'    ; Character to print
    mov bh, 0      ; Page number (0 for single page text mode)
    mov bl, 0x07   ; Text attribute (white on black)

    ; Position cursor at row 0, column 0 (top-left corner)
    mov dh, 0
    mov dl, 0
    int 0x10       ; Call BIOS interrupt to set cursor position

    ; Print the character
    int 0x10       ; Call BIOS interrupt to print character   
    jmp $

times 510-($-$$) db 0   ; Fill the rest of the boot sector with zeros
dw 0xAA55               ; Boot signature (end of the boot sector)
