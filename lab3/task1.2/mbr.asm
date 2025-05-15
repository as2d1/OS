;org 0x7c00
[bits 16]
xor ax, ax ; eax = 0
; 初始化段寄存器, 段地址全部设为0
mov ds, ax
mov ss, ax
mov es, ax
mov fs, ax
mov gs, ax

; 初始化栈指针
mov sp, 0x7c00
mov ax, 1                ; 逻辑扇区号第0~15位
mov cx, 0                ; 逻辑扇区号第16~31位
mov bx, 0x7e00           ; bootloader的加载地址
load_bootloader:
    call asm_read_hard_disk  ; 读取硬盘
    add bx,512
    inc ax
    cmp ax, 5
    jle load_bootloader
jmp 0x0000:0x7e00        ; 跳转到bootloader

jmp $ ; 死循环

asm_read_hard_disk:                           
; 从硬盘读取一个逻辑扇区，使用CHS模式和BIOS中断13h

; 参数列表
; ax=逻辑扇区号0~15位
; cx=逻辑扇区号16~28位 (在当前实现中假设为0)
; ds:bx=读取出的数据放入地址

; 返回值
; bx=bx+512

    push dx
    push cx
    push ax

; LBA到CHS的转换
; 扇区号 = (LBA % 63) + 1
; 磁头号 = (LBA / 63) % 18
; 柱面号 = (LBA / 63) / 18

    ; AH = 02H 功能参数，读取扇区
    ; AL = 扇区数
    ; CH = 柱面
    ; CL = 扇区
    ; DH = 磁头
    ; DL = 驱动器号
    ; ES:BX = 缓冲区的地址

    ; 先计算 (LBA / 63)
    xor dx, dx ; 清零DX
    mov cx, 63
    div cx ; AX = LBA / 63, DX = LBA % 63

    ; 保存中间结果
    push bx
    mov bx, ax ; BX = LBA / 63

    ; 处理扇区号 S = (LBA % 63) + 1
    inc dx ; S = DX + 1
    mov cl, dl ; CL = 扇区号

    ; 计算柱面号和磁头号
    mov ax, bx ; 恢复 AX = LBA / 63
    xor dx, dx ; 清零DX
    push cx
    xor cx, cx
    mov cx, 18  
    div cx ; AX = 柱面号, DX = 磁头号
    pop  cx
    mov ch, al ; 柱面号放入CH
    mov dh, dl ; 磁头号放入DH

    ; INT 13h 读取磁盘扇区的预设参数
    mov dl, 80h ; 驱动器号 - 硬盘
    mov ah, 2h ; 功能号 - 读扇区

    ; 设置读取扇区数
    mov al, 1 ; 读取一个扇区
    pop bx
    ; 执行磁盘读取中断
    int 13h

    pop ax
    pop cx
    pop dx
    ret

times 510 - ($ - $$) db 0
db 0x55, 0xaa