assume cs:code
data segment
	db 'Welcome to masm!',0
data ends

;(dh)Ϊ�кţ�(dl)Ϊ�к�,(cl)Ϊ��ɫ,ds:siָ���ַ����׵�ַ

code segment
start:	mov dh,8
	mov dl,3
	mov cl,2
	mov ax,data
	mov ds,ax
	mov si,0
	call show_str
	
	mov ax,4c00H
	int 21H

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
	;��ʱes:bxΪ����ʾλ��
	;al�д����ɫ
display:
	mov ch,0
	mov cl,[si]
	jcxz ok
	mov al,[si]
	inc si
	mov es:[bx],ax
	add bx,2
	jmp short display

ok:	ret

code ends
end start
