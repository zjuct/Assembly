assume cs:code
code segment
start:
	mov ah,2
	mov al,0
	mov dh,5
	mov dl,12
	int 10H
code ends
end start
