	DEVICE ZXSPECTRUM128

        include "../common/common.mac"
        include "../wc_api/wind.mac"
        include "../wc_api/keys.mac"
        include "../wc_api/fs.mac"

WLD     EQU #6006
;---------------------------------------
startCode
        ORG #0000
;HEADER:       
        DS 16
        DB "WildCommanderMDL";    Header
        DB #0A;                  Version
        DB 0;                       Type
        DB 1; Pages
        DB 0; Page to #8000
        DB 0,(endCode - startCode) / 512 + 1; CODE
	DS 2*5
        DS 2*8	;reserved
        DS 32*3
        DB 0
        DW #6000,#0000; MAX SIZE
        DB "PLUGIN ASVE PLUG"
        DB "!!!             "
        DB 3
        ALIGN 512
        DISP #8000

;---------------------------------------
PLUGIN  PUSH IX
        di

        _init_txtmode
        _printw PLWND
        _prints txt_prints

        _cur_on

        _prints txt_printc
        LD      A,13
        _printc
        _printc

        _prints txt_hl_hex
        LD      HL,#1021
        _hl_hex
        LD      A,13
        _printc
        _prints txt_a_hex
        LD      A,13
        _a_hex
        _printc
        _printc
;--------------------------------------------
        _prints filebufer
        LD      A,13
        _a_hex
        _printc
        _printc

        _fentry loadfile
        JNZ     F1
        _prints txt_file_notfound
        JRZ     F2
F1      _gfile
        LD      B,1
        LD      HL,filebufer
        PUSH    HL
        _hl_hex
        POP     HL
        LD      A,13
        _printc
        _printc
        _loadblock512
        PUSH    HL
        _hl_hex
        POP     HL
        LD      A,13
        _printc
        _printc
        _prints txt_anykey
F11     EI:HALT                 ;wait a get
        _is_enter_key
        JR      Z,F11

        _prints filebufer
        LD      A,13
        _a_hex
        _printc
        _printc
;----------------------------------------------
F2      _prints txt_mkfile
        _mkfile filestruct
        JZ      C1
        _prints txt_errmkfile
        JP      CI
C1      _prints txt_writefile
        LD      B,1             ;one block
        LD      HL,filebufer    ;bufer
        _saveblock512
        PUSH    HL
        _a_hex
        LD      A," "
        _printc
        POP     HL
        _hl_hex
CI      _prints txt_input
MAIN    EI:HALT
        _is_enter_key
        JR      NZ,2f
       _is_escape_key
        JR      NZ, EXIT
       _getkey
        JR      Z,MAIN
        JR      PR
2       LD      A,13
PR      PUSH    AF
        _printc
        LD      A,"("
        _printc
        POP     AF
        _a_hex
        LD      A,")"
        _printc
        LD      A," "
        _printc
        JR      MAIN
EXIT    _closew

        ;LD A,(ESTAT)
        LD      A,3     ;Перечитать каталог после выхода из плагина
        POP IX
        RET
;---------------------------------------
PRIAT   EXA             ;выставление цвета (вызывается сразу после PRSRW)
        LD A,4
        JP WLD

;---------------------------------------
PLWND   DB %01000010    ;TYPE
        DB 0            ;маска цвета курсора
        DB 10,2;     X,Y
        DB 64,26;  W,H
        DB %01111111;PAPER+INK
        DB 0
        DW #0000;    BUFFER
        DB 0,0;      LINES
        DB 1;   +12¦   1¦позиция курсора в окне (от 1)
        DB 1;   +13¦   1¦нижний ограничитель
        DB 0;   +14¦   1¦цвет курсора (накладывается по маске из +1(1))
        DB 0;   +15¦   1¦цвет окна под курсором
        DW TITLE;+16¦   2¦адрес строки для верхнего заголовка окна (если = 0 то игнорируем)
        DW 0;   +18¦   2¦адрес строки для нижнего заголовка окна (если = 0 то игнорируем)
        DW 0;   +20¦   2¦адрес строки/абзаца для вывода в окно (если = 0 то игнорируем)
        ;-------
txt_prints      DB "Function prints: HELLO WORLD!",13,0
txt_printc      DB "Function printc (code 13 - CR/LF)",13,0
txt_a_hex       DB "Function a_hex:",13,0
txt_hl_hex      DB "Function hl_hex:",13,0
txt_input       DB 13,13,"input (ESC to exit):",0
txt_mkfile      DB "Make test file...",13,0
txt_errmkfile   DB "Error creating file.",13,0
txt_writefile   DB "Write 100 bytes to file",13,0
txt_file_notfound DB 13,"File not found",13,0
txt_anykey      DB 13,"Print any key",13,0
;---------------------------------------
DAHL    DS 2
DADE    DS 2

TITLE   DB #0E," DEMO ",0

ESTAT   NOP

        include "wind.a80"
        include "keys.a80"
        include "fs.a80"

filestruct 
        DB      0               ;type
        DB      100,0,0,0       ;size (format: L1 H1 L2 H2)
        DB      "test_f.txt",0  ;name
loadfile
        DB      0,"WC_todo.txt",0
filebufer
        DS      512,"A"         ;bufer as 512b (1 block)
        DB      0
	ENT
endCode
;---------------------------------------
        SAVEBIN "WC_DEMO.WMF", startCode, endCode-startCode