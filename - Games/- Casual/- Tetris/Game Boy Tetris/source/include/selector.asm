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

selector.COMMIT         EQU $ff
selector.CANCEL         EQU $fe

; -----------------------------------------------------------------------------
; selector.WaitKey
; -----------------------------------------------------------------------------
; Inputs: See DATA segment below

selector.WaitKey SUBROUTINE
                        SEG.U DATA
selector.IsFinal        DS.B 1          ; Is this the final selection before the game starts?
selector.CurrentValue   DS.B 1
selector.ItemCount      DS.B 1
selector.NewValue       DS.B 1
selector.WaitCounter    DS.B 1
selector.RowLength      DS.B 1
                        SEG PROGRAM

                        CLEAR_LAST_KEY
                        lda selector.CurrentValue
                        sta selector.NewValue
                        lda #CURSOR_BLINK_SPEED
                        sta selector.WaitCounter
.loop
                        jsr sound.Tick
                        jsr input.ReadInput
.checkLeft
                        cmp #input.LEFT
                        bne .checkRight
                        ldx selector.CurrentValue
                        dex
                        bmi .continue
                        stx selector.NewValue
                        bpl .playSoundAndExit
.checkRight
                        cmp #input.RIGHT
                        bne .checkUp
                        ldx selector.CurrentValue
                        inx
                        cpx selector.ItemCount
                        bcs .continue
                        stx selector.NewValue
                        bmi .playSoundAndExit
.checkUp
                        cmp #input.UP
                        bne .checkDown
                        lda selector.CurrentValue
                        sec
                        sbc selector.RowLength
                        bmi .continue
                        sta selector.NewValue
                        bpl .playSoundAndExit
.checkDown
                        cmp #input.DOWN
                        bne .checkStart
                        lda selector.CurrentValue
                        clc
                        adc selector.RowLength
                        cmp selector.ItemCount
                        bcs .continue
                        sta selector.NewValue
                        bmi .playSoundAndExit
.checkStart
                        cmp #input.START
                        beq .commit
                        cmp #input.BUTTONA
                        beq .commit
                        lda selector.IsFinal
                        beq .checkBack
                        lda input.lastKey
                        cmp #input.GLITCH
                        bne .checkBack
                        jsr glitch.Start
.commit
                        lda #selector.COMMIT
                        sta selector.NewValue
                        rts
.checkBack
                        lda input.lastInput
                        cmp #input.BACK
                        beq .cancel
                        cmp #input.BUTTONB
                        bne .continue
.cancel
                        lda #selector.CANCEL
                        sta selector.NewValue
                        rts
.continue
                        dec selector.WaitCounter
                        beq .exitLoop
                        jmp .loop
.exitLoop
                        rts
.playSoundAndExit
                        PLAY_SOUND soundEffect.Menu
                        rts
