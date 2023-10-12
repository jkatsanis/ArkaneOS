section .data
    adress_table_size: dq 0

    ; First "Key -> start" second "Key -> amount of characters"
    adress_table: dq TEXT_ADRESS_BUFFER_SIZE dup(0)     


; Searches for the index with the inputed adres
; input -> rsi
; output -> rbx (index)
; dl 1 when found 0 when not found
get_adress_index:
    push rdi
    mov rbx, 0 ; counter

    .search_loop:
        mov rdi, rbx
        call read_text_adress

        cmp rdx, rsi
        je .found

        cmp rbx, [adress_table_size]
        je .not_found

        inc rbx
        jmp .search_loop

    .found:
        pop rdi
        mov dl, 1
        ret

    .not_found:
        pop rdi

        ; Error codes
        mov esi, rt_not_found
        call print_string
        mov dl, 0
        ret

; Reads text until the count from the table goes to 0
; changes the value of the rbx register
; rbx -> index of the adres
read_text_table:
    cmp dl, 0
    je .exit

    push rdi
    push rcx
    push rdx
    
    mov rdi, rbx

    call read_text_adress
    mov rdi, rdx

    inc rbx

    push rdi
    mov rdi, rbx
    call read_text_adress
    mov rbx, rdx
    pop rdi

    mov ecx, 0

    .wt_loop_read:
        cmp rcx, rbx
        jge .read_done
        mov al, byte [edi]
        call print_char
        inc rdi
        inc rcx
        jmp .wt_loop_read

    .read_done:

    pop rdx
    pop rcx
    pop rdi

    .exit:
    ret


; rdi -> input index
; rdx -> output
read_text_adress:
    mov rdx, rdi         
    imul rdx, rdx, 8    
    lea rdx, [adress_table + rdx] 
    mov rdx, [rdx]     
    ret

; rsi input -> value
; rdx output
add_text_adress:
    mov rdx, [adress_table_size]      
    imul rdx, rdx, 8    
    lea rdx, [adress_table + rdx] 
    mov qword [rdx], rsi 
    inc qword [adress_table_size]
    ret
