org 0x7c00  
[bits 16]  
display dd '2','3','3','3','6','0','4','0'  ; 存放需要显示的字符  
count dd 8  ; 需要显示的字符的数量  
mov cx, 0  
mov bx, display ; 数组首地址  

mov ax, (0xb800) + 121  
mov gs, ax     ; 显示矩阵的首地址  
mov si, 8  
mov ax, 0  

loop:  
    mov ah, 0x53  
    mov al, [bx]  
    call display_char ; 调用显示字符的功能  
    add cx, 1  
    add bx, 4  
    cmp cx, [count]  
    jne loop  

display_char:  
    mov [gs:si], ax  
    add si, 2  
    ret  

end:  
times 510 - ($ - $$) db 0  
db 0x55, 0xaa  