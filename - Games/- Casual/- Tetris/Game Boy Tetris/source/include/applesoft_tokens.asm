; -----------------------------------------------------------------------------
; Copyright © 2020 Lee Fastenau
; Tetris™️ is copyright © The Tetris Company, LLC
; Game Boy™️ is copyright © Nintendo Co., Ltd.
;
; This file is part of GB Tetris for Apple II.
;
; GB Tetris for Apple II is free software: you can redistribute it
; and/or modify it under the terms of the GNU General Public License as
; published by the Free Software Foundation, either version 3 of the
; License, or any later version.
;
; GB Tetris for Apple II is distributed in the hope that it will be
; useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with GB Tetris for Apple II.  If not, see:
; https://choosealicense.com/licenses/gpl-3.0/
; -----------------------------------------------------------------------------

as.END                  EQU $80
as.FOR                  EQU $81
as.NEXT                 EQU $82
as.DATA                 EQU $83
as.INPUT                EQU $84
as.DEL                  EQU $85
as.DIM                  EQU $86
as.READ                 EQU $87
as.GR                   EQU $88
as.TEXT                 EQU $89
as.PR                   EQU $8A
as.IN                   EQU $8B
as.CALL                 EQU $8C
as.PLOT                 EQU $8D
as.HLIN                 EQU $8E
as.VLIN                 EQU $8F
as.HGR2                 EQU $90
as.HGR                  EQU $91
as.HCOLOR               EQU $92
as.HPLOT                EQU $93
as.DRAW                 EQU $94
as.XDRAW                EQU $95
as.HTAB                 EQU $96
as.HOME                 EQU $97
as.ROT                  EQU $98
as.SCALE                EQU $99
as.SHLOAD               EQU $9A
as.TRACE                EQU $9B
as.NOTRACE              EQU $9C
as.NORMAL               EQU $9D
as.INVERSE              EQU $9E
as.FLASH                EQU $9F
as.COLOR                EQU $A0
as.POP                  EQU $A1
as.VTAB                 EQU $A2
as.HIMEM                EQU $A3
as.LOMEM                EQU $A4
as.ONERR                EQU $A5
as.RESUME               EQU $A6
as.RECALL               EQU $A7
as.STORE                EQU $A8
as.SPEED                EQU $A9
as.LET                  EQU $AA
as.GOTO                 EQU $AB
as.RUN                  EQU $AC
as.IF                   EQU $AD
as.RESTORE              EQU $AE
as.AMP                  EQU $AF
as.GOSUB                EQU $B0
as.RETURN               EQU $B1
as.REM                  EQU $B2
as.STOP                 EQU $B3
as.ON                   EQU $B4
as.WAIT                 EQU $B5
as.LOAD                 EQU $B6
as.SAVE                 EQU $B7
as.DEFFN                EQU $B8
as.POKE                 EQU $B9
as.PRINT                EQU $BA
as.CONT                 EQU $BB
as.LIST                 EQU $BC
as.CLEAR                EQU $BD
as.GET                  EQU $BE
as.NEW                  EQU $BF
as.TAB                  EQU $C0
as.TO                   EQU $C1
as.FN                   EQU $C2
as.SPC(                 EQU $C3
as.THEN                 EQU $C4
as.AT                   EQU $C5
as.NOT                  EQU $C6
as.STEP                 EQU $C7
as.ADD                  EQU $C8
as.SUB                  EQU $C9
as.MULT                 EQU $CA
as.DEV                  EQU $CB
as.SEMI                 EQU $CC
as.AND                  EQU $CD
as.OR                   EQU $CE
as.GT                   EQU $CF
as.EQ                   EQU $D0
as.LT                   EQU $D1
as.SGN                  EQU $D2
as.INT                  EQU $D3
as.ABS                  EQU $D4
as.USR                  EQU $D5
as.FRE                  EQU $D6
as.SCRN                 EQU $D7
as.PDL                  EQU $D8
as.POS                  EQU $D9
as.SQR                  EQU $DA
as.RND                  EQU $DB
as.LOG                  EQU $DC
as.EXP                  EQU $DD
as.COS                  EQU $DE
as.SIN                  EQU $DF
as.TAN                  EQU $E0
as.ATN                  EQU $E1
as.PEEK                 EQU $E2
as.LEN                  EQU $E3
as.STR                  EQU $E4
as.VAL                  EQU $E5
as.ASC                  EQU $E6
as.CHR                  EQU $E7
as.LEFT                 EQU $E8
as.RIGHT                EQU $E9
as.MID                  EQU $EA
