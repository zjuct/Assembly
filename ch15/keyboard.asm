assume cs:code
stack segment
	db 128 dup (0)
stack ends

data segment
	dw 0,0
data ends

code segment
start:	mov ax,stack
	mov ss,ax
	mov sp,128

	mov ax,data
	mov ds,ax
	mov ax,0
	mov es,ax
	push es:[9*4]
	pop ds:[0]
	push es:[9*4+2]
	pop ds:[2]	;保存原先的9号中断例程地址

	cli

	mov word ptr es:[9*4],offset int9	;将中断向量表中的地址改为自定义的9号中断例程
	mov es:[9*4+2],cs			;如果在设置向量表时触发了键盘中断，CPU将跳转到一个错误的地址执行，因为向量表只设置了一半
						;正确的做法是将IF置为0，设置完成后再将IF置为1
	sti	

	mov ax,0b800H
	mov es,ax
	mov ah,'a'
s:	mov es:[160*12+40*2],ah
	call delay 
	inc ah
	cmp ah,'z'
	jna s

	mov ax,0	
	mov es,ax
	
	push ds:[0]
	pop es:[9*4]
	push ds:[2]
	pop es:[9*4+2]	;恢复原先的9号中断例程

	mov ax,4c00h
	int 21H
	
delay:	push ax
	push dx
	mov dx,10h
	mov ax,0
s1:	sub ax,1
	sbb dx,0	;ax原先为0,sub后变为FFFFH,且将CF标志位置为1
	cmp ax,0
	jne s1
	cmp dx,0	
	jne s1
	pop dx
	pop ax
	ret

;-------------------------------------------------------------
;自定义9号中断例程
int9:	
	push ax
	push bx
	push es
	
	in al,60h	;读取扫描码
	
	pushf 
	pushf 
	pop bx
	and bh,11111100B	;改变标志位
	push bx
	popf 
	call dword ptr ds:[0]	;调用原先的9号中断例程

	cmp al,1	;判断是否是esc
	jne int9ret
	
	mov ax,0b800H
	mov es,ax
	inc byte ptr es:[160*12+40*2+1]
	
int9ret:	
	pop es
	pop bx
	pop ax
	iret

code ends
end start
