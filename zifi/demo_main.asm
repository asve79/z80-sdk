;encoding cp1251
	module main

	include "../common/common.mac"
	include "demo_main.mac"
	include "../strings/strings.mac"
	include "../windows_bmw/wind.mac"

	IFDEF	TS_ZIFI
	include "zifi.mac"
	ENDIF
	IFDEF	EVO_RS232
	include "zifi.mac"
	ENDIF

credentials
	DB	"ae-pio",0,"aewifi456",0
	;DB	"asve6s",0,"testtest",0

;- MAIN PROCEDURE -
PROG
	_printw wnd_main				;Основное окно
	_prints	msg_keys				;Приветсвие
	;_printcrlf
	LD A,0						;Бордюр. цвет черный
      	OUT (254),A

;	------------------------------------------
P1	_prints msg_init
	_fillzero input_bufer,#FF
	_zifi_init input_bufer				;Инициализация
	PUSH	AF
	_prints input_bufer
	POP	AF
	LD	B,0					;не отключаться от AP
	CP	1
	JZ	command_error
	CP	2
	JZ	command_timeout

	_prints msg_separator
	CALL	sleep

;	------------------------------------------
;	_prints msg_scanap
;	_zifi_list_ap input_bufer			;Список точек доступа
;	PUSH	AF
;	_prints input_bufer
;	POP	AF
;	LD	B,0					;не отключаться от AP
;	CP	1
;	JZ	command_error
;	CP	2
;	JZ	command_timeout
;	_prints msg_separator
;	------------------------------------------
	_prints msg_connect_ap
	_fillzero input_bufer,#FF
	_zifi_connect_ap input_bufer, credentials	;Подключиться к точке доступа
	PUSH	AF
	_prints input_bufer
	POP	AF
	LD	B,0					;не отключаться от AP
	CP	1
	JZ	command_error
;	CP	2
;	JZ	command_timeout				;пока не обрабатываем тут таймаут
	_prints msg_separator
	CALL	sleep

;	------------------------------------------
;	_fillzero input_bufer,#FF
;	_zifi_current_ip input_bufer			;Показать текущий IP
;	_prints input_bufer
;	_prints msg_separator
;	------------------------------------------
;	_prints msg_ping_ya_ru
;	_fillzero input_bufer,#FF
;	_zifi_ping input_bufer, addr_ya			;Пингануть хост яндекса
;	_prints input_bufer
;	_prints msg_separator
;	------------------------------------------
	_prints msg_openconn_1
	_fillzero input_bufer,#FF
	_fillzero rcv_bufer,#FF
	_fillzero rcv_bufer+#FF,#FF
	_fillzero rcv_bufer+#1FF,#FF
	_zifi_open_tcp input_bufer, addr_ya, rcv_bufer,1024	;Открыть соединение 1
	PUSH	AF
	_prints input_bufer
	POP	AF
	LD	B,1					;отключаться от AP
	CP	#FF					;#FF значит не установилось соединение (пока нет определение причины отказа)
	JZ	command_error
	PUSH	AF
	_prints msg_connction_id			;вывести номер соединения
	POP	AF
	PUSH	AF					;Сохраняем ID соединения
	_a_hex
	_printcrlf
	_prints msg_separator
	CALL	sleep
;	------------------------------------------
	_fillzero input_bufer,#FF
	_prints msg_sendrequest				;отправить данные
	POP	AF					;идентификатор соединения
	;LD	A,1
	LD	HL,input_bufer				;буфер для операций и результата
	LD	DE,data_request				;буфер с данными для отправки
	LD	BC,data_request_len			;длина отправляемых данных
	_zifi_send
	PUSH	AF
	_prints input_bufer
	POP	AF
	LD	B,2					;закрыть соединение и отключаться от AP
	CP	1
	JZ	command_error
	CP	2
	JZ	command_timeout
	_prints msg_separator
	CALL	sleep
;	------------------------------------------
	_prints msg_recevedata				;прием данных
lwair1	_fillzero input_bufer, #FF
	LD	HL,input_bufer
