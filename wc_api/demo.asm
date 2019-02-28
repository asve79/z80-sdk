	DEVICE ZXSPECTRUM128

        include "../common/common.mac"
        include "../wc_api/wind.mac"
        include "../wc_api/keys.mac"

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
;-------
        DB 0,(endCode - startCode) / 512 + 1; CODE
	DS 2*5
;-------
        DS 2*8	;reserved
;-------
        DS 32*3
;-------
        DB 0
;-------
        DW #6000,#0000; MAX SIZE
;-------
        DB "PLUGIN ASVE PLUG"
        DB "!!!             "
;-------
        DB 3
;---------------------------------------
        ALIGN 512
        DISP #8000
;-------
;LOBU    EQU #A000
;---------------------------------------
PLUGIN  PUSH IX
        di
;        _waitkeyoff
;        LD (DAHL),HL
 ;       LD (DADE),DE

        ;LD IX,PLWND
        ;CALL PRWOW      ;вывод окна на экран
        _init_txtmode
        _printw PLWND
        _prints txt_prints

        _cur_on
        ;LD HL,TXT0
        ;LD DE,#010B
        ;LD BC,12
        ;CALL PRSRW      ;печать строки в окне
        ;LD A,%11110111
        ;CALL PRIAT
        ;_waitkeyoff

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

        _prints txt_input
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
        LD A,(ESTAT)
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
txt_input       DB "input (ESC to exit):",0
;---------------------------------------
DAHL    DS 2
DADE    DS 2

TITLE   DB #0E," DEMO ",0

ESTAT   NOP

        include "wind.a80"
        include "keys.a80"

	ENT
endCode
;---------------------------------------
        SAVEBIN "WC_DEMO.WMF", startCode, endCode-startCode