
; =============== S U B	R O U T	I N E =======================================

; �㭪�� ����� ᫮�� � ������	�� 㪠������� �����.
; �ଠ�	�맮��:
;
; 05 00	a0 a0 a2 a3 d0 d1 d2 d3
;
; a0-a3	- ����, �� ����襣� ���� � ���襬�
; d0-d3	- ᫮��	��� �����, �� ����襣�	���� �	���襬�
;
; �⢥�	�����稪�:
;
; 7e 06	06 �� �� 7e

cmd_05_write_patched				  ; DATA XREF: seg001:2A011900o
		PUSH		{R4,LR}
		ADD.W		R1, R0,	#8	  ; R1 ⥯��� �����뢠�� �� ���� +4 �� ��砫�
						  ; ���������� ����
		LDR		R0, [R1]	  ; R0=	���� �� ���������� ���� (+4)
		LDR		R1, [R1,#4]	  ; R1=	����� ��� ����� (+8)
		STR		R1, [R0]	  ; �����뢠�� ᫮�� � ������
		LDR		R0, =cmd_reply_code ; ���� �⢥⭣� ����
		MOVS		R2, #6		  ; ���	�⢥� - 6
		STRB		R2, [R0,#(cmd_reply_code - 0x2A0132DC)]	; �����뢠�� �⢥� � ���� 0
		STRB		R2, [R0,#(cmd_reply_data0 - 0x2A0132DC)] ; � � ���� 1 ���������� ����
		LDR		R0, =cmd_processor_data	;  ������� ������ ���������� ��ࠡ��稪�
		MOVS		R4, #2		  ; ����� �⢥⭮�� �����
		STRH		R4, [R0,#(pkt_data_len - 0x2A0118BC)]
		BL		Prepare_reply_buf ; �ନ�㥬 �⢥�� ���� - ����뢠��	����஫���
						  ; �㬬� � ��ࠬ����� �⢥�
		BL		Send_reply_buf	  ; ���뫠�� �⢥�� ���� ���� �१	USB
		POP		{R4,PC}
; End of function cmd_05_write_patched