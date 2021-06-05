.model small
.stack 100h
.data
 	freq dw 349,330,294,262,392,292,349,330,294,262,392,392,349,440,440,349,330,392,392,330,294,330,349,294,262,262
    ;1397,1319,1175,1047,1568,1568,1397,1319,1175,1047 ,1568,1568,1397,1760,1760,1397,1319,1568,1568,1319,1175,1319,1397,1175,1047,1047
    times db 1,1,1,1,2,2,1,1,1,1,2,2,1,1,1,1,1,1,1,1,1,1,1,1,2,2


.code
start:



	mov ax,@data 
	mov ds,ax
	
	xor ax,ax	;"обнуляем"
	xor bx,bx	;          регистры
	lea si,freq	;адрес начала массива частот
	lea bp,times	;             массива длительностей
	cld

	mov al,10110110b  ;управляющее слово для таймера
	out 43h,al   	  ;установка режима таймера
	
	mov cx,20	  ;установление счётчика

song:
	mov bl,byte ptr ds:[bp]    ;длительности из массива
	lodsw			   ;частоты из массива	
	inc bp
	call sound
	loop song	
	
	MOV AH, 4CH
	INT 21H 

sound proc
	push cx
	test ax,ax
	jz pause_func	;сравнение на паузу
	
	mov di,ax	;вычисление коэф-та частоты ноты
	mov dx,12h
	mov ax,2870h
	div di

	out 42h,al	;передача коэф-та	
	mov al,ah
	out 42h,al

	in al,61h	;включение динамика
	mov ah,al
	or al,3
	out 61h,al

pause_func:
	mov cx,bx
prog_pause:
	push cx
	mov cx,5h	;время ожидания(старшая часть(в мкс))
	mov dx,0A120h	;              (младшая часть)
	mov ah,86h	;Функция 86h позволяет определять время задержки в микросекундах
	int 15h
	pop cx
	loop prog_pause
	jz note

	mov al,ah	;выключение динамика
	out 61h,al
note:
	pop cx
ret
sound endp



end start	
