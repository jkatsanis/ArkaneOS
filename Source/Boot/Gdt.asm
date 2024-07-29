GDT:
    ; Null Descriptor
    dq 0x0000000000000000   ; 8 bytes

    ; Code Segment Descriptor
    dq 0x00CF9A000000FFFF   ; Base 0x000000, Limit 0xFFFFF, 32-bit, Executable, Readable, Code Segment

    ; Data Segment Descriptor
    dq 0x00CF92000000FFFF   ; Base 0x000000, Limit 0xFFFFF, 32-bit, Writable, Data Segment

GDT.Pointer:
    dw 0x001F               ; Size of GDT - 1 (0x1F = 31 bytes, thus 32 bytes total)
    dq GDT                  ; Address of GDT
