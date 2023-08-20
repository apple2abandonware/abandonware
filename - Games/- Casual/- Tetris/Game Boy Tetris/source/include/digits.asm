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
; digits.WriteDigits
; -----------------------------------------------------------------------------
; Inputs:

digits.WriteDigits SUBROUTINE

digits.BCDLength        EQU .byteIndex_SMC

                        lda digits.BCDLength
                        asl
                        sta digits.Count
                        dec digits.BCDLength
                        lda #0                  ; Draw nothing until we get to a non-zero digit
                        sta digits.LastNonZero_SMC
.byteLoop
                        ldy #0
.byteIndex_SMC          EQU *-1

                        lda (digits.BCDAddr),y
                        lsr
                        lsr
                        lsr
                        lsr
                        jsr digits.Write
                        ldy .byteIndex_SMC
                        lda (digits.BCDAddr),y
                        and #%00001111
                        jsr digits.Write
                        dec .byteIndex_SMC
                        bpl .byteLoop
                        rts

; -----------------------------------------------------------------------------
; digits.Write
; -----------------------------------------------------------------------------
; Inputs: A - BCD low nibble

digits.Write SUBROUTINE
                        SEG.U DATA
digits.Count            DS.B 1
digits.LeftAligned      DS.B 1
                        SEG PROGRAM

                        bne .nonZero
.isZero
                        ldx #0                  ; Compare to last non-zero value (self-modifying)
digits.LastNonZero_SMC  EQU *-1
                        bne .drawDigit
                        dec digits.Count
                        beq .drawDigit
                        ldx digits.LeftAligned
                        beq .padding
                        rts
.padding
                        ldx #" "
digits.Filler_SMC       EQU *-1
                        jmp .drawWhatever
.nonZero
                        sta digits.LastNonZero_SMC
.drawDigit
                        clc
                        adc #"0"
                        tax
.drawWhatever
                        lda char.TabL,x
                        sta zp.TileL
                        lda char.TabH,x
                        sta zp.TileH
                        jsr DrawTileCore
                        lda #0
digits.UseBothPages_SMC EQU *-1
                        beq .skipDigit
                        lda #%10000000
                        eor zp.Flags
                        sta zp.Flags
                        jsr DrawTileCore
                        lda #%10000000
                        eor zp.Flags
                        sta zp.Flags
.skipDigit
                        inc TileX
                        rts

; -----------------------------------------------------------------------------
; digits.WriteScore
; -----------------------------------------------------------------------------
; Inputs: state.score

digits.WriteScore SUBROUTINE
                        WRITE_DIGITS state.score, 3, 13, 3, 1
                        rts

; -----------------------------------------------------------------------------
; digits.WriteScoreTally
; -----------------------------------------------------------------------------
; Inputs: state.lines

digits.WriteScoreTally SUBROUTINE
                        WRITE_DIGITS state.score, 3, 5, 17, 0
                        rts

; -----------------------------------------------------------------------------
; digits.WriteALevel
; -----------------------------------------------------------------------------
; Inputs: state.level

digits.WriteALevel SUBROUTINE
                        WRITE_DIGITS state.level, 1, 16, 7, 1
                        rts

; -----------------------------------------------------------------------------
; digits.WriteBLevel
; -----------------------------------------------------------------------------
; Inputs: state.playerBlevel

digits.WriteBLevel SUBROUTINE
                        WRITE_DIGITS state.playerBlevel, 1, 15, 2, 0
                        rts

; -----------------------------------------------------------------------------
; digits.WriteHigh
; -----------------------------------------------------------------------------
; Inputs: state.playerHigh

digits.WriteHigh SUBROUTINE
                        WRITE_DIGITS state.playerHigh, 1, 15, 5, 0
                        rts

; -----------------------------------------------------------------------------
; digits.WriteLines
; -----------------------------------------------------------------------------
; Inputs: state.lines

digits.WriteLines SUBROUTINE
                        WRITE_DIGITS state.lines, 2, 14, 10, 1
                        rts
