; If you meet compile error, try 'sudo apt install gcc-multilib g++-multilib' first

%include "head.include"

your_if:
    mov eax, [a1]
    mov ebx, eax
    cmp eax, 12
    jl case1
    cmp eax, 24
    jl case2
    shl ebx, 4
    jmp if_done
case2:
    sub ebx, 24
    neg ebx
    imul ebx, eax
    jmp if_done
case1:
    shr ebx, 1
    inc ebx
if_done:
    mov [if_flag], ebx

your_while:
    mov ecx, [a2]
while_loop:
    cmp ecx, 12
    jl while_done
    push ecx
    call my_random
    pop ecx
    mov ebx, [a2]
    sub ebx, 12
    imul ebx, 1
    mov edx, [while_flag]
    add edx, ebx
    mov [edx], eax
    dec ecx
    jmp while_loop
while_done:
    mov [a2], ecx

%include "end.include"

your_function:
    mov esi, [your_string]
    xor ecx, ecx
func_loop:
    movzx eax, byte [esi]
    test eax, eax
    jz func_end
    push eax
    call print_a_char
    pop eax
    inc esi
    inc ecx
    jmp func_loop
func_end:
