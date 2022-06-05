assume cs:code
code segment 
    mov bx,0H
    mov ax,0020H
    mov ds,ax;切记，不能直接将字面值mov到段寄存器中
    mov cx,3FH
    
s:  mov ds:[bx],bx
    inc bx

    loop s

    mov ax,4C00H
    int 21H

code ends
end