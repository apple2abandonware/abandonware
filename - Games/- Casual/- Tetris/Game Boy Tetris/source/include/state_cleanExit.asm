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

; -----------------------------------------------------------------------------
; state.cleanExit
; -----------------------------------------------------------------------------
; Inputs: none

state.cleanExit SUBROUTINE
                        PREVIOUS_STATE= nil
                        NEXT_STATE= nil

                        lda TXTSET
                        lda LOWSCR
                        jsr zp.Restore
                        jsr cleanExit.LoadReentryProg
                        jsr $D66C       ; CLEAR
                        jsr MON_HOME    ; HOME

                        PRINT "THANK YOU FOR PLAYING."
                        PRINT "TYPE ",'","RUN",'"," TO RESTART GAME!"

                        jmp $E003       ; Resume BASIC

; -----------------------------------------------------------------------------
; cleanExit.LoadReentryProg
; -----------------------------------------------------------------------------
; Inputs: none

cleanExit.LoadReentryProg SUBROUTINE

.PROG_DEST              EQU $800
.PROG_END               EQU .PROG_DEST + .PROG_SIZE

                        ECHO "Recommended PROGRAM segment start:",.PROG_END

                        lda #<.PROG_END
                        sta $AF
                        sta $69
                        lda #>.PROG_END
                        sta $B0
                        sta $6A

                        lda #<.PROG_SRC
                        sta copy.SrcL
                        lda #>.PROG_SRC
                        sta copy.SrcH
                        lda #<.PROG_DEST
                        sta copy.DestL
                        lda #>.PROG_DEST
                        sta copy.DestH
                        lda #<.PROG_SIZE
                        sta copy.SizeL
                        lda #>.PROG_SIZE
                        sta copy.SizeH

                        jsr copy.MoveDown

                        rts

                MAC PROG_LINE           ; Local macro
                        DC.W .nextLine - prog.OFFSET
                        DC.W prog.LINE
                        DC.B {0}
                        DC.B $00
prog.LINE               SET prog.LINE+prog.LINE_INC
.nextLine
                ENDM

prog.OFFSET             EQU .PROG_SRC - .PROG_DEST
.PROG_SRC
                        DC.B $00
prog.LINE_INC           SET 1
prog.LINE               SET 9
                        PROG_LINE as.CALL, [entry.WarmStart]d
                        PROG_LINE "***************************"
                        PROG_LINE "*                         *"
                        PROG_LINE "* ORIGINAL CONCEPT,       *"
                        PROG_LINE "* DESIGN, & PROGRAM       *"
                        PROG_LINE "*         ALEXEY PAJITNOV *"
                        PROG_LINE "*                         *"
                        PROG_LINE "* DIRECTOR                *"
                        PROG_LINE "*            SATORU OKADA *"
                        PROG_LINE "*                         *"
                        PROG_LINE "* PRODUCER                *"
                        PROG_LINE "*            GUNPEI YOKOI *"
                        PROG_LINE "*                         *"
                        PROG_LINE "* DESIGNER                *"
                        PROG_LINE "*       HIROFUMI MATSUOKA *"
                        PROG_LINE "*                         *"
                        PROG_LINE "* PROGRAMMER              *"
                        PROG_LINE "*          MASAO YAMAMOTO *"
                        PROG_LINE "*                         *"
                        PROG_LINE "* COMPOSER                *"
                        PROG_LINE "*         HIROKAZU TANAKA *"
                        PROG_LINE "*                         *"
                        PROG_LINE "***************************"
                        DC.W $0000
.PROG_SIZE              EQU *-.PROG_SRC
