;����:����Ļ��5��12����ʾ������׸�����˸��ɫ��'a'

assume cs:code
code segment
start:
	mov ah,2	;ִ��2���ӳ������ù��
	mov bh,0
	mov dh,5
	mov dl,12
	int 10H
	
	mov ah,9	;ִ��9���ӳ�����ʾ�ַ�
	mov al,'a'
	mov bl,11001010B
	mov bh,0
	mov cx,3
	int 10H
	
	mov ax,4c00H
	int 21H

code ends
end start
