;��һ����0��β���ַ���תΪ��д
;��ǰ���Ǹ�capital���������ڣ������ַ����ĳ���δ֪��ֻ֪����0��β
;ʹ��jcxz���ж�һ��ֵ�Ƿ�Ϊ0
;����cx��jcxzռ���ˣ������Ҫʹ��jmp����ǰ���loop

assume cs:code
data segment
	db 'conversation',0
data ends

code segment
start:	mov ax,data
	mov ds,ax
	mov si,0 
	call capital
	mov cx,0
	mov ax,4c00H
	int 21H

capital:mov cl,[si]
	mov ch,0
	jcxz ok
	and byte ptr [si],11011111B
	inc si
	jmp short capital
ok:	ret

code ends
end start
