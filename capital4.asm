assume cs:code,ss:stack
stack segment
	dw 8 dup (0)
stack ends

data segment
	db 'conversation',0
data ends

code segment
start:
	mov ax,stack
	mov ss,ax
	mov sp,16
	
	mov ax,cs
	mov ds,ax
	mov si,offset capital
	
	mov ax,0
	mov es,ax
	mov di,200H
	
	mov cx,offset capitalend - offset capital
	cld

	rep movsb

	mov ax,0
	mov ds,ax
	mov word ptr ds:[7cH*4],200H
	mov word ptr ds:[7cH*4+2],0

	mov ax,data
	mov ds,ax
	mov si,0
	
	int 7cH

	mov ax,4c00H
	int 21H	 

capital:
	push ax
	push cx
	push si

	;ds:si指向待转换字符串首地址
s:	mov al,ds:[si]
	mov ah,0
	mov cx,ax
	jcxz ok
	and al,11011111B
	mov ds:[si],al
	inc si
	jmp short s

ok:	pop si
	pop cx
	pop ax
	iret

capitalend:
	nop

code ends
end start
	
