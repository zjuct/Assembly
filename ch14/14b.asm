assume cs:code
code segment
start:
	mov al,2
	out 70H,al
	mov al,0
	out 71H,al

code ends
end start
