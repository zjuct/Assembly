assume cs:codesg
datasg segment
	db "Beginner's All-purpose Symbolic Instruction Code.",0
datasg ends

codesg segment
begin:	mov ax,datasg
	mov ds,ax
	mov si,0
	call letterc
	
	mov ax,4c00H
	int 21H

letterc:
	push ax
	push bx
	push cx
	push dx
	
	mov si,0	;ds:si指向当前处理的字符
	mov cx,5
s:	push cx

s2:	mov al,ds:[si]
	mov ah,0

	mov cx,ax
	jcxz ok1
	sub cx,20H
	jcxz ok
	cmp al,61H
	jb s1
	cmp al,7AH
	ja s1
	
	sub al,20H
	mov ah,0
	mov ds:[si],al

s1:	inc si
	jmp short s2

ok:	pop cx
	inc si

	loop s
ok1:	

	pop dx
	pop cx
	pop bx
	pop ax
	ret
codesg ends
end begin
