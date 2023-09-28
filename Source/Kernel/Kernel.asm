%include "Data/Macros.asm"
%include "Data/String.asm"

%include "Standard/Stringf.asm"

%include "Terminal/Address.asm"
%include "KeyBoard/KeyTable.asm"
%include "KeyBoard/InputBuffer.asm"
%include "Terminal/Commands.asm"
%include "TextRenderer/Print.asm"
%include "KeyBoard/KeyBoard.asm"
%include "Terminal/Terminal.asm"
%include "TextRenderer/PrintHex.asm"

kernel_setup:
    call clear_terminal
    call write_command
    call kernel_main

kernel_cleanup:
    call clear_input_buffer
    ret

kernel_main:

    mov ax, 20
    call print_hex_8

    jmp $

times KERNEL_SIZE+512-($-$$) db 0   ; + 512 bc fucking bootloader
