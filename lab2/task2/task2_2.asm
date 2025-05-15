org 0x7c00

data db '2','3','3','3','6','0','4','0'
len equ 8

mov dh, 8
mov dl, 8
mov ah, 0x02
int 0x10

mov si, data
mov cx, len

output:
    lodsb
    mov ah, 0x09
    mov bl, 0x04
    mov bh, 0
    mov cx, 1
    int 0x10
    
    inc dl
    mov ah, 0x02
    int 0x10
    
    loop output

times 510 - ($ - $$) db 0
    db 0x55, 0xaa
