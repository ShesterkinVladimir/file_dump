.model small
.stack 1000h
.data
	Delay DW 3000; длительность звука (пример)
.code
	; 61h - адрес порта динамика
	; 42h - адрес порта таймера
	; включение динамика
	start:
	in al,61h	; получить состояние динамика
	push ax	; сохранить состояние динамика
	;mov ah, al; сохранение состояние содержимого порта
	or al, 00000011b ; установить два младших бита
	out 61h, al; установка управляющих сигналов (включить динамик)
	;------------------------------------------------------------
	;Вычисление высоты (частоты) звука
	;------------------------------------------------------------
	mov al, 10;
	out 42h, al; включить таймер, который
	;будет выдавать импульсы на динамик с заданной частотой
	mov cx, Delay; установить длительность звука
	; Цикл проигрывания
	Play:
		push cx;
		mov cx, Delay;
		Play_in:
			loop Play_in;
		pop cx;
		loop Play;
		pop ax;
		and al, 11111100b;
		out 61h, al; выключить динамик
		ret; return
		
		mov ah, 4Ch;
		int 21h;
	;proc sound
	
end start ; 