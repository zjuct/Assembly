assume cs:code
stack segment
	db 128 dup (0)
stack ends

code segment
start:
	mov ax,stack
	mov ss,ax
	mov sp,128

	push cs
	pop ds
	
	mov ax,0
	mov es,ax
	mov si,offset int9start
	mov di,200H
	mov cx,offset int9end - offset int9start
	cld
	rep movsb

	mov word ptr es:[7ch*4],20AH
	mov word ptr es:[7ch*4+2],0

	mov ax,4c00H
	int 21H

int9start:	
	jmp short int9	;��ת��int9����ʼλ��
			;jmp shortָ��ռ�����ֽ�

	;table dw sub1,sub2,sub3,sub4	��������д����Ϊsub1������Ա���װ�����ƫ����
	table dw 200H+offset sub1-offset int9start,200H+offset sub2-offset int9start,200H+offset sub3-offset int9start,200H+offset sub4-offset int9start
	
int9:
	push bx
	
	cmp ah,3
	ja int9ret
	mov bl,ah
	mov bh,0
	add bx,bx
	
	mov ax,0
	mov ds,ax
	
	mov ax,ds:[202H+bx]	;���ﲻ��д��table[bx],��Ϊtable��ֵ�ڱ���ʱȷ������Ϊ��װ�����е�ƫ����
	call ax	

int9ret:
	pop bx
	iret

;-------------------�ӳ�����-----------------------
;�ӳ���1������
sub1:	push bx
	push cx
	push es
	mov bx,0b800H
	mov es,bx
	mov bx,0
	mov cx,2000
sub1s:	mov byte ptr es:[bx],' '
	add bx,2
	loop sub1s
	pop es
	pop cx
	pop bx	
	ret

;�ӳ���2������ǰ��ɫ
sub2:	push bx
	push cx
	push es	

	mov bx,0b800H
	mov es,bx
	mov bx,1
	mov cx,2000

sub2s:	and byte ptr es:[bx],11111000B
	or es:[bx],al
	add bx,2
	loop sub2s
	pop es
	pop cx
	pop bx
	ret

;�ӳ���3�����ñ���ɫ
sub3:	push bx
	push cx
	push es
	mov cl,4
	shl al,cl
	mov bx,0b800H
	mov es,bx
	mov bx,1
	mov cx,2000
sub3s:
	and byte ptr es:[bx],10001111B
	or es:[bx],al
	add bx,2
	loop sub3s
	pop es
	pop cx
	pop bx
	ret

;�ӳ���4�����Ϲ���һ��
sub4:
	push cx
	push si
	push di
	push es
	push ds
	mov si,0b800H
	mov es,si
	mov ds,si
	mov si,160
	mov di,0
	cld
	mov cx,24
sub4s:	push cx
	mov cx,160
	rep movsb
	pop cx
	loop sub4s

	mov cx,80
	mov si,0	;���һ����Ϊ��
sub4s1:	mov byte ptr [160*24+si],' '
	add si,2
	loop sub4s1

	pop ds
	pop es
	pop di
	pop si
	pop cx
	ret
int9end:nop	

code ends
end start
