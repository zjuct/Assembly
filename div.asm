assume cs:code,ds:data
data segment
	dd 100001
	dw 100
	dw 0
data ends

code segment
start:	mov ax,data
	mov ds,ax
	mov ax,[0]
	mov dx,[2]
	div word ptr [4]
	mov [6],ax

	mov ax,4c00H
	int 21H

code ends
end start
