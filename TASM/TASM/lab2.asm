.model small
.stack 100h
.data
message db 'hello world$'
.code
start:
mov ax,@data
mov ds,ax
mov ah,9
mov dx,OFFSET message
int 21h
mov ax,4C00h
int 21h
end start
