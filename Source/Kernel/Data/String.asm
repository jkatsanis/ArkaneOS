input_buffer_overflow: db "Input buffer overflow", 0
pressed_enter: db "pressed enter", 0

no_enter: db "no enter key pressed", 0

; Terminal main
shell_text: db "ArkaneOS --> ", 0

; Terminal command
; HELP
%define SEARCH_HELP_SIZE 4
search_help: db "HELP", 0
help_command_msg_1: db "ArkaneOS, literally first verison", 0
help_command_msg_2: db  "WA    :    Write stuff to a memory address", 0
help_command_msg_3: db  "RA    :    Read stuff from a address", 0
help_command_msg_4: db  "CLEAR :    Clears the terminal", 0

; CLEAR
%define CLEAR_COMMAND_SIZE 5    
search_clear: db "CLEAR", 0

; WA
%define WS_COMMAND_SIZE 2
search_ws: db "WA", 0
wa_command_msg_1: db "Enter value: ", 0
wa_command_msg_2: db "Enter a address: ", 0

; Terminal auto messages

command_not_found: db "Command was not found", 0

command_found: db "Command found", 0
