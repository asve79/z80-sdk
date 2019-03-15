wnd_main
	DB 0,0
	DB 32,24
	DB 00001111B
	DB 00000011B
	DB 0,0
	DB 0
	IFDEF TS_ZIFI
	DB 1,'DEMO (TS-CONF ZIFI build)',0
	ENDIF
	IFDEF TS_RS232
	DB 1,'DEMO (TS-CONF RS232 build)',0
	ENDIF
	IFDEF EVO_RS232
	DB 1,'DEMO (EVO RS232 build )',0
	ENDIF

wnd_cmd
        DB 0,21
        DB 32,3
        DB 00110010B
        DB 00000001B
        DB 0,0
        DB 0
        DB 1,'Command:',0


msg_keys
	IFDEF TS_ZIFI
        DB '* DEMO for TS-CONF ZIFI *',13,13
	ENDIF
	IFDEF TS_RS232
        DB '* DEMO for TS-CONF RS232 *',13,13
	ENDIF
	IFDEF EVO_RS232
        DB '* DEMO for ZX Evo RS232 *',13
        DB "Kondratiev's UART theme",13,13
	ENDIF
        DB 'Press SS+Q for exit.',13
        DB 'Press SS+W for command menu',13
	DB '"help" - for command list',13
	DB '----------------------------',13,13,0

msg_help 
	DB 13,13,'Commands:'
        DB 13,'---------'
	DB 13,'Keys:'
	DB 13,'-----'
	DB 13,'SS+Q - Exit to TR-DOS'
	DB 13,13,0

msg_about
	DB 13,'About:'
	DB 13,'------'
	DB 13,'Application by asve (asve@ae-nest.com)'
	DB 13,'Window libs by https://github.com/mborisov1'
	DB 13,13,0


msg_init	DB	'Initialisation Zifi',13,0
msg_scanap	DB	"Scan avalible AP's", 13,0

mode		DB 0
inc_addr 	DB 0

	IFDEF TS_RS232
msg_notsrs	DB 'No RS module ts-conf theme connected',0
	ENDIF

	IFDEF TS_ZIFI
msg_nozifi	DB 'No Zifi connected!',0
	ENDIF

msg_rx_owerflow DB 13,'RX FIFO Owerflow!',13,0

cmd_open  	DB 'open',0
cmd_close 	DB 'close',0
cmd_help  	DB 'help',0
cmd_about 	DB 'about',0
cmd_exit  	DB 'exit',0
cmd_quit	DB 'quit',0

;----------------------------- VARIABLES ---------------------
im_cntr		DB 0

;buffer for Commands
command_bufer	DEFS #FF,0

;buffer for intput. MAX 255 bytes
input_bufer	DEFS #FF,0
		DB 13
data_bufer	DEFS #FF,0
