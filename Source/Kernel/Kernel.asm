%include "Data/Macros.asm"
%include "Data/String.asm"

%include "Standard/Stringf.asm"

%include "Terminal/User/Register.asm"
%include "Terminal/User/User.asm"
%include "Terminal/TextEditor/TextTable.asm"
%include "Terminal/TextEditor/TextEditor.asm"
%include "Terminal/Address.asm"
%include "Terminal/Terminal.asm"
%include "Terminal/Commands.asm"

%include "KeyBoard/KeyTable.asm"
%include "KeyBoard/InputBuffer.asm"
%include "KeyBoard/KeyBoard.asm"

%include "TextRenderer/PrintHex.asm"
%include "TextRenderer/Print.asm"

kernel_setup:
    ; usr
    call usr_setup

    call clear_terminal
    call write_command
    call kernel_main

kernel_cleanup:
    call clear_input_buffer
    ret

kernel_main:
    call get_input_wait_for_enter
    call process_command    
    
    ; Cleanup
    call kernel_cleanup
    jmp kernel_main
    
times KERNEL_SIZE+512-($-$$) db 0   ; + 512 bc fucking bootloader
