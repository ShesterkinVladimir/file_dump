;��������� �.�. A-08-17
;������������ ������ �4 ������� 4 (22)
;������� ��� ������� �� ������, Pascal-string

.model small ; ��� �������� ���� �������, ������ � ���� ���������� � ���� ������ � ������ DGROUP
.stack 100h
.data
stroka db 18,'1 2 3  7     5   g' ;
.code
start:
    mov ax, @data ; � �������� AX �������� ��� ������
    mov ds, ax   ; ���������� ������� DS ������ AX �� ��� ������ ��� ��������.
	
    mov es, ax	
	
   ; lodsb ;������� ���� �� ������ DS:SI � AL
    ;mov cl, al ; � cl(�������) �������� al(��� ��������� ������ ���� ����� ������ - ������� ������ ) 
    ;jcxz cx0 ;������a JCXZ ��������� �������� �������� CX �, ���� ��� ����� ����, 
	         ;������������ �������� ���������� �� ������, ��������� ��������� �������.
	
	; ������� ����, ��� �� ����� ����� ����, ������ � ���� ��� ����� ��� ���� ����� �������, ���� ��� ��� ����� �������
			 
	lea DI,stroka
	mov cl,[ES:DI]
	jcxz cx0
	
	add di,1
	mov al, ' '
poisk:
	REPE scasb 

print:
	sub di,1
	mov al,[ES:DI]
	int 29h
	add di,1     	
	mov al, ' '

	
	jcxz cx0


jmp poisk


cx0:
    mov ax, 4C00h 
    int 21h ;��������� ����������

end start