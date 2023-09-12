; Test the A20 Line
testA20:
    pusha
    mov ax, [0x7dfe]  ; 7dfe = 7c00+510 (memory location of magic number)
    mov dx, ax
    ; call printh
    push bx
    mov bx, 0xffff
    mov es, bx
    pop bx

    mov bx, 0x7e0e    

    mov dx, [es:bx]  
    ; call printh
    cmp ax, dx      
    je .cont         

    popa             
    mov ax, 1     
    ret             

.cont:
    mov ax, [0x7dff]
    mov dx, ax
    call printh

    push bx
    mov bx, 0xFFFF
    mov es, bx
    pop bx

    mov bx, 0x7E0F
    mov dx, [es:bx]
    ; call printh

    cmp ax, dx
    je .exit
    
    popa
    xor ax, 1
    ret
.exit:
    popa
    xor ax, ax
    ret