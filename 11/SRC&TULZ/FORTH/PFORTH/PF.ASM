
;      ��                  �
;     ���  Virus Magazine  � Box 176, Kiev 210, Ukraine      IV  1997
;     ��� ���������������� � ������������������� � ��������  ��������
;      �� ��� ��� ��� ��� ��� ��� ���    � � ��� � ��� ���   � �  � �
;       � � � ��  ��  �    �  ��  � �    � � � � � �   �     � �  � �
;       � � � �   ��� ���  �  ��� ���     �� ��� � ��� ����  � �  � �
;       � ����������������� �������������������������������  ��������
;          (C) Copyright, 1994-97, by STEALTH group WorldWide, unLtd.

; ��⭠������ ���� ��襬 ����訬� �㪮����,� �����稢��� - 'h'

; ᫮�� ������������ �ᯮ������ �����稢����� '~'

; �� �맮�� ⠪��� ᫮�� : 
;   SI=ofs ᫥���饣� ᫮��
;   DI=ofs ���� ������ ����
; �����頥� �������� ��������� � ��⮬ �ந��������� ����⢨� SI � DI.

;

		.model tiny
		.code
.286
		org	100h
;-----------------------------------------------------
compiledcode	label	byte		; ��� �㤥� �ᯮ�������� 楫���� ���!
		db	2048 dup (0)
;-----------------------------------------------------
;/////////////////////////////////////////////////////
;-----------------------------------------------------
movreg:
		lodsw
		inc	si
		push	si
		lea	si,RegKop
		lea	bx,RegTabl
movreg1:
		cmp	[bx],ax
		jz	OkKop
		inc	si
		inc	bx
		inc	bx
		jmp	movreg1
OkKop:
		lodsb
		stosb	; make mov reg,  comand
		pop	si
		call	HexCode
		dec	si
		mov	[di+1],al
		call	HexCode
		stosb
		inc	di
		ret
RegTabl		db	'axbxcxdxsidibpsp'
RegKop		db	0b8h,0bbh,0b9h,0bah,0beh,0bfh,0bdh,0bch
;--------------------------
;	reg <-- stack
sax:		pop	ax
sbx:		pop	bx
scx:		pop	cx
sdx:		pop	dx
ssi:		pop	si
sdi:		pop	di
sbp:		pop	bp
ssp:		pop	sp
sds:		pop	ds
ses:		pop	es
;--------------------------
;	reg --> stack
axs:		push	ax
bxs:		push	bx
cxs:		push	cx
dxs:		push	dx
sis:		push	si
dis:		push	di
bps:		push	bp
sps:		push	sp
dss:		push	ds
ess:		push	es
css:		push	cs
sss:		push	ss
;--------------------------
; mem <-- stack  ( addr w -- )
sm:
		pop	ax bx
		mov	[bx],ax
;--------------------------
; mem --> stack  ( addr -- w )
ms:
		pop	bx
		push	word ptr [bx]
;--------------------------
; return  ( addr -- )
sret:		ret
;--------------------------
; return  ( seg ofs -- )
sfret:		retf
;--------------------------
zret:
		jnz	NoZ
		ret
NoZ:
;--------------------------
nzret:
		jz	OkZ
		ret
OkZ:
;--------------------------
cret:
		jnc	NoCY
		ret
NoCY:
;--------------------------
ncret:
		jc	OkCY
		ret
OkCY:
;--------------------------
; ( w1 w2 -- ) 
scmp:
		pop	ax bx	; ax=w2 bx=w1
		cmp	ax,bx
;--------------------------
; ( w1 w2 -- w3 )
sadd:
		pop	ax bx
		add	ax,bx
		push	ax
;--------------------------
; ( w1 w2 -- w3 )
ssub:
		pop	ax bx
		sub	ax,bx	; ax = w2-w1
		push	ax
;--------------------------
; ( w1 -- )
sdrop:
		add	sp,2
;--------------------------
; ( w1 -- w1 w1 )
sdup:
		pop	ax
		push	ax ax
;--------------------------
; ( w1 w2 -- w2 w1 )
sswap:
		pop	ax bx
		push	ax bx
;--------------------------
; ( -- w )
lit:
		cmp byte ptr [si+4],'h'	; HEX?
		jnz	DecimalLit
		push	di
		lea	di,litdata
		call	HexCode
		mov	[di+1],al
		dec	si
		call	HexCode
		stosb
		pop	di
		push	si
		jmp	MakeLitCode
; Enter : si=ofs string to convert
; Exit  : al=hex byte
;	  si=ofs ᫥���騩 ��᫥ 00h ᨬ��� (�.�. �஡�� ��� ����)
HexCode:
		lodsb
		mov	dl,al
		sub	dl,'0'
		cmp	dl,09
		jle	litHex1
		sub	dl,07
