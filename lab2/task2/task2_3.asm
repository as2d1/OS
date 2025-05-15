org 0x7c00

buffer times 50 db 0
mov si, buffer
mov cx, 0

input_loop:
    mov ah, 0
    int 0x16  
    cmp al, 0x0d
    je display
    
    mov ah, 0x09
    mov bl, 0x03
    mov cx, 1
    int 0x10  
    
    mov [si], al  
    inc si
    inc cx
    
    mov ah, 0x03
    int 0x10
    inc dl
    mov ah, 0x02
    int 0x10
    
    jmp input_loop

display:
    mov si, buffer
    mov dl, 0
    mov ah, 0x03
    int 0x10
    inc dh
    mov ah, 0x02
    int 0x10

output_loop:
    mov al, [si]
    cmp al, 0
    je end
    
    mov ah, 0x09
    mov bl, 0x04
    mov cx, 1
    int 0x10
    
    inc si
    inc dl
    mov ah, 0x02
    int 0x10
    jmp output_loop

debug:
    mov ah, 0x09
    mov bl, 0x05
    mov cx, 1
    mov al, 'D'
    int 0x10
    ret

end:
    times 510 - ($ - $$) db 0
    db 0x55, 0xaa