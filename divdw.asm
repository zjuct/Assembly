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

divdw:	push ax		;�Ƚ���λ��������
	mov ax,dx	;����λ�ͳ�����16λ����
	mov dx,0
	div cx
	mov bx,ax	;����õ����̣�������󸳸�dx
	pop ax	
	div cx		;��ʱdx��Ϊrem(H/N)   ��Ϊ*65536,ax��ΪL,������cx��16λ�������õ��̵ĵ�λ������
	mov cx,dx
	mov dx,bx	;���̵ĸ�λ����dx
	mov bx,0
	ret
	

code ends
end start