litHex1:
		mov	cl,04
		shl	dl,cl
		lodsb
		sub	al,'0'
		cmp	al,09
		jle	litHex2
		sub	al,07
litHex2:
		add	al,dl	; al = bin
		inc	si
		ret
DecimalLit:
		mov	bp,si
DLit1:
		lodsb
		cmp	al,' '
		jnz	DLit1
		push	si
		sub	si,bp
		mov	litdata,0
		mov	MULT10,1
		mov	cx,10
		mov	bx,si
		dec	bx
		dec	bx
		mov	si,bp
B20:
		mov	al,[si+bx]
		and	ax,000fh
		mul	MULT10
		add	litdata,ax
		mov	ax,MULT10
		mul	cx
		mov	MULT10,ax
		dec	bx
		jnz	B20
MakeLitCode:
		lea	si,litcode
		mov	cx,offset endlit - offset litcode
		rep	movsb
		pop	si
		ret
MULT10		dw	1
litcode:
		call	$+3
lit1:
		pop	bx
		add	bx,offset litdata - offset lit1
		push	word ptr [bx]
		jmp short endlit
litdata		dw	0
endlit:
;--------------------------
wrd:
		push	di
		mov	ax,di
		mov	di,EndWrdO
		stosw
		add	EndWrdO,2
		mov	di,EndWrdT
		mov	al,0
		stosb
wrd1:
		lodsb
		cmp	al,' '
		stosb
		jnz	wrd1
		dec	di
		mov	EndWrdT,di
		pop	di
		ret
curProc		dw	0
;--------------------------
ewrd:
		mov	bx,EndWrdO
		mov	[bx],di
		ret
;--------------------------
exit:
		add	sp,4	; ��訡��� si & retaddr
		ret		
;--------------------------
intXX:
		mov	al,0cdh
		stosb
		call	HexCode
		stosb
		ret
;--------------------------
; ( -- w ) �������� � ��� ��ப� , �� �ᯮ������ �� ���� ������� �� �⥪
char:
		push	di si
		lea	si,charcode
		mov	cx,offset endcharcode - offset charcode
		rep	movsb
		pop	si
char1:
		lodsb
		cmp	al,'"'
		jz	EndChar
		stosb
		jmp	short char1
EndChar:
		pop	bx
		add	bx,(offset charcod1 - offset charcode)
		mov	ax,di
		sub	ax,bx
		sub	ax,03
		mov	word ptr [bx+1],ax
		ret
charcode:
		call	$+3
		pop	bx
		add	bx,(offset endcharcode - offset charcode)-3
		push	bx
charcod1:
		db	0e9h,00,00
endcharcode:
;--------------------------
; ( -- w ) w=$
curip:
		call	$+3
;--------------------------
; ( addrdest addrsourc count -- )
move:
		pop	cx si di
		rep	movsb
;--------------------------
; ��᫥ �⮣� ��������� �㤥� �ந��������� � ���� compilecode
make:
		mov	bx,EndWrdO
		mov	[bx],di
		mov	[bx+2],di
		add	EndWrdO,02
		mov	di,EndWrdT
		mov	ax,3300h
		stosw
		add	EndWrdT,02
		mov	di,offset compiledcode
		ret
;--------------------------
; ������� ᫮�� �㫥��� �����!������ ����� ������ ���室� -> ofs~ wrd ret
lab:
		push	di
		mov	bx,EndWrdO
		mov	[bx],di
		add	EndWrdO,2
		mov	di,EndWrdT
		xor	ax,ax
		stosb
Lab1:
		lodsb
		cmp	al,' '
		jz	EndLabel
		stosb
		jmp	Lab1
EndLabel:
		mov	EndWrdT,di
		pop	di
		ret
;--------------------------
; ( -- ) �뤥�塞 ���� � ᫮���
; alloc~ 10h <- BYTE!!!
alloc:
		mov	bx,di
		mov	ax,000e9h
		stosw
		stosb
		call	HexCode
		xor	ah,ah
		add	di,ax
		mov	ax,di
		sub	ax,bx
		sub	ax,03
		mov	[bx+1],ax
		ret
;--------------------------
ofs:
		call	FindWrd	; ax=offset word
		pop	bx
		mov	ax,[bx]
		push	si
		mov	litdata,ax
		jmp	MakeLitCode
;--------------------------
; ������㥬 �� ᨬ���� �� ���� ��ப� (CRLF)
remark:
		lodsb
		cmp	al,0Dh
		jnz	remark
		inc	si
		ret
