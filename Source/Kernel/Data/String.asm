section .data
    input_buffer_overflow: db "Input buffer overflow", 0
    pressed_enter: db "pressed enter", 0

    no_enter: db "no enter key pressed", 0

    ; Terminal main
    shell_text: db "ArkaneOS --> ", 0

    ; Terminal command
    ; HELP
    %define SEARCH_HELP_SIZE 4
    search_help:                db "HELP", 0
    help_command_msg_1:         db  "ArkaneOS, literally first verison", 0
    help_command_msg_2:         db  "WA    :    Write stuff to a memory address", 0
    help_command_msg_3:         db  "RA    :    Read stuff from a address", 0
    help_command_msg_4:         db  "CLEAR :    Clears the terminal", 0
    help_command_msg_5:         db  "WT    :    Write text at a specifc memory address", 0
    help_command_msg_6:         db  "RT    :    Read text at a specifc memory address", 0
    help_command_msg_user:      db  "USERS      -----------------", 0
    help_command_msg_7:         db  "USR   :    Gives current information of the user", 0
    help_command_msg_8:         db  "REG   :    Register a user", 0
    help_command_msg_9:         db  "LOG   :    Login with a registered user", 0
    help_command_msg_10:        db  "OUT   :    Logout", 0

    ; CLEAR
    %define CLEAR_COMMAND_SIZE 5    
    search_clear: db "CLEAR", 0

    ; WA (Write adress)
    %define WA_COMMAND_SIZE 2
    search_ws: db "WA", 0
    wa_command_msg_1: db "Enter value: ", 0
    wa_command_msg_3: db "Address: ", 0
    wa_command_msg_4: db "has value: ", 0

    ; RA (Read address)
    %define RA_COMMAND_SIZE 2
    search_ra: db "RA", 0

    ; WT (Write Text editor)
    %define WT_COMMAND_SIZE 2
    search_wt: db "WT", 0
    wt_command_enter_value: db "Enter text: ", 0

    ; RT (Read Text editor)
    %define RT_COMMAND_SIZE 2
    search_rt: db "RT", 0
    rt_not_found: db "Adress was not found in the table!", 0

    ; USR (User info)
    %define USR_COMMAND_SIZE 3
    search_usr: db "USR", 0
    usr_command_msg_1: db "Current user name: ", 0
    usr_command_msg_2: db "User names available: ", 0

    ; REG (Register (create a user account))
    %define REG_COMMAND_SIZE 3
    search_reg: db "REG", 0
    reg_command_msg_1: db "Enter user name to register: ", 0

    ; LOG (LOGIN with a registered user)
    %define LOG_COMMAND_SIZE 3
    search_log: db "LOG", 0
    log_command_msg_1: db "Login with a registered user: ", 0
    log_command_msg_2: db "Succesfully logged in", 0
    log_command_msg_3: db "Coul not find the user you looking for", 0

    ; OUT (Logout)
    %define OUT_COMMAND_SIZE 3
    search_out: db "OUT", 0
    out_command_msg_1: db "Succesfully logged out", 0

    ; General message
    adress_input: db "Enter a adress: ", 0

    string_array_found: db "String found in the array", 0
    string_array_not_found: db "String not found in the array", 0

    ; Terminal auto messages
    command_not_found: db "Command was not found", 0
    command_found: db "Command found", 0
