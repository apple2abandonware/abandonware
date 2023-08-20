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

highscore.NAME_LENGTH   EQU 6
highscore.SCORE_LENGTH  EQU 3
highscore.RECORD_SIZE   EQU highscore.NAME_LENGTH + highscore.SCORE_LENGTH
highscore.PAGE_SIZE     EQU 1 + highscore.RECORD_SIZE * 3      ; Three scores per page + "dirty" byte
highscore.BLOCK_SIZE    EQU highscore.PAGE_SIZE * 10           ; Ten pages per block
highscore.GAME_A_BLOCK  EQU highscore.DATA + highscore.BLOCK_SIZE * 6 ; Base address for Game A high score block

highscore.DATA_LENGTH   EQU highscore.BLOCK_SIZE * 7

                        SEG.U TRAILING_DATA
highscore.DATA          DS.B highscore.DATA_LENGTH
highscore.DATA_END
                        SEG PROGRAM

; -----------------------------------------------------------------------------
; highscore.CalcBase
; -----------------------------------------------------------------------------
; Inputs: state.level, state.playerHigh, state.playerAlevel, state.playerBlevel, zp.Flags

highscore.CalcBase SUBROUTINE
                        SEG.U ZEROPAGE
highscore.BaseL         DS.B 1
highscore.BaseH         DS.B 1
highscore.RecordL       DS.B 1
highscore.RecordH       DS.B 1
highscore.RecordCount   DS.B 1
                        SEG PROGRAM

                        bit zp.Flags
                        bvs .gameB
                        lda #<highscore.GAME_A_BLOCK
                        sta highscore.BaseL
                        lda #>highscore.GAME_A_BLOCK
                        sta highscore.BaseH
                        ldx state.playerAlevel
                        jmp .pageIndex
.gameB
                        lda #<highscore.DATA
                        sta highscore.BaseL
                        lda #>highscore.DATA
                        sta highscore.BaseH
                        ldx state.playerHigh
                        beq .skipBlockIndex
.blockLoop
                        clc
                        lda highscore.BaseL
                        adc #<highscore.BLOCK_SIZE
                        sta highscore.BaseL
                        lda highscore.BaseH
                        adc #>highscore.BLOCK_SIZE
                        sta highscore.BaseH
                        dex
                        bne .blockLoop
.skipBlockIndex
                        ldx state.playerBlevel
.pageIndex
                        beq .skipLevelIndex
.pageLoop
                        clc
                        lda highscore.BaseL
                        adc #<highscore.PAGE_SIZE
                        sta highscore.BaseL
                        lda highscore.BaseH
                        adc #>highscore.PAGE_SIZE
                        sta highscore.BaseH
                        dex
                        bne .pageLoop
.skipLevelIndex
                        rts

; -----------------------------------------------------------------------------
; highscore.ResetScores
; -----------------------------------------------------------------------------

highscore.ResetScores SUBROUTINE
                        lda #<highscore.DATA
                        sta highscore.BaseL
                        lda #>highscore.DATA
                        sta highscore.BaseH

                        ldy #0
                        ldx #70
.loop
                        lda #0
                        sta (highscore.BaseL),y
                        clc
                        lda highscore.BaseL
                        adc #<highscore.PAGE_SIZE
                        sta highscore.BaseL
                        lda highscore.BaseH
                        adc #>highscore.PAGE_SIZE
                        sta highscore.BaseH
                        dex
                        bne .loop
                        rts

; -----------------------------------------------------------------------------
; highscore.RenderScores
; -----------------------------------------------------------------------------
; Inputs: state.level, state.playerHigh, state.playerAlevel, state.playerBlevel, zp.Flags

highscore.RenderScores SUBROUTINE
                        SEG.U ZEROPAGE
highscore.TempL         DS.B 1
highscore.TempH         DS.B 1
                        SEG.U DATA
highscore.LastRowCount  DS.B 1
highscore.RowCount      DS.B 1
highscore.Score         DS.B 3
                        SEG PROGRAM

                        lda highscore.LastRowCount
                        beq .skipClear
                        jsr highscore.ClearScoreDisplay
.skipClear
                        jsr highscore.CalcBase
                        ldy #0
                        lda (highscore.BaseL),y
                        sta highscore.LastRowCount
                        sta highscore.RowCount
                        beq .skipRender

                        lda #"%"
                        sta digits.Filler_SMC

                        lda #13
                        sta .tileY_SMC
.rowLoop
                        ldy #6
.charLoop

                        lda #<[.nameStr-1]
                        sta highscore.TempL
                        lda #>[.nameStr-1]
                        sta highscore.TempH

                        lda (highscore.BaseL),y
                        sta (highscore.TempL),y
                        dey
                        bne .charLoop

                        lda #6
                        jsr highscore.IncrementBase
                        lda #<[highscore.Score-1]
                        sta highscore.TempL
                        lda #>[highscore.Score-1]
                        sta highscore.TempH

                        ldy #3
.scoreLoop
                        lda (highscore.BaseL),y
                        sta (highscore.TempL),y
                        dey
                        bne .scoreLoop

                        lda #1
                        sta tiles.WriteMode_SMC
                        lda #4
                        sta TileX
                        lda #13
.tileY_SMC              EQU *-1
                        sta TileY
                        jsr WriteTile
