.model small ;один сегмент кода, данных и стека
.stack 100h ;отвести под стек 256 байт

.data ;начало сегмента данных
mas dw 62000,10004,20000,30000 ;массив двухбайтовых чисел
n equ 4 ;количество элементов массива

.code ;раздел кода
;Начальная инициализация
start:

mov ax,@data
mov ds,ax ;настройка DS на начало сегмента данных
xor dx,dx

; код программы
mov cx,n ;счетчик цикла
mov si,0 ;начальное значение индекса
mov ax,0 ;начальное значение суммы
;add ax,[bx]
;adc dx,bx
;add si, 2 ;
L:
add ax,mas[si] ;ax:=ax+mas[i]
jc lol
add si, 2 ;следующий индекс
LOOP L ;повторять L n раз
jmp mm
lol:
add dx,1
add si, 2 ;следующий индекс
LOOP L ;повторять L n раз

mm:

xor bx,bx
mov bx, n ;заносим в bl делитель
div bx ;делим ax на bl

;вывод результата (ax) на экран

call Outproc

mov ax,4C00h
int 21h

Outproc proc

xor cx,cx ;обнуляем регистр cx (количество цифр будем держать в сx)
mov bx,10 ;система счисления

vivod:
xor dx,dx
div bx ;число поделили на систему счисления
push dx
inc cx
test ax,ax
jnz vivod
mov ah,02h

vivodvkons:
pop dx
add dl, 30h
int 21h
loop vivodvkons
ret
endp

end start
