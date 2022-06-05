assume cs:code,ss:stack
data segment
	db 'word',0
	db 'unix',0
	db 'wind',0
	db 'good',0

data ends

stack segment
	dw 8 dup (0)
stack ends

code segment
start:	mov ax,data
	mov ds,ax
	mov cx,4
	mov si,0
	mov ax,stack
	mov ss,ax
	mov sp,16
s:	push cx
	call capital
	pop cx
	inc si	

	loop s
	
	mov ax,4c00H
	int 21H

capital:mov cl,[si]
	mov ch,0
	jcxz ok
	and byte ptr [si],11011111B
	inc si	
	jmp short capital

ok:	ret

code ends
end start
