.model small            ;один сегмент кода, данных и стека
.stack 100h     ;отвести под стек 256 байт
.data           ;начало сегмента данных
    mas dw 62000,10004  ;массив двухбайтовых чисел
    n equ 2         ;количество элементов массива  
    symb db '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'   
	
   .code ;раздел кода
    ;Начальная инициализация
	start:
    mov ax,@data
    mov ds,ax   ;настройка DS на начало сегмента данных
 
    ; код программы 
    mov cx,n    ;счетчик цикла
    mov si,0    ;начальное значение индекса
    mov ax,0    ;начальное значение суммы
 
    L: add ax,mas[si]   ;ax:=ax+mas[i]
	
	jc lol
    add si, 2       ;следующий индекс
    LOOP L          ;повторять L n раз
	jmp mm
	lol:
	add dx,1
	add si, 2       ;следующий индекс
    LOOP L          ;повторять L n раз
	
	mm:
 
    mov bx, n       ;заносим в bl делитель
    div bx          ;делим ax на bl
 
    ;вывод результата (ax) на экран
	
	;vivod:
	;division 10
	;mov bl,10
	;div bl ;al = ax / bl
	;jz met1
	;xor ah,ah
	;mov cx,0
	;push dx ;push ostatok
	;add cx,1
	;jmp met2
	;met1:
	;xor ah,ah
	;push dx ;push ostatok
	;add cx,1
	;jmp vivod
	
	;pop
	; met2:
    ;pop ax
   ;add ax, 30h
    
    mov cl,ah
	push ax
    mov ch,0
	mov bx, offset symb
	add bx, cx
	mov dl, [bx]
    mov ah, 02h
	int 21h
	pop ax
    mov cl,al
    mov ch,0
	mov bx, offset symb
	add bx, cx
	mov dl, [bx]
    mov ah,02h
       
    int 21h      
    

   ; loop met2
      
 
    ;завершение программы
   ; mov dl,0ffh
    ;    mov ah, 08h
       ; int 21h
    mov ax,4C00h
    int 21h 
end start 