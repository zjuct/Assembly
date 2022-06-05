;功能:在屏幕的5行12列显示三个红底高亮闪烁绿色的'a'

assume cs:code
code segment
start:
	mov ah,2	;执行2号子程序，设置光标
	mov bh,0
	mov dh,5
	mov dl,12
	int 10H
	
	mov ah,9	;执行9号子程序，显示字符
	mov al,'a'
	mov bl,11001010B
	mov bh,0
	mov cx,3
	int 10H
	
	mov ax,4c00H
	int 21H

code ends
end start