;--------------------------
;--------------------------
;--------------------------
;-----------------------------------------------------
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;-----------------------------------------------------
; si = offset source
interpret:
		jmp	analyzesrc
;--------------
; enter : si=offset word on string in source
; exit  : stack = offset finded word in table
;	  si=offset next word in string
FindWrd:
		cld
		lodsb
		cmp	al,' '
		jz	FindWrd
		cmp	al,09		; TAB
		jz	FindWrd
		cmp	al,13		; 
		jz	FindWrd		; CR/LF
		cmp	al,10		;
		jz	FindWrd
;---------------------------------
		dec	si
		mov	bp,si
i1:
		lodsb
		cmp	al,' '
		ja	i1
		dec	si
		push	si
		sub	si,bp
		mov	dx,si		; dx = word lenght
		pop	si
		mov	bx,EndWrdT
		dec	bx
		xor	cx,cx
		dec	si
i2:
		push	dx
		std
		push	si
i3:
		lodsb
		cmp	byte ptr [bx],0
		jz	OkWord1
		cmp	[bx],al
		jnz	NewWrd
		dec	bx
		dec	dx
		jmp	i3
NewWrd:
		cmp	byte ptr [bx],0
		jnz	LookNext0
		dec	bx
		pop	si dx
		inc	cx
		jmp	i2
LookNext0:
		dec	bx
		jmp	NewWrd
OkWord1:
		cmp	dx,0
		jz	WrdFinded
		pop	si dx
		jmp	i2
WrdFinded:
		cld
		pop	si dx
		inc	cx
		mov	ax,02
		mul	cx	; ax = offset offset word in wrdofstable � ����
		mov	bx,EndWrdO
		sub	bx,ax	; [bx] = offset word code in vocabulary
		pop	ax
		push	bx
		inc	si
		inc	si		;   SI=ofs ᫥���饣� ᫮��
		push	ax
		ret
;-------------------------------------
; enter : bx=ofs string for print
;	  cx=counter
PrtWrd:
		mov	ah,02
		mov	dl,[bx]
		int	21h
		inc	bx
		loop	PrtWrd
		ret
;-------------------------------------
analyzesrc:
		push	si
		call	FindWrd
		pop	bp ax
		mov	cx,si
		sub	cx,ax
		mov	bx,ax
		call	PrtWrd
		mov	bx,bp
		cmp	byte ptr [si-2],'~'	; ** immediate ?
		pushf
		mov	di,EndCode	;   DI=ofs ���� ������ ����
		popf
		jnz	Compile			; ** No!
		push	si
		call	word ptr [bx]		; Run immediate code
		pop	bp
		cmp	si,bp
		jz	NoMoveSrc
		mov	cx,si
		sub	cx,bp
		mov	bx,bp
		call	PrtWrd
NoMoveSrc:
		mov	EndCode,di
		jmp	interpret
Compile:
		push	si
		mov	si,[bx]
		mov	cx,[bx+2]
		sub	cx,si		; cx = lenght word code
		rep	movsb
		mov	EndCode,di
		pop	si
		jmp	interpret
;-----------------------------------------------------
NewWords	label	byte
		db	2048 dup (0)
;-----------------------------------------------------
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
;-----------------------------------------------------
EndCode		dw	offset NewWords
EndWrdO		dw	offset WrdOfsEnd	; ����� ⠡���� ���ᮢ ���� ���� ᫮�
EndWrdT		dw	offset WrdMnemEnd	; ����� ⠡���� �������� ᫮�
;-----------------------------------------------------
WrdOfs		label	byte
	dw	offset movreg
	dw	offset sax,offset sbx,offset scx,offset sdx,offset ssi
	dw	offset sdi,offset sbp,offset ssp,offset sds,offset ses
	dw	offset axs,offset bxs,offset cxs,offset dxs,offset sis
	dw	offset dis,offset bps,offset sps,offset dss,offset ess
	dw	offset css,offset sss
	dw	offset sm,offset ms
	dw	offset sret,offset sfret,offset zret,offset nzret
	dw	offset cret,offset ncret
	dw	offset scmp,offset sadd,offset ssub
	dw	offset sdrop,offset sdup,offset sswap
	dw	offset lit,offset wrd,offset ewrd,offset exit
	dw	offset intXX,offset char
	dw	offset curip,offset move,offset make,offset lab
	dw	offset alloc,offset ofs,offset remark
	dw	offset interpret
WrdOfsEnd	label	byte	; ����� ⠡���� ���ᮢ ���� ���� ᫮�
	dw	255 dup (0)
