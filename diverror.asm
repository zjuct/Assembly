assume cs:code
code segment

start: 	
;----------------------------------------------
;do0 ��װ����
	mov ax,cs
	mov ds,ax
	mov si,offset do0	;ds:siָ���������
	
	mov ax,0
	mov es,ax
	mov di,200H		;es:diָ������ȥ
	
	mov cx,offset do0end - offset do0	;cx��ʾ�����С
	
	cld			;���ô��䷽��Ϊ��
	rep movsb		;ѭ��ִ��

;----------------------------------------------
;�����ж�����
	;���ж��������0������ָ��do0����λ��
	mov ax,0
	mov es,ax
	mov word ptr es:[0*4],200H
	mov word ptr es:[0*4+2],0
	
	mov ax,4c00H
	int 21H
	
do0:	jmp short do0start	;db���ǿ�ִ��ָ������Ҫjmp��do0start��
	db "overflow!"		;Ҫ��overflow���ڴ˴���ͬdo0����һͬ������0:0200��������������ǰһ��ʹ��data�οռ䣬��Ϊdata���ٵĶοռ��ڱ�����ִ����Ϻ�ᱻ����ϵͳ����	
	
do0start:	
	mov ax,cs
	mov ds,ax
	mov si,202H		;����ds:siָ���ַ���

	mov ax,0B800H
	mov es,ax
	mov di,12*160+36*2
	
	mov cx,9
s:	mov al,[si]		;��ʾ�ַ���
	mov es:[di],al
	inc si
	inc di
	mov byte ptr es:[di],2
	inc di
	loop s

	mov ax,4c00H
	int 21H

do0end:	nop			;��־do0�Ľ���
code ends
end start	
	
