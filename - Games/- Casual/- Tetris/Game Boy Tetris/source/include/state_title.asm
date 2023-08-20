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
; state.title
; -----------------------------------------------------------------------------
; Inputs: none

state.title SUBROUTINE
                        PREVIOUS_STATE= nil
                        NEXT_STATE= options

                        jsr view.DrawTitleScreen
                        WRITE_CHAR 1,14
                        DC.B "+",EOL
                        jsr screen.Toggle

                        jsr view.DrawTitleScreen
                        WRITE_CHAR 11,14
                        DC.B "+",EOL

                        START_TUNE title
.p1Loop
                        WAIT_KEY 0

                        cmp #input.RIGHT
                        beq .selectP2

                        ;cmp #input.BACK
                        ;beq .testMode

                        cmp #input.BUTTONA
                        beq .start

                        cmp #input.START
                        bne .p1Loop
.start
                        STOP_TUNE a
                        rts
.testMode
                        lda #0
                        sta state.lines
                        lda #9
                        sta state.playerBlevel
                        lda #5
                        sta state.playerHigh
                        state:gameType= "B"
                        lda #$20
                        sta state.score+2
                        NEXT_STATE= rockets
                        rts

                        ; Guess what... there's no 2 player option
                        ; just like on the Gameboy (unless you have
                        ; a Gameboy link cable). If you try to press Start,
                        ; it'll toggle back to 1 player (again, just like
                        ; on the Gameboy (without a link cable))

.selectP2
                        jsr screen.Toggle
.p2Loop
                        WAIT_KEY 0

                        cmp #input.LEFT
                        beq .selectP1

                        cmp #input.BUTTONA
                        beq .selectP1

                        cmp #input.START
                        bne .p2Loop
.selectP1
                        jsr screen.Toggle
                        jmp .p1Loop
