assume cs:code
a segment
	db 1,2,3,4,5,6,7,8
a ends

b segment
	db 1,2,3,4,5,6,7,8
b ends

c segment 
	db 0,0,0,0,0,0,0,0
c ends

code segment
start:	mov cx,8
	mov bx,0

s:	mov dx,a
	mov ds,dx
	mov al,ds:[bx]
	mov dx,b
	mov ds,dx
	add al,ds:[bx]
	mov dx,c
	mov ds,dx
	mov ds:[bx],al
	add bx,1
	
	loop s

	mov ax,4c00H
	int 21H
	
code ends
end start
