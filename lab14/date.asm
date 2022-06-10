assume cs:code
code segment
start:
	mov al,9
	out 70h,al
	in al,71h
	
	mov ah,al	;将十位移入ah
	mov cl,4
	shr ah,cl
	and al,00001111B
	
	add ah,30h
	add al,30h

	mov si,0
	
	mov bx,0b800h
	mov es,bx
	mov byte ptr es:[160*12+40*2+si],ah
	inc si
	mov byte ptr es:[160*12+40*2+si],2
	inc si
	mov byte ptr es:[160*12+40*2+si],al
	inc si
	mov byte ptr es:[160*12+40*2+si],2
	inc si

	mov byte ptr es:[160*12+40*4+si],'/'
	inc si
	mov byte ptr es:[160*12+40*4],2	
	inc si

	mov al,8
	out 70h,al
	in al,71h
	
	mov ah,al	;将十位移入ah
	mov cl,4
	shr ah,cl
	and al,00001111B
	
	add ah,30h
	add al,30h
	
	mov byte ptr es:[160*12+40*2+si],ah
	inc si
	mov byte ptr es:[160*12+40*2+si],2
	inc si
	mov byte ptr es:[160*12+40*2+si],al
	inc si
	mov byte ptr es:[160*12+40*2+si],2
	inc si

	mov byte ptr es:[160*12+40*4+si],'/'
	inc si
	mov byte ptr es:[160*12+40*4],2	
	inc si

	mov al,7
	out 70h,al
	in al,71h
	
	mov ah,al	;将十位移入ah
	mov cl,4
	shr ah,cl
	and al,00001111B
	
	add ah,30h
	add al,30h
	
	mov byte ptr es:[160*12+40*2+si],ah
	inc si
	mov byte ptr es:[160*12+40*2+si],2
	inc si
	mov byte ptr es:[160*12+40*2+si],al
	inc si
	mov byte ptr es:[160*12+40*2+si],2
	inc si

	mov byte ptr es:[160*12+40*4+si],'/'
	inc si
	mov byte ptr es:[160*12+40*4],2	
	inc si

	mov byte ptr es:[160*12+40*4+si],' '
	inc si
	mov byte ptr es:[160*12+40*4],2	
	inc si

	mov al,4
	out 70h,al
	in al,71h
	
	mov ah,al	;将十位移入ah
	mov cl,4
	shr ah,cl
	and al,00001111B
	
	add ah,30h
	add al,30h
	
	mov byte ptr es:[160*12+40*2+si],ah
	inc si
	mov byte ptr es:[160*12+40*2+si],2
	inc si
	mov byte ptr es:[160*12+40*2+si],al
	inc si
	mov byte ptr es:[160*12+40*2+si],2
	inc si

	mov byte ptr es:[160*12+40*4+si],':'
	inc si
	mov byte ptr es:[160*12+40*4],2	
	inc si

	mov al,2
	out 70h,al
	in al,71h
	
	mov ah,al	;将十位移入ah
	mov cl,4
	shr ah,cl
	and al,00001111B
	
	add ah,30h
	add al,30h
	
	mov byte ptr es:[160*12+40*2+si],ah
	inc si
	mov byte ptr es:[160*12+40*2+si],2
	inc si
	mov byte ptr es:[160*12+40*2+si],al
	inc si
	mov byte ptr es:[160*12+40*2+si],2
	inc si

	mov byte ptr es:[160*12+40*4+si],':'
	inc si
	mov byte ptr es:[160*12+40*4],2	
	inc si

	mov al,0
	out 70h,al
	in al,71h
	
	mov ah,al	;将十位移入ah
	mov cl,4
	shr ah,cl
	and al,00001111B
	
	add ah,30h
	add al,30h
	
	mov byte ptr es:[160*12+40*2+si],ah
	inc si
	mov byte ptr es:[160*12+40*2+si],2
	inc si
	mov byte ptr es:[160*12+40*2+si],al
	inc si
	mov byte ptr es:[160*12+40*2+si],2
	inc si

	mov ax,4c00H
	int 21H
code ends
end start
