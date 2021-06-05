;Шестёркин Владимир
;А-08-17
;5(22)
;Лабораторная работа №6
;Директива "PROC": а) как часть заголовка;  б) как тип метки.
 
.model small
.stack 100h
.data
	kol dw 0 
	ind dw 4
    str1 	 DB 'Shesterkin Vladimir $'
	str2     DB 0Dh, 0Ah,'A-08-17 $'	
	newstroka DB 0Dh, 0Ah, '$'
	stroka   db 20,'1 2 3  7  20   5   g' ;
	
.code
;объявляем макросы:
exit_prog MACRO 			;выход из программы 
	mov ax,4c00h 			;выход в ДОС
	int 21h 
endm

instal_reg MACRO reg 				
	mov ax,@data			;Пересылаем адрес сегмента данных в регистр AX
	mov reg,ax				;Установка регистра reg на сегмент данных			
endm

start:						;точка входа
	instal_reg ds			;Установка регистра ds на сегмент данных		
	instal_reg es 			;Установка регистра es на сегмент данных	
	push offset  newstroka  ;Помещаем в стек строки для вывода
	push offset  str2
	push offset  str1               
	CALL PrintString 		;Вызываем процедуру вывода строк
	
	lea DI,stroka       	;первый символ строки - длинна строки 
	mov cl,[ES:DI]			;помещаем длинну в счетчик
	jcxz cx0				;если строка нулевой длинны, то переходим на метку
	add di,1				;переходим к 1 символу строки
	mov al, ' '				;будем сравнивать с пробелом 
	poisk:					;ищем символ - не пробел и помещаем в стек
	REPE scasb
	sub di,1
	push [ES:DI]
	add di,1 
	add kol,1               ;запоминаем сколько символов поместили в стек
	jcxz cx0				;ищем символы, пока не кончилась строка
	jmp poisk
	
cx0:	
	CALL proga4				;процедура вывода символов, которые заносили в стек
	
	exit_prog	;выход из программы
	
	
proga4 PROC NEAR
	mov cx,kol				;счетчик = число символов в стеке
	push bp					;запоминаем bp
    mov bp,sp				;bp = верхушка стека 
	xor ax,ax
	
	mov al,2				;4 строки ниже высчитывают, где в стеке находится 1 символ (bp = 2*cx+2)
	mul cx
	add ax,2
	add bp,ax
	
viv:
	mov al,[bp]				;помещаем символ из стека в регистр 
	sub bp,2				;переходим к следующему символу в стеке
	
	int 29h					;выводим символ 
  
loop viv	
  pop bp 					;восстанавливаем bp
ret 
proga4 endp
	
	
PrintString  label  PROC   ;процедура вывода 3 строк из программы 
	push bp
    mov bp,sp
	mov dx,[bp+4]
	call proc_09h_21h
	mov dx,[bp+6]
	call proc_09h_21h
	mov dx,[bp+8]
	call proc_09h_21h
	pop bp
ret 6					;удаляем 3 элемента в стеке и выходим из процедуры 
	
proc_09h_21h  label  PROC  ;процедура выхода из программы 
    mov ah,09h
	int 21h    
ret


end start

