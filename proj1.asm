assume cs:codesg,ss:stack,ds:data

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
	dw 16 dup (0)
stack ends

tmp segment
	db 16 dup (0)
tmp ends

codesg segment

main:	mov ax,stack
	mov ss,ax
	mov sp,32
	call load_data	

	mov cx,21
	mov bx,0
	mov dh,5
s7:	call show
	inc dh
	add bx,16
	
	loop s7

	mov ax,4c00H
	int 21H
show:	mov dl,3
	mov cl,2
	mov ax,tmp
	mov ds,ax

	mov cx,4
	mov di,0
	mov ax,table
	mov es,ax
s8:	mov al,es:[bx+di]
	mov ds:[di],al
	inc di
	loop s8

	mov si,0	;ds:si指向待显示字符串首地址
	call show_str

	push dx		;保存此时的显示位置
	 
	
	ret

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
	mov ah,2	;显示属性
	mov al,0

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



load_data:

	push ax
	push ds
	push es
	push cx
	push bx
	push di
	push bp
	push si


	mov ax,data
	mov ds,ax
	mov ax,table
	mov es,ax
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

	pop si
	pop bp
	pop di
	pop bx
	pop cx
	pop es
	pop ds
	pop ax
	
	ret

;divdw	ax为被除数低位，dx为被除数高位，cx为除数
;返回值	ax为商的低位，dx为商的高位，cx为余数
divdw:	push ax		;先将低位保存起来
	mov ax,dx	;将高位和除数做16位除法
	mov dx,0
	div cx
	mov bx,ax	;保存得到的商，用于最后赋给dx
	pop ax	
	div cx
	mov cx,dx
	mov dx,bx	;将商的高位赋给dx
	mov bx,0
	ret

dtoc:	

codesg ends

end main