;-----------------------------------------------------
WrdMnem		label	byte
	db	0,'mov~',0
	db	'ax<',0,'bx<',0,'cx<',0,'dx<',0,'si<',0,'di<',0,'bp<',0,'sp<',0
	db	'ds<',0,'es<',0
	db	'ax>',0,'bx>',0,'cx>',0,'dx>',0,'si>',0,'di>',0,'bp>',0,'sp>',0
	db	'ds>',0,'es>',0,'cs>',0,'ss>',0
	db	'!',0,'@',0
	db	'ret',0,'fret',0,'zret',0,'nzret',0,'cret',0,'ncret',0
	db	'=',0,'+',0,'-',0,'drop',0,'dup',0,'swap',0
	db	'lit~',0,'wrd~',0,'ewrd~',0,'exit~',0,'int~',0
	db	'"~',0,'$',0,'move',0,'make~',0,'label~',0,'alloc~',0,'ofs~',0
	db	'rem~'
	db	0,'interpret'
WrdMnemEnd	label	byte	; ����� ⠡���� �������� ᫮�
	db	1024 dup (' ')
;-----------------------------------------------------
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
;-----------------------------------------------------
entry:
		mov	ax,0003h
		int	10h
		cld
		push	cs
		pop	ds
		lea	dx,msg
		mov	ah,09
		int	21h
		push	es
		pop	ds
		mov	si,81h
SeeOpt:
		lodsb
		cmp	al,' '
		jz	SeeOpt
		cmp	al,13
		jnz	LookFile
		lea	dx,hlpmsg
PrtAexit:
		push	cs
		pop	ds
		mov	ah,09
		int	21h
		mov	ax,4c00h
		int	21h
LookFile:
		dec	si
		mov	dx,si
LookEndFname:
		lodsb
		cmp	al,13
		jnz	LookEndFname
		mov	byte ptr [si-1],0
		mov	ax,3d00h
		int	21h
		jnc	OpenOk
		lea	dx,operrormsg
		jmp	PrtAexit
OpenOk:
		xchg	ax,bx
;--------------------------------------
		push	dx ds cs
		pop	ds
		lea	dx,compmsg
		mov	ah,09
		int	21h
		pop	ds dx
		mov	byte ptr [si-1],'$'
		mov	ah,09
		int	21h
;--------------------------------------
		push	cs cs
		pop	ds es
		lea	dx,CRLF
		mov	ah,09
		int	21h
		lea	dx,placemsg
		mov	ah,09
		int	21h
;--------------------------------------
		lea	si,source
		mov	dx,si
		mov	ah,3fh
		mov	cx,32767
		int	21h
		mov	ah,3eh
		int	21h
		call	interpret
;----------------------------------------
		lea	dx,fname
		mov	cx,20h
		mov	ah,3ch
		int	21h
		mov	bx,ax
		mov	cx,EndCode		; ����� ���� ᫮����
		sub	cx,100h
		lea	dx,compiledcode
		mov	ah,40h
		int	21h
		mov	ah,3eh
		int	21h
		mov	ax,4c00h
		int	21h
;-----------------------------------------------------
fname	db 'targ.com',0
;------------------------------------------------------------------------------
msg label byte
db '�������������������������������������������������������������������������������',13,10
db '��      ����    ���� ���� ���� ����� �  � ������� ���������.                ��',13,10
db '��      �  �    ���  �  � �  �   �   ���� (Personal Forth)                   ��',13,10
db '��      ���� �  �    ���� ����   �   �  �                                    ��',13,10
db '��                                         ������������������������������������',13,10
db '��     (C) 1996 by Light General.          ��������������������������������Ŀ��',13,10
db '��     505:1/222.777@nasnet                �۰  ������ ���ଠ�� � ������  ���',13,10
db '��           �������������������������Ŀ   �۰ �ணࠬ�� ᮤ�ন��� � 䠩�� ���',13,10
db '�����������  � ������� 䠩� : TARG.COM �   �۰           PF.DOC             ���',13,10
db '�� v1.0  ��  �������������������������;   ������������������������������������',13,10
db '�������������������������������������������������������������������������������',13,10,'$'
compmsg label byte
db ' ������������ 䠩� : $'
placemsg label byte
db '�������������������������������������������������������������������������������',13,10
db 13,10,13,10,'$'
;------------------------------------------------------------------------------
hlpmsg	db '��ଠ� : PF 䠩�.���७�� <-- �������஢��� ⥪�� �� 䠩��'
CRLF		db 13,10,'$'
operrormsg	db '�訡�� ������ 䠩��!',13,10,'$'
;------------------------------------------------------------------------------
source		db	32767 dup (?)
;-----------------------------------------------------
		db	1024 dup (?)
.stack
		end	entry
