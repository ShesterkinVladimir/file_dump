.model small
.stack 100h
.data
buf db 20,0,20 dup(0)
.code
start:
mov ax,@data
mov ds,ax

mov ah, 0Ah
mov dx, offset(buf)
int 21h


mov ax, 4C00h
int 21h
end start