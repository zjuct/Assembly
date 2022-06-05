assume cs:code
code segment

start: 	
;----------------------------------------------
;do0 安装程序
	mov ax,cs
	mov ds,ax
	mov si,offset do0	;ds:si指向从哪里来
	
	mov ax,0
	mov es,ax
	mov di,200H		;es:di指向到哪里去
	
	mov cx,offset do0end - offset do0	;cx表示传输大小
	
	cld			;设置传输方向为正
	rep movsb		;循环执行

;----------------------------------------------
;设置中断向量
	;将中断向量表的0号索引指向do0所在位置
	mov ax,0
	mov es,ax
	mov word ptr es:[0*4],200H
	mov word ptr es:[0*4+2],0
	
	mov ax,4c00H
	int 21H
	
do0:	jmp short do0start	;db不是可执行指令，因此需要jmp到do0start处
	db "overflow!"		;要将overflow放在此处，同do0程序一同拷贝到0:0200处，而不能像以前一样使用data段空间，因为data开辟的段空间在本程序执行完毕后会被操作系统回收	
	
do0start:	
	mov ax,cs
	mov ds,ax
	mov si,202H		;设置ds:si指向字符串

	mov ax,0B800H
	mov es,ax
	mov di,12*160+36*2
	
	mov cx,9
s:	mov al,[si]		;显示字符串
	mov es:[di],al
	inc si
	inc di
	mov byte ptr es:[di],2
	inc di
	loop s

	mov ax,4c00H
	int 21H

do0end:	nop			;标志do0的结束
code ends
end start	
	
