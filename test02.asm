assume cs:code
data segment
	db 'conversation',0
data ends

code segment 
start:	mov ax,data
	mov ds,ax
	mov si,0
	mov ax,0b800H
	mov es,ax
	mov di,12*160
	
s:	cmp byte ptr [si],0
	je ok
	mov al,[si]
	mov es:[di],al
	mov byte ptr es:[di+1],2
	inc si
	add di,2
	mov bx,offset s - offset ok
	int 7ch

ok:	mov ax,4c00H
	int 21H

code ends
end start
