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
; select.level
; -----------------------------------------------------------------------------
; Inputs: none

select.level SUBROUTINE
                        jsr .calcOffset

                        lda #10
                        sta selector.ItemCount
                        lda #5
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
                        bit zp.Flags
                        bvs .storeBlevel
                        sta state.playerAlevel
                        jsr highscore.RenderScores
                        jmp .blinkLoop
.storeBlevel
                        sta state.playerBlevel
                        jsr highscore.RenderScores
                        jmp .blinkLoop
select.refreshLevel
                        jsr .calcOffset
.drawSelection
                        lda selector.CurrentValue
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
                        dc.w .drawOption6
                        dc.w .drawOption7
                        dc.w .drawOption8
                        dc.w .drawOption9

.drawOption0
                        WRITE_CHAR_OFFSET 0,5
                        INCLUDE "__char_level_0_on.asm"
                        rts
.drawOption1
                        WRITE_CHAR_OFFSET 2,5
                        INCLUDE "__char_level_1_on.asm"
                        rts
.drawOption2
                        WRITE_CHAR_OFFSET 4,5
                        INCLUDE "__char_level_2_on.asm"
                        rts
.drawOption3
                        WRITE_CHAR_OFFSET 6,5
                        INCLUDE "__char_level_3_on.asm"
                        rts
.drawOption4
                        WRITE_CHAR_OFFSET 8,5
                        INCLUDE "__char_level_4_on.asm"
                        rts
.drawOption5
                        WRITE_CHAR_OFFSET 0,7
                        INCLUDE "__char_level_5_on.asm"
                        rts
.drawOption6
                        WRITE_CHAR_OFFSET 2,7
                        INCLUDE "__char_level_6_on.asm"
                        rts
.drawOption7
                        WRITE_CHAR_OFFSET 4,7
                        INCLUDE "__char_level_7_on.asm"
                        rts
.drawOption8
                        WRITE_CHAR_OFFSET 6,7
                        INCLUDE "__char_level_8_on.asm"
                        rts
.drawOption9
                        WRITE_CHAR_OFFSET 8,7
                        INCLUDE "__char_level_9_on.asm"
                        rts

.clearSelection
                        lda selector.CurrentValue
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
                        dc.w .clearOption6
                        dc.w .clearOption7
                        dc.w .clearOption8
                        dc.w .clearOption9
.clearOption0
                        WRITE_CHAR_OFFSET 0,5
                        INCLUDE "__char_level_0_off.asm"
                        rts
.clearOption1
                        WRITE_CHAR_OFFSET 2,5
                        INCLUDE "__char_level_1_off.asm"
                        rts
.clearOption2
                        WRITE_CHAR_OFFSET 4,5
                        INCLUDE "__char_level_2_off.asm"
                        rts
.clearOption3
                        WRITE_CHAR_OFFSET 6,5
                        INCLUDE "__char_level_3_off.asm"
                        rts
.clearOption4
                        WRITE_CHAR_OFFSET 8,5
                        INCLUDE "__char_level_4_off.asm"
                        rts
.clearOption5
                        WRITE_CHAR_OFFSET 0,7
                        INCLUDE "__char_level_5_off.asm"
                        rts
.clearOption6
                        WRITE_CHAR_OFFSET 2,7
                        INCLUDE "__char_level_6_off.asm"
                        rts
.clearOption7
                        WRITE_CHAR_OFFSET 4,7
                        INCLUDE "__char_level_7_off.asm"
                        rts
.clearOption8
                        WRITE_CHAR_OFFSET 6,7
                        INCLUDE "__char_level_8_off.asm"
                        rts
.clearOption9
                        WRITE_CHAR_OFFSET 8,7
                        INCLUDE "__char_level_9_off.asm"
                        rts

.calcOffset
                        bit zp.Flags
                        bvs .gameB
                        ldx state.playerAlevel
                        lda #4
                        bne .offsetDone         ; Unconditional
.gameB
                        lda #1
                        ldx state.playerBlevel
.offsetDone
                        sta kernel.horzOffset
                        stx selector.CurrentValue
                        stx selector.NewValue
                        rts

