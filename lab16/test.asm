assume cs:code
code segment
start:	mov ax,0
	int 7ch
	mov ax,4c00H
	int 21H
code ends
end start
