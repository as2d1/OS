org 0x7c00

mov ah, 0x02
mov bh, 0
mov dh, 8
mov dl, 8

mov si, chars

print_loop:
    mov ah, 0x02
    int 0x10
    
    mov al, [si]
    cmp al, 0
    je done
    
    mov ah, 0x09
    mov bl, 0x03
    mov cx, 1
    int 0x10
    
    inc si
    inc dl
    jmp print_loop

done:
    times 510 - ($ - $$) db 0
    db 0x55, 0xaa

chars db '(', '8', ',', '8', ')', 0