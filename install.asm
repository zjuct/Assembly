;jmp near ptr 的安装程序
assume cs:code,ss:stack

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
	mov si,offset jmp_near_ptr
	
	mov ax,0
	mov es,ax
	mov di,200H

	mov cx,offset jmp_near_ptr_end - offset jmp_near_ptr
	cld 
	rep movsb

	mov ax,0	
	mov ds,ax
	mov word ptr ds:[7cH*4],200H
	mov word ptr ds:[7ch*4+2],0
	
	mov ax,4c00H
	int 21H
jmp_near_ptr:
	;bx存放转移位移
	push bp		;先保存bp
	mov bp,sp

	add ss:[bp+2],bx	

ok:	pop bp
	iret
	
jmp_near_ptr_end:
	nop

code ends
end start
