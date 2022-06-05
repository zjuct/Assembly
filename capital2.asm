;将一个以0结尾的字符串转为大写
;与前面那个capital的区别在于，本题字符串的长度未知，只知道以0结尾
;使用jcxz来判断一个值是否为0
;由于cx被jcxz占用了，因此需要使用jmp代替前面的loop

assume cs:code
data segment
	db 'conversation',0
data ends

code segment
start:	mov ax,data
	mov ds,ax
	mov si,0 
	call capital
	mov cx,0
	mov ax,4c00H
	int 21H

capital:mov cl,[si]
	mov ch,0
	jcxz ok
	and byte ptr [si],11011111B
	inc si
	jmp short capital
ok:	ret

code ends
end start
