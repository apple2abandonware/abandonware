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
; state.highScore
; -----------------------------------------------------------------------------
; Inputs: none

state.highScore SUBROUTINE
                        PREVIOUS_STATE= nil
                        NEXT_STATE= optionsAType

                        bit zp.Flags
                        bvc .gameA
                        NEXT_STATE= optionsBType
.gameA
                        jsr highscore.PrepForEntry
                        bcs .eligible
                        rts             ; Ineligible for high score entry
.eligible
                        bit zp.Flags
                        bvs .gameB
                        jsr view.DrawOptionsATypeScreen
                        jmp .continue
.gameB
                        jsr view.DrawOptionsBTypeScreen
                        jsr select.refreshHigh
.continue
                        jsr select.refreshLevel
                        jsr highscore.RenderScores
                        jsr screen.ShowActive

                        START_TUNE highscore

                        clc
                        lda #13
                        adc highscore.InsertRow
                        sta TileY
                        lda #1
                        sta .stringIndex_SMC
                        lda #4
                        sta TileX
                        CLEAR_KEYS
.inputLoop
                        jsr .drawCursor
                        WAIT_KEY CURSOR_BLINK_SPEED/2
                        lda input.lastKeyCode
                        bne .keyPressed
                        jsr .drawCharacter
                        WAIT_KEY CURSOR_BLINK_SPEED/2
                        lda input.lastKeyCode
                        bne .keyPressed
                        beq .inputLoop          ; Always branches
.keyPressed
                        CLEAR_KEYS
                        cmp #$5F
                        beq .isBackspace
                        cmp #$08
                        beq .isBackspace
                        cmp #$0D
                        beq .isReturn
                        ldy .stringIndex_SMC
                        cpy #7
                        beq .inputLoop
.filter
                        cmp #'
                        beq .valid
                        cmp #'-
                        beq .valid
                        cmp #'.
                        beq .valid
                        cmp #'*
                        beq .valid
                        cmp #'0
                        bmi .inputLoop
                        cmp #'9 + 1
                        bmi .valid
                        cmp #'A
                        bmi .inputLoop
                        cmp #'Z + 1
                        bpl .inputLoop
.valid
                        sta (highscore.RecordL),y
                        jsr .drawCharacter
                        lda .stringIndex_SMC
                        inc .stringIndex_SMC
                        inc TileX
                        jmp .inputLoop

.isBackspace
                        lda .stringIndex_SMC
                        cmp #1
                        beq .inputLoop

                        jsr .drawCharacter
                        dec .stringIndex_SMC

                        lda .stringIndex_SMC
                        cmp #6
                        lda #'%
                        ldy .stringIndex_SMC
                        sta (highscore.RecordL),y

                        dec TileX
.noMove
                        jmp .inputLoop
.isReturn
                        jsr screen.ToggleActive
                        rts

.drawCursor
                        lda #1
                        sta TileNum
                        jsr DrawTile
                        rts

.drawCharacter
                        ldy #$00
.stringIndex_SMC        EQU *-1
                        cpy #7
                        beq .tail
                        lda (highscore.RecordL),y
                        jmp .drawCharacterCore
.tail
                        lda #32
.drawCharacterCore
                        tax
                        lda char.TabL,x
                        sta zp.TileL
                        lda char.TabH,x
                        sta zp.TileH
                        jsr DrawTileCore
                        rts

