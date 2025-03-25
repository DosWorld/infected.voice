;      ▄▄                  █
;     ▀▀▀  Virus Magazine  █ Box 10, Kiev 148, Ukraine       IV  1996
;     ▀██ ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀ █ ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀ ▀ ▀▀▀▀▐▀▀▀  █▀▀▀▀▀▀█
;      ▐█ █▀▄ █▀▀ ▄▀▀ ▄▀▀ ▄█▄ ▄▀▀ █▀█    ▌ █ ▄▀█ █ ▄▀▀ █▄▄   █ █▀▀█ █ 
;       █ █ █ █▀  █▀  █    █  █▀  █ █    █ █ █ █ █ █   █     █ ▀▀▀█ █
;       █ ▐ ▐ ▐   ▐▄▄ ▐▄▄  ▐  ▐▄▄ ▐▄▀     ▀█ ▀▄█ ▐ ▐▄▄ ▐▄▄▄  █ █▄▄█ █
;       ▐ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄  █▄▄▄▄▄▄█
;       (C) Copyright, 1994-96, by STEALTH group WorldWide, unLtd.


        .MODEL  TINY

        .CODE
	extrn   modul: near
	public  f_con
        ORG     100H

;-----------------------------------------------------
;   Мне стыдно, но эта программа (именно программа,
;   а не MUTATION ENGINE!!!) содрана с демонстрации
;   PME (Burglar, Taiwan).  Приношу свои извинения
;   автору...
;   Для использования этой программы не нужно ничего
;   дополнительного. Откомпилируйте и запустите!!!
;
;				ETERNAL MAVERICK.
;-----------------------------------------------------

BEGIN:
        MOV     DX,OFFSET GEN_MSG
        MOV     AH,9
        INT     21H

        MOV     CX,10
GENFILE:
        PUSH    CX

        MOV     DX,OFFSET FILENAME
        PUSH    CS
        POP     DS
        XOR     CX,CX
        MOV     AH,3CH
        INT     21H

        PUSH    AX

        STR	  EQU OFFSET PROG
        VL	  EQU (OFFSET END_PROG - PROG + 1)/2
	F_CON     EQU OFFSET FileOff

	PUSH    CS
	POP     DS

        PUSH    SS
        POP     AX
        ADD     AX,1000h
        MOV     ES,AX			; es - сегмент буфера

	MOV	SI,OFFSET PROG		; si - смещение шифруемого кода

	MOV     CX,VL			; vl - длина этого кода /2
        CALL    MODUL

        POP     BX
	PUSH    ES
	POP     DS
	XOR     DX,DX
	MOV	CX,DI
        MOV     AH,40H
        INT     21H

        MOV     AH,3EH
        INT     21H

        MOV     BX,OFFSET FILENAME
        INC     BYTE PTR CS:[BX+7]

        POP     CX
        LOOP    GENFILE

        INT     20H

FILENAME DB     '00000000.COM',0

GEN_MSG DB      'Generating 10 mutation programs...$',0ah,0dh

PROG:
        CALL    SIGN_OFF
MSG 	   DB	'Eternal Maverick Small Polimorphic Engine v3.0.',0ah,0dh
	   DB	'For free use and distribution.','$'
FileOff    DW	100h
SIGN_OFF:
	POP     DX
        MOV     AH,9
        INT     21H
        INT     20H
end_prog:
	end begin