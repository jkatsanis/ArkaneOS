%define VIDEO_MEM 0xB8000

%include "Data/Macros.asm"
%include "TextRenderer/Print.asm"
%include "KeyBoard/KeyBoard.asm"
%include "Data/String.asm"
%include "Terminal/Terminal.asm"
%include "Disk/Disk.asm"
%include "TextRenderer/PrintHex.asm"

kernel_setup:
    call clear_terminal
    call write_command
    call kernel_main

kernel_main:

    ; call read_key
    ; call check_for_sent_command

    ; call write_sector
    ; call read_sector

    call print_hex

    jmp $


times KERNEL_SIZE+512-($-$$) db 0   ; + 512 bc fucking bootloader
