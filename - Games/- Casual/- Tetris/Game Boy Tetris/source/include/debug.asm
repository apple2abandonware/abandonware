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
; debug.WriteValue
; -----------------------------------------------------------------------------

debug.WriteValue SUBROUTINE
                IF debug.INCLUDE_DEBUG = 1
                        sta debug.Value_SMC
                        lda TileX
                        pha
                        lda TileY
                        pha
                        txa
                        pha
                        tya
                        pha

                        jsr debug.HexToString
                        sty .charL
                        sta .charH
                        jsr .write
                        jsr screen.ToggleActive
                        jsr .write
                        jsr screen.ToggleActive

                        pla
                        tay
                        pla
                        tax
                        pla
                        sta TileY
                        pla
                        sta TileX
                        rts
.write
                        jsr debug.WRITE_VALUE
                        WRITE_CHAR_CORE
                        DC.B "$00",EOL
.charH                  EQU *-3
.charL                  EQU *-2
                        rts
                EIF


; -----------------------------------------------------------------------------
; debug.HexToString
; -----------------------------------------------------------------------------
; Inputs: debug.Value_SMC - Byte to convert to ascii hex character code
; Outputs: Y - Low nibble ascii, A - High nibble ascii

debug.HexToString SUBROUTINE
                        lda #$00
debug.Value_SMC         EQU *-1
                        tax
                        and #$0F
                        clc
                        adc #48
                        cmp #58
                        bmi .next
                        adc #6
.next
                        tay
                        txa
                        lsr
                        lsr
                        lsr
                        lsr
                        clc
                        adc #48
                        cmp #58
                        bmi .done
                        adc #6
.done
                        rts


