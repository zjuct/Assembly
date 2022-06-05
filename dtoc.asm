assume cs:code
data segment
	db 10 dup (0)
data ends

stack segment
	dw 8 dup (0)
stack ends

code segment
start:	mov ax,stack
	mov ss,ax
	mov sp,16
	mov ax,12666
	mov bx,data
	mov ds,bx
	mov si,0
	call dtoc
	
	mov si,0
	call reverse   ;将字符串反转

	mov dh,8
	mov dl,3
	mov cl,2
	mov si,0
	call show_str
	mov ax,4c00H
	int 21H

dtoc:	mov bx,10	;注意8位除法越界了
	mov dx,0	
	div bx		;余数在dx中
	mov cx,ax
	add dx,30H
	mov [si],dl
	inc si
	jcxz ok
	jmp short dtoc	
ok:	ret	

reverse:mov cl,[si]
	mov ch,0
	jcxz ok2
	push cx	;push操作的是字单元
	inc si
	jmp short reverse	

ok2:	mov cx,si
	mov si,0
s:	pop bx
	mov [si],bl
	inc si
	
	loop s
	ret


show_str:
	mov ax,0B800H
	mov es,ax
	mov ah,0
	mov al,160
	mul dh
	mov bx,ax
	mov al,dl
	mov ah,0
	add ax,ax
	add bx,ax
	mov ah,cl
	mov al,0

display:
	mov ch,0
	mov cl,[si]
	jcxz ok1
	mov al,[si]
	inc si
	mov es:[bx],ax
	add bx,2
	jmp short display

ok1:	ret

code ends
end start
