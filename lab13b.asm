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
	mov si,offset myloop
	mov ax,0
	mov es,ax
	mov di,7ch
	
	mov cx,offset myloopend - offset myloop
	cld
	movsb
	
	mov ax,0	
	mov es,ax
	mov es:[7ch*4],200H
	mov es:[7ch*4+2],0
	
	mov ax,4c00H
	int 21H

myloop:
;参数 cx：循环次数  bx:位移
	push bp
	mov bp,sp
	dec cx
	cmp cx,0
	je ok
	add ss:[bp+2],bx
	
ok:	pop bp
	iret
myloopend:
	nop
code ends
end start