lwair	halt
	_zifi_receve
	JZ	lwair
	_prints	input_bufer
	_zifi_receve					;проверить нет ли чего еще в буфере
	JR	NZ,lwair1

	_prints msg_separator
	CALL	sleep
;	------------------------------------------
l2d	;_prints msg_separator				;закрытие соединение
	_prints msg_closeconn_1
	_fillzero input_bufer,#FF
	LD	A,1					;Номер канала
	_zifi_close_tcp input_bufer			;Закрыть соединение 1
	PUSH	AF
	_prints input_bufer
	POP	AF
	LD	B,1					;отключаться от AP
	CP	1
	JZ	command_error
	CP	2					;Это не имеет смысла, но пусть будет
	JZ	command_timeout

l1d	_prints msg_separator
;	------------------------------------------
	_prints msg_disconnect_ap
	_fillzero input_bufer,#FF
	_zifi_disconnect_ap input_bufer			;Отключиться от AP
	PUSH	AF
	_prints input_bufer
	POP	AF
	CP	1
	JZ	command_error
	CP	2
	JZ	command_timeout

	_prints msg_separator
;	------------------------------------------

	LD	A,'>'
	_printc

	_cur_on

mloop   ;CALL	check_rcv
	CALL    spkeyb.CONINW	;main loop entry
	JZ	mloop		;wait a press key
	CP	01Dh
	JZ	exit		;if SS+Q pressed, exit
	CP	#08		;left cursor key pressed
	JZ	mloop
	CP	#19		;right cursor key pressed
	JZ	mloop
	CP	#1A		;up cursor key pressed
	JZ	mloop
	CP	#18		;down cursor key pressed
	JZ	mloop
	CP	#7F		;//delete key pressed
	JZ	delsymtermmode
	CP	13		;//enter key pressed
	JZ	enterkeytermmode
	CALL	puttotermbufer	;//put char to command bufer and print
	;_SendChar
	JP	mloop

command_error
	_prints	msg_cmd_error
	_cur_on
	LD	A,B
	OR	A
	JP	Z,mloop
	_cur_off
	CP	2
	JP	Z,l2d
	JP	l1d

command_timeout
	_prints	msg_cmd_timeout
	_cur_on
	LD	A,B
	OR	A
	JP	Z,mloop
	_cur_off
	CP	2
	JP	Z,l2d
	JP	l1d

delsymtermmode	;delete symbol in terminal mode
	_findzero input_bufer	;//get ptr on last symbol+1 in buffer
delsymproc	;delete symbol main proc
	OR	A
	JZ	mloop		;//if nothing in bufer (length=0)
	DEC	HL
	XOR	A
	LD	(HL),A		;//erase symbol
	LD	A,8		;/cusor to left
	_printc
	LD	A,' '		;//space
	_printc
	LD	A,8		;//left again
	_printc
	JP	mloop

;----
enterkeytermmode	;enter key pressed in terminal window
	_ishelpcommand  input_bufer,ekcm_nc	;//'help' command
	_isaboutcommand input_bufer,ekcm_nc	;//'about' command
	_isexitcommand input_bufer,ekcm_nc	;//'exit' command

ekcm_nc	_fillzero input_bufer,255
	_cur_off
	LD	A,13
	_printc
	_cur_on
	JP	mloop
;- routine -
puttocmdbufer	;put symbol in command bufer
	PUSH	AF
	_findzero command_bufer
	JR	puttobufer
puttotermbufer	;put symbol to terminal bufer
	PUSH 	AF
	_findzero input_bufer
puttobufer	;main procedure for put to bufer;TODO make insert mode with shift content
	POP	AF
	LD	(HL),A
	_printc		;out characte
	RET

exit	_cur_off
	_closew
	RET

init	XOR	A
	LD 	(mode),A	;set terminal mode
	RET

sleep 	PUSH	BC
	LD	B,100
1	HALT
	DJNZ	1b
	POP	BC
	RET

;/ inctease counter every interrupt
INCCNTR LD	A,(im_cntr)
	INC	A
	LD	(im_cntr),A
	RET

	include "demo_data.asm"
	include "../strings/strings.a80"
	IFDEF	TS_ZIFI
	include "ts-conf.a80"
	ENDIF

	endmodule
