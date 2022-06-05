assume cs:code,ss:stack
stack segment
	dw 8 dup (0)
stack ends

code segment

start:
	mov ax,cs
	mov ds,ax
	mov si,offset do0
	
	mov ax,0
	mov es,ax
	mov di,200H
	
	mov cx,offset do0end - offset do0
	cld
	
	rep movsb

	mov ax,0
	mov ds,ax
	mov word ptr ds:[0],200H
	mov word ptr ds:[2],0

	mov ax,4c00H
	int 21H

do0:
	jmp short do0start
	db "divide error!"
	
do0start:
	mov ax,cs
	mov ds,ax
	mov si,202H
		
	mov ax,0B800H
	mov es,ax
	mov di,160*12+36*2
	
	mov cx,13
s:	mov al,ds:[si]
	mov es:[di],al
	mov byte ptr es:[di+1],2
	inc si
	add di,2
	loop s
	
	mov ax,4c00H
	int 21H
do0end:
	nop
	
code ends
end start