.nameStr                DC.B "------",EOL

                        lda #12
                        sta TileX
                        dec TileY
                        lda #3
                        sta digits.BCDLength
                        lda #<highscore.Score
                        sta digits.BCDAddr
                        lda #>highscore.Score
                        sta digits.BCDAddr+1
                        jsr digits.WriteDigits

                        inc .tileY_SMC
                        lda #3
                        jsr highscore.IncrementBase

                        dec highscore.RowCount
                        bne .rowLoop

                        lda #" "
                        sta digits.Filler_SMC
.skipRender
                        rts

; -----------------------------------------------------------------------------
; highscore.IncrementBase
; -----------------------------------------------------------------------------
; Inputs: A - Number of bytes to increment

highscore.IncrementBase        clc
                        adc highscore.BaseL
                        sta highscore.BaseL
                        lda #0
                        adc highscore.BaseH
                        sta highscore.BaseH
                        rts

; -----------------------------------------------------------------------------
; highscore.IncrementRecord
; -----------------------------------------------------------------------------
; Inputs: A - Number of bytes to increment

highscore.IncrementRecord
                        clc
                        adc highscore.RecordL
                        sta highscore.RecordL
                        lda #0
                        adc highscore.RecordH
                        sta highscore.RecordH
                        rts

; -----------------------------------------------------------------------------
; highscore.ClearScoreDisplay
; -----------------------------------------------------------------------------

highscore.ClearScoreDisplay SUBROUTINE
                        WRITE_CHAR 4,13
                        INCLUDE "__char_clear_scores.asm"
                        rts

; -----------------------------------------------------------------------------
; highscore.PrepForEntry
; -----------------------------------------------------------------------------

highscore.PrepForEntry SUBROUTINE
                        SEG.U DATA
.rowsToShift            DS.B 1
                        SEG PROGRAM

                        jsr highscore.CheckEligibility
                        bcs .eligible
                        rts
.eligible
                        ldy #0                  ; Increment dirty byte if not 3 rows
                        lda (highscore.BaseL),y
                        cmp #3
                        beq .alreadyThree
                        clc
                        lda (highscore.BaseL),y
                        adc #1
                        sta (highscore.BaseL),y
.alreadyThree
                        sec                     ; Determine number of rows to shift
                        lda #2
                        sbc highscore.InsertRow
                        sta .rowsToShift
                        beq .shiftNotNeeded

                                                ; highscore.InsertRow = 0-2
                                                ; highscore.RecordL = Start of first record to shift - 1

                        lda highscore.RecordL   ; Prepare for copy
                        sta copy.SrcL
                        lda highscore.RecordH
                        sta copy.SrcH

                        inc copy.SrcL
                        bne .noCarry
                        inc copy.SrcH
.noCarry
                        lda copy.SrcL
                        sta copy.DestL
                        lda copy.SrcH
                        sta copy.DestH

                        clc
                        lda #highscore.RECORD_SIZE
                        adc copy.DestL
                        sta copy.DestL
                        lda #0
                        adc copy.DestH
                        sta copy.DestH

                        lda #0
                        ldx .rowsToShift
.shiftLoop
                        adc #highscore.RECORD_SIZE
                        dex
                        bne .shiftLoop

                        sta copy.SizeL
                        lda #0
                        sta copy.SizeH

                        jsr copy.MoveUp              ; Shift records down
.shiftNotNeeded
                        ldy #highscore.RECORD_SIZE
                        lda state.score+2
                        sta (highscore.RecordL),y
                        dey
                        lda state.score+1
                        sta (highscore.RecordL),y
                        dey
                        lda state.score
                        sta (highscore.RecordL),y

                        lda #'%
                        ldy #6
.fillLoop
                        sta (highscore.RecordL),y
                        dey
                        bne .fillLoop
.end
                        sec
                        rts


; -----------------------------------------------------------------------------
; highscore.CheckEligibility
; -----------------------------------------------------------------------------

highscore.CheckEligibility SUBROUTINE
                        SEG.U DATA
highscore.InsertRow     DS.B 1
.recordCount            DS.B 1
                        SEG PROGRAM

                        jsr highscore.CalcBase  ; Prepare to examine stored scores

                        ldy #0
                        sty highscore.InsertRow
                        lda (highscore.BaseL),y
                        sta highscore.RecordCount
                        sta .recordCount

                        lda state.score         ; Is the score zero?
                        ora state.score+1
                        ora state.score+2
                        beq .ineligible

                        lda highscore.BaseL
                        sta highscore.RecordL
                        lda highscore.BaseH
                        sta highscore.RecordH

                        lda highscore.RecordCount
                        beq .eligible
.compareNextScore
                        ldy #highscore.RECORD_SIZE   ; This counts on Base being 1 less than the record start
                        lda (highscore.RecordL),y
                        cmp state.score+2
                        bne .decide
                        dey
                        lda (highscore.RecordL),y
                        cmp state.score+1
                        bne .decide
                        dey
                        lda (highscore.RecordL),y
                        cmp state.score
.decide
                        bcc .eligible
                        inc highscore.InsertRow
                        lda #highscore.RECORD_SIZE
                        jsr highscore.IncrementRecord
                        dec .recordCount
                        bne .compareNextScore

                        lda highscore.InsertRow
                        cmp #3
                        bne .eligible
.ineligible
                        clc
                        rts
.eligible
                        sec
                        rts