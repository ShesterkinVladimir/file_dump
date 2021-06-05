.model	tiny ; Модель памяти, используемая для COM
.code         
org	100h ; Начальное значение счетчика - 100h

begin:
   mov bx, offset mas
   mov cx, n ; переменная цикла - количество складываемых	
Summ:
   add ax,[bx] ; Прибавляем к ax содержимое bx
   add bx,2 
Loop Summ
   mov bh,n ; 
   cwd
   idiv bh
   ;xor bx,bx      
OutNumber:
  mov bx,10       ; Система счисления, в которой будем выводить число
  xor cx,cx       ; Количество цифр

  or al, al
  jns sig
  inc sign
  neg al
  xchg al, ah
  mov al, '-'
  int 29h
  xchg al, ah
sig:  

  xor ah, ah      ;!! там или остаток или минус
isDiv:
  xor dx,dx
  div bx          ; Получаем крайнюю справа цифру
 
  push dx         ; Запоминаем
  inc cx
  or ax,ax        ; Если получили не все цифры, продолжаем
  jnz isDiv
;
isOut:
  pop ax          ; Восстанавливаем цифру
  or ax,30h       ; Переводим её в символ
  int 29h         ; Выводим
  loop isOut

  int 20h        

mas dw -2,-3,-4,-5,-10
dlina dw $-mas   
sign  db 0      
n equ 5;
end	begin