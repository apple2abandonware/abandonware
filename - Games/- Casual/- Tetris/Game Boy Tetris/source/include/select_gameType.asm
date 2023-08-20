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

select.gameType         SUBROUTINE

                        ldx #0
                        stx selector.IsFinal
                        bit zp.Flags
                        bvc .notGameTypeA
                        ldx #1
.notGameTypeA
                        stx selector.CurrentValue
                        stx selector.NewValue
                        lda #2
                        sta selector.RowLength
                        sta selector.ItemCount

.flashGameType
                        jsr .drawTypeSelection
                        jsr selector.WaitKey
                        lda selector.NewValue
                        bmi .done
                        cmp selector.CurrentValue
                        bne .change
                        jsr .clearTypeSelection
                        jsr selector.WaitKey
                        lda selector.NewValue
                        bmi .done
                        cmp selector.CurrentValue
                        bne .change
                        jmp .flashGameType

.done
                        jsr .drawTypeSelection
                        rts

.change
                        jsr .clearTypeSelection
                        lda selector.NewValue
                        sta selector.CurrentValue
                        bne .setGameB
                        state:gameType= "A"
                        jmp .flashGameType
.setGameB
                        state:gameType= "B"
                        jmp .flashGameType

.drawTypeSelection
                        lda selector.CurrentValue
                        bne .drawGameTypeB
.drawGameTypeA
                        WRITE_CHAR 2,4
                        INCLUDE "__char_select_game_a_on.asm"
                        rts
.drawGameTypeB
                        WRITE_CHAR 10,4
                        INCLUDE "__char_select_game_b_on.asm"
                        rts

.clearTypeSelection
                        lda selector.CurrentValue
                        bne .clearGameTypeB
.clearGameTypeA
                        WRITE_CHAR 2,4
                        INCLUDE "__char_select_game_a_off.asm"
                        rts
.clearGameTypeB
                        WRITE_CHAR 10,4
                        INCLUDE "__char_select_game_b_off.asm"
                        rts
