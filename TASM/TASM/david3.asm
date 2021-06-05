;Белова И.М. гр. А-07-17
;Лабораторная работа №3 "Определение и обработка данных "
;Вариант: № 3 Задан массив целых чисел со знаком.
;Рассчитать среднее значение элементов массива.
.model small
.stack 100h
.data

massiv db 60,60;,-90,125,71 ;массив
N equ 2 ;количество элементов в массиве
tmp_sr dw ? ;переменная (зарезервированная) под среднее значение элементов в массиве
tmp_sum dw ? ;переменная (зарезервированная) под сумму всех элементов в массиве

table1 db '0123456789ABCDEF'
string1 db 'h $' ; символ-разделитель при выводе на экран чисел
string2 db 'Massiv: $ 0Ah'
string3 db 'Summa elementov massiva: $ 0Ah'
string4 db 'Resultati. Srednee = $ '

.code

start: ;точка входа
mov ax,@data
mov ds,ax
mov tmp_sum, 0 ;начальная инициализация
mov tmp_sr, 0
mov cx,N ;для организации цикла из N шагов
mov di,offset massiv ;положили в регистр di указатель на первый элемент массива
;mov ah,09h ;вывод строки на экран
;mov dx,offset string2 ;желаемую строку положили в регистр dx
;int 21h ;вызвали желаемое прерывание

main_l:

mov al,[di] ; взяли текущий элемент массива
mov ah,0
cbw
mov bx,tmp_sum ; взяли значение переменной tmp_sum и положили ее в регистр bx
add bx, ax ; сложили два числа
mov tmp_sum,bx ; результат положили опять в переменную tmp_sum
inc di ; перешли на другой элемент в массиве
loop main_l ; зациклились

mov ah,02h ;перевод строки
mov dl,0Ah ;
int 21h

mov ah,09h ;вывод строки на экран
mov dx,offset string3 ;желаемую строку положили в регистр dx
int 21h ;вызвали желаемое прерывание
mov ax,tmp_sum
call Outproc

mov ax, tmp_sum
mov bl, N
idiv bl
cbw
mov tmp_sr, ax

mov ah,02h ;перевод строки
mov dl,0Ah ;
int 21h

mov ah,09h ;вывод строки на экран
mov dx,offset string4 ;желаемую строку положили в регистр dx
int 21h ;вызвали желаемое прерывание
mov ax,tmp_sr
call Outproc

exit: mov ax,4c00h ; выход в ДОС
int 21h ;


Outproc proc
; проверяем число на знак

test ax,ax
jns oi ;если оно положительное, то переходим на метку

mov cx,ax ;если отрицательное, то пишем минус и меняем знак у числа
mov ah, 02h
mov dl, '-'
int 21h
mov ax,cx
neg ax
oi:
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
add dl, '0'
int 21h
loop vivodvkons
ret
endp

end start