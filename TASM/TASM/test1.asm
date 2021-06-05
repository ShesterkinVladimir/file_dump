.model small
.stack 100h
.data
nomer_stroki_dec dw 0h					;младая часть номера строки 
dop_nomer_stroki_dec dw	0h			;старшая часть номера строки 
nomer_stroki dw 9000h					;младая часть номера строки 
 dop_nomer_stroki dw 35h				;старшая часть номера строки 
 .code
 
 begin:
	mov ax,@data ; настроим DS
    mov DS,ax       ; на реальный сегмент
	
xor dx,dx
	
	mov ax,dop_nomer_stroki
	mov cx,6
	mul cx
	mov dop_nomer_stroki_dec,ax
	
	mov ax,dop_nomer_stroki
	mov cx,5536
	mul cx
	mov cx,nomer_stroki
	add cx,ax
	adc dx,0
	
	mov nomer_stroki_dec,cx
	mov ax,dop_nomer_stroki_dec
	
	mov si,dx
si_ne_0:
	xor dx,dx
	cmp si,0
	jz bolshe9999
	
	sub si,1
	add ax,6
	add cx,5536
	adc dx,0
	
	add si,dx
	
  jmp si_ne_0
	
bolshe9999:
	cmp cx,9999
	JBE good 
	
	sub cx,10000
	add ax,1
jmp bolshe9999
good:	

		
xor ax,ax
    mov ah,4ch
    int 21h

 end begin