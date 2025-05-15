
; If you meet compile error, try 'sudo apt install gcc-multilib g++-multilib' first

%include "head.include"   ;链接head.include中代码，head.include中是a1等变量的声明
; you code here

your_if:
; put your implementation here
    mov eax,[a1]	;a1中存放的是外部变量的地址
    mov ebx,[a1]
    cmp eax,12
    jl tag1
    cmp eax,24
    jl tag2
    shl ebx,4
    jmp your_if_end
    tag2:
        sub ebx,24
        neg ebx
        imul ebx,eax
        jmp your_if_end
    tag1:
        shr ebx,1
        add ebx,1
        jmp your_if_end
your_if_end:
mov [if_flag],ebx
your_while:
    mov ecx,[a2]
    loop1:
        cmp ecx,12
        jl your_while_end
        push ecx
        call my_random
        pop ecx
        mov ebx,[a2]
        sub ebx,12
        imul ebx,1 ;计算偏移量。阅读test.cpp可知while_flag是char类型字符串，单字节。
        mov edx,[while_flag]
        add edx,ebx
        mov [edx],eax
        sub ecx,1
        jmp loop1
your_while_end:
mov [a2],ecx ;通过阅读判定程序，可以发现要想通过测试，需要将a2置于12以下
; put your implementation here
%include "end.include"
your_function:
; put your implementation here
mov eax,[your_string]
mov ecx,0
loop2:

    mov ebx,[eax]
    and ebx,0x00FF ;非常坑。由于ebx是32位，在强制类型转换char->int时高位是无法确定的。在判定是否为'\0'时需要先将高位清零
    cmp ebx,0      ;判定结尾字符是否为'\0'
    je end1
    pushad
    push ebx
    call print_a_char ;C与nasm混编时，C编译器会取栈顶端的数据作为形参，同时会将返回值存放在寄存器(e)ax中。
    pop ebx
    popad
    add eax,1
    add ecx,1
    jmp loop2
end1:
