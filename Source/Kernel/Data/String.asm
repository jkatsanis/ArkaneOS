input_buffer_overflow: db "Input buffer overflow", 0
pressed_enter: db "pressed enter", 0

no_enter: db "no enter key pressed", 0

; Terminal main
shell_text: db "ArkaneOS --> ", 0

; Terminal command
%define SEARCH_HELP_SIZE 4
search_help: db "HELP", 0
help_command_msg: db "Hello this is a help command", 0

command_not_found: db "Command was not found", 0

command_found: db "Command found", 0
