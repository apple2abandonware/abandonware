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

select.high             SUBROUTINE

                        lda state.playerHigh
                        sta selector.CurrentValue
                        sta selector.NewValue
                        lda #6
                        sta selector.ItemCount
                        lda #3
                        sta selector.RowLength
                        sta selector.IsFinal
.blinkLoop
                        jsr .drawSelection
                        jsr selector.WaitKey
                        lda selector.NewValue
                        bmi .done
                        cmp selector.CurrentValue
                        bne .change
                        jsr .clearSelection
                        jsr selector.WaitKey
                        lda selector.NewValue
                        bmi .done
                        cmp selector.CurrentValue
                        bne .change
                        jmp .blinkLoop

.done
                        jsr .drawSelection
                        rts

.change
                        jsr .clearSelection
                        lda selector.NewValue
                        sta selector.CurrentValue
                        sta state.playerHigh
                        jsr highscore.RenderScores
                        jmp .blinkLoop

select.refreshHigh
.drawSelection
                        lda state.playerHigh
                        asl
                        clc
                        adc #<.drawTable
                        sta .drawTable-2
                        lda #0
                        adc #>.drawTable
                        sta .drawTable-1
                        jmp (.drawTable)
.drawTable
                        dc.w .drawOption0
                        dc.w .drawOption1
                        dc.w .drawOption2
                        dc.w .drawOption3
                        dc.w .drawOption4
                        dc.w .drawOption5

.drawOption0
                        WRITE_CHAR 12,5
                        INCLUDE "__char_high_0_on.asm"
                        rts
.drawOption1
                        WRITE_CHAR 14,5
                        INCLUDE "__char_high_1_on.asm"
                        rts
.drawOption2
                        WRITE_CHAR 16,5
                        INCLUDE "__char_high_2_on.asm"
                        rts
.drawOption3
                        WRITE_CHAR 12,7
                        INCLUDE "__char_high_3_on.asm"
                        rts
.drawOption4
                        WRITE_CHAR 14,7
                        INCLUDE "__char_high_4_on.asm"
                        rts
.drawOption5
                        WRITE_CHAR 16,7
                        INCLUDE "__char_high_5_on.asm"
                        rts

.clearSelection
                        lda state.playerHigh
                        asl
                        clc
                        adc #<.clearTable
                        sta .clearTable-2
                        lda #0
                        adc #>.clearTable
                        sta .clearTable-1
                        jmp (.clearTable)
.clearTable
                        dc.w .clearOption0
                        dc.w .clearOption1
                        dc.w .clearOption2
                        dc.w .clearOption3
                        dc.w .clearOption4
                        dc.w .clearOption5

.clearOption0
                        WRITE_CHAR 12,5
                        INCLUDE "__char_high_0_off.asm"
                        rts
.clearOption1
                        WRITE_CHAR 14,5
                        INCLUDE "__char_high_1_off.asm"
                        rts
.clearOption2
                        WRITE_CHAR 16,5
                        INCLUDE "__char_high_2_off.asm"
                        rts
.clearOption3
                        WRITE_CHAR 12,7
                        INCLUDE "__char_high_3_off.asm"
                        rts
.clearOption4
                        WRITE_CHAR 14,7
                        INCLUDE "__char_high_4_off.asm"
                        rts
.clearOption5
                        WRITE_CHAR 16,7
                        INCLUDE "__char_high_5_off.asm"
                        rts
