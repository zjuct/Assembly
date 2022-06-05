assume cs:codesg,ss:stack

data segment
	db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
	db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
	db '1993','1994','1995'

	dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
	dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000

	dw 3,7,9,13,28,38,130,220,176,778,1001,1442,2258,2793,4037,5635,8226
	dw 11542,14430,15257,17800
data ends

table segment
	db 21 dup ('year summ ne ?? ')
table ends

stack segment
	dw 8 dup (0)
stack ends

codesg segment
start:	mov ax,data
	mov ds,ax
	mov ax,table
	mov es,ax
	mov ax,stack
	mov ss,ax
	mov sp,0
	mov cx,21
	mov bx,0
	mov bp,0
	mov di,0
s:	mov si,0
	push cx
	mov cx,4
s1:	mov al,ds:[bx+si]
	mov es:[bp+si],al
	inc si

	loop s1

	pop cx
	add bx,4
	add bp,16
	loop s

	mov cx,21
	mov bx,0
	mov bp,0
s2:	mov ax,ds:[84+bx]
	mov es:[5+bp],ax
	mov ax,ds:[86+bx]
	mov es:[7+bp],ax
	add bx,4
	add bp,16
	
	loop s2

	mov bp,0
	mov bx,0
	mov cx,21
s3:	mov ax,ds:[168+bx]
	mov es:[10+bp],ax
	add bx,2
	add bp,16
	
	loop s3
	
	mov bp,0
	mov cx,21
s4:	mov ax,es:[bp+5]
	mov dx,es:[bp+7]
	div word ptr es:[bp+10]
	mov es:[bp+13],ax
	add bp,16

	loop s4
	
	mov ax,4c00H
	int 21H
	
codesg ends
end start
