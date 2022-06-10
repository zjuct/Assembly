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
	pop ds:[2]	;����ԭ�ȵ�9���ж����̵�ַ

	cli

	mov word ptr es:[9*4],offset int9	;���ж��������еĵ�ַ��Ϊ�Զ����9���ж�����
	mov es:[9*4+2],cs			;���������������ʱ�����˼����жϣ�CPU����ת��һ������ĵ�ִַ�У���Ϊ������ֻ������һ��
						;��ȷ�������ǽ�IF��Ϊ0��������ɺ��ٽ�IF��Ϊ1
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
	pop es:[9*4+2]	;�ָ�ԭ�ȵ�9���ж�����

	mov ax,4c00h
	int 21H
	
delay:	push ax
	push dx
	mov dx,10h
	mov ax,0
s1:	sub ax,1
	sbb dx,0	;axԭ��Ϊ0,sub���ΪFFFFH,�ҽ�CF��־λ��Ϊ1
	cmp ax,0
	jne s1
	cmp dx,0	
	jne s1
	pop dx
	pop ax
	ret

;-------------------------------------------------------------
;�Զ���9���ж�����
int9:	
	push ax
	push bx
	push es
	
	in al,60h	;��ȡɨ����
	
	pushf 
	pushf 
	pop bx
	and bh,11111100B	;�ı��־λ
	push bx
	popf 
	call dword ptr ds:[0]	;����ԭ�ȵ�9���ж�����

	cmp al,1	;�ж��Ƿ���esc
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
