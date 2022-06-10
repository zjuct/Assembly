assume cs:code
code segment
start:
	mov ax,2
	out 70H,ax
	in ax,71H

code ends
end start
