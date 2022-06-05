;显示字符串
;参数 dh行号 dl列号  cl颜色  ds:si指向字符串首地址
assume cs:code

stack segment
	dw 8 dup (0)
stack ends

code segment
start:	
	mov ax,stack
	mov ss,ax
	mov sp,16

	mov ax,cs
	mov ds,ax
	mov si,offset display
	
	mov ax,0
	mov es,ax
	mov di,200H
	mov cx,offset displayend - offset display
	cld
	rep movsb
	
	mov ax,0
	mov ds,ax
	mov word ptr ds:[7ch*4],200H
	mov word ptr ds:[7ch*4+2],0
	
	mov ax,4c00H
	int 21H 

display:
	push ax
	push bx
	push cx
	push si
	push di

	mov ax,0b800H
	mov bl,cl	;保存颜色值
	mov es,ax
	mov ax,160
	mul dh
	add dl,dl
	add al,dl
	mov di,ax
	
s:	mov cl,ds:[si]
	mov ch,0
	jcxz ok
	mov es:[di],cl
	mov es:[di+1],bl
	inc si
	add di,2
	jmp short s
ok:	pop di
	pop si
	pop cx
	pop bx
	pop ax
	
	iret
	
displayend:
	nop
code ends
end start

