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

select.music            SUBROUTINE

                        lda zp.Flags
                        and #flags.MUSIC_MASK
                        sta selector.CurrentValue
                        sta selector.NewValue
                        lda #4
                        sta selector.ItemCount
                        lda #2
                        sta selector.RowLength
                        lda #0
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
                        lda zp.Flags
                        and #-flags.MUSIC_MASK-1
                        ora selector.NewValue
                        sta zp.Flags
                        lda selector.NewValue
                        sta selector.CurrentValue
                        jsr music.StartGameTune
                        jmp .blinkLoop

select.refreshMusicType
.drawSelection
                        lda zp.Flags
                        and #flags.MUSIC_MASK
                        tax
                        beq .drawOption1
                        dex
                        beq .drawOption2
                        dex
                        beq .drawOption3
                        jmp .drawOption4
.drawOption1
                        WRITE_CHAR 2,11
                        INCLUDE "__char_select_music_a_on.asm"
                        rts
.drawOption2
                        WRITE_CHAR 10,11
                        INCLUDE "__char_select_music_b_on.asm"
                        rts
.drawOption3
                        WRITE_CHAR 2,13
                        INCLUDE "__char_select_music_c_on.asm"
                        rts
.drawOption4
                        WRITE_CHAR 10,13
                        INCLUDE "__char_select_music_off_on.asm"
                        rts

.clearSelection
                        ldx selector.CurrentValue
                        beq .clearOption1
                        dex
                        beq .clearOption2
                        dex
                        beq .clearOption3
                        jmp .clearOption4
.clearOption1
                        WRITE_CHAR 2,11
                        INCLUDE "__char_select_music_a_off.asm"
                        rts
.clearOption2
                        WRITE_CHAR 10,11
                        INCLUDE "__char_select_music_b_off.asm"
                        rts
.clearOption3
                        WRITE_CHAR 2,13
                        INCLUDE "__char_select_music_c_off.asm"
                        rts
.clearOption4
                        WRITE_CHAR 10,13
                        INCLUDE "__char_select_music_off_off.asm"
                        rts
