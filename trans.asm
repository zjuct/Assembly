assume cs:codesg,ds:datasg

datasg segment

db 'Basic'
db 'HelloWorld'

datasg ends

codesg segment

start: mov ax,datasg
	mov ds,ax
	mov bx,0
	mov cx,5
s:	mov al,[bx]
	and al,11011111B
	mov [bx],al
	inc bx
	
	loop s
	
	mov bx,5
	mov cx,10
s1: 	mov al,[bx]
	or al,00100000B
	mov [bx],al
	inc bx
	loop s1
	
	mov ax,4c00H
	int 21H

codesg ends

end start
