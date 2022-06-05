assume cs:code
code segment

    mov ax,cs;CS标志代码段的段地址,注意如果这样写的话，ip初始应为0
    mov ds,ax
    mov ax,0020H
    mov es,ax
    mov bx,0
    mov cx,17;可以通过debug的u命令查看

    s:mov al,[bx]
    mov es:[bx],al
    inc bx

    loop s

    mov ax,4c00H
    int 21H

code ends

end