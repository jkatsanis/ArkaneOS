%define MAP_SIZE 54

section .data                                                                                                                                                                                                                                                                                             ; Enter released
    map db 0x9E, 'A', 0xB0, 'B', 0xAE, 'C', 0xA0, 'D', 0x92, 'E', 0xA1, 'F', 0xA2, 'G', 0xA3, 'H', 0x97, 'I', 0xA4, 'J', 0xA5, 'K', 0xA6, 'L', 0xB2, 'M', 0xB1, 'N', 0x98, 'O', 0x99, 'P', 0x90, 'Q', 0x93, 'R', 0x9F, 'S', 0x94, 'T', 0x96, 'U', 0xAF, 'V', 0x91, 'W', 0xAD, 'X', 0x95, 'Y', 0xAC, 'Z', 0x9C, '-'          

find_value:
    mov edi, 0
    call find_value_loop
    find_value_exit:
    ret

find_value_loop:    
    cmp dl, [map + edi]
    je found_value
    add edi, 2
    cmp edi, MAP_SIZE
    je not_found
    jmp find_value_loop

found_value:
    mov al, [map + edi + 1]
    jmp find_value_exit

not_found:
    mov al, 0xFF
    jmp find_value_exit



