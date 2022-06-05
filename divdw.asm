assume cs:code,ss:stack
stack segment
	dw 8 dup (0)
stack ends

code segment

start:	mov ax,stack
	mov ss,ax
	mov sp,16
	mov ax,4240H
	mov dx,000FH
	mov cx,0AH
	call divdw
	
	mov ax,4c00H
	int 21H

divdw:	push ax		;先将低位保存起来
	mov ax,dx	;将高位和除数做16位除法
	mov dx,0
	div cx
	mov bx,ax	;保存得到的商，用于最后赋给dx
	pop ax	
	div cx		;此时dx中为rem(H/N)   即为*65536,ax中为L,将其与cx做16位除数，得到商的低位和余数
	mov cx,dx
	mov dx,bx	;将商的高位赋给dx
	mov bx,0
	ret
	

code ends
end start
