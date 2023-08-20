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

                        SEG.U DATA

state.playerAlevel      DS.B 1
state.playerBlevel      DS.B 1
state.playerHigh        DS.B 1

state.score             DS.B 3                  ; Max score = 999999 (these are all little-endian, BCD)
state.level             DS.B 1                  ; Max level = 20
state.lines             DS.B 2                  ; Max lines = 9999
state.drops             DS.B 3                  ; Max drops = 999999
state.initialDropDone   DS.B 1                  ; Slow initial drop

state.lineTypeCount
                        DS.B 1                  ; Single line count
                        DS.B 1                  ; Double line count
                        DS.B 1                  ; Triple line count
                        DS.B 1                  ; Tetris line count

                        SEG PROGRAM

state.INITIAL_PAUSE     EQU 45

; ****************************************
; state.initNewGame
; ****************************************

state.initNewGame       SUBROUTINE

                        jsr state.clearBoardData

                        lda #0
                        sta state.score
                        sta state.score+1
                        sta state.score+2
                        sta state.drops
                        sta state.drops+1
                        sta state.drops+2
                        sta state.lineTypeCount
                        sta state.lineTypeCount+1
                        sta state.lineTypeCount+2
                        sta state.lineTypeCount+3
                        sta state.initialDropDone
                        sta zp.SoundIndex

                        sta state.lines+1
                        bit zp.Flags
                        bvc .gameALines
                        lda #$25                 ; Game B lines
.gameALines
                        sta state.lines
                        rts


; ****************************************
; state.clearBoardData
; ****************************************

state.clearBoardData    SUBROUTINE
                        SEG.U ZEROPAGE
.index                  DS.B 1
.y                      DS.B 1
                        SEG PROGRAM

                        SEG.U DATA
.fillRow                DS.B 1
                        SEG PROGRAM

                        bit zp.Flags
                        bvs .gameB
.gameA
                        lda #BOARD_HEIGHT
                        sta .fillRow
                        bne .doFill
.gameB
                        lda state.playerHigh
                        asl
                        sta .fillRow
                        lda #BOARD_HEIGHT
                        sec
                        sbc .fillRow
                        sta .fillRow

.doFill
                        lda #BOARD_LENGTH
                        sta .index
                        lda #BOARD_DATA_HEIGHT
                        sta .y
                        ldx #BOARD_DATA_WIDTH
.loop                   dec .index
                        lda .y
                        cmp #BOARD_DATA_HEIGHT
                        beq .fill
                        cpx #BOARD_DATA_WIDTH
                        beq .fill
                        cpx #1
                        beq .fill
                        lda .fillRow                  ; Fill in random bricks for Game Type B
                        cmp .y
                        bpl .noFill
                        jsr prng.Cycle
                        bpl .noFill
                        clc
                        adc #2
                        and #$0f
                        cmp #14
                        bmi .write
                        lda #$02
                        jmp .write
.noFill
                        lda #$00
                        jmp .write
.fill                   lda #$ff
.write                  ldy .index
                        sta board.DataStart,y
                        dex
                        bne .skip
                        ldx #BOARD_DATA_WIDTH
                        dec .y
.skip                   lda .index
                        bne .loop

                        rts

; ****************************************
; state.reloadBoard
; ****************************************

state.reloadBoard       SUBROUTINE

                        lda #2
                        sta TileX
                        lda #0
                        sta TileY
                        lda #1
                        sta .boardIndex
.refreshOuter           lda #10
                        sta .rowIndex
.refreshLoop            ldy .boardIndex
                        lda board.DataStart,y
                        sta TileNum
                        jsr DrawTile
                        inc TileX
                        inc .boardIndex
                        dec .rowIndex
                        bne .refreshLoop
                        inc .boardIndex
                        inc .boardIndex
                        lda #2
                        sta TileX
                        inc TileY
                        lda TileY
                        cmp #18
                        bne .refreshOuter

                        jsr state.reloadScores

                        rts

.rowIndex               DC.B
.boardIndex             DC.B


; ****************************************
; state.reloadScores
; ****************************************

state.reloadScores      SUBROUTINE

                        jsr digits.WriteLines

                        bit zp.Flags
                        bvs .gameB
.gameA
                        jsr digits.WriteScore
                        jsr digits.WriteALevel
.gameB
                        rts

; -----------------------------------------------------------------------------
; state.SetLevel
; -----------------------------------------------------------------------------
; Inputs: A - New level

state.SetLevel SUBROUTINE
                        SEG.U DATA
points.Tab
points.Single           DS.B 3
points.Double           DS.B 3
points.Triple           DS.B 3
points.Tetris           DS.B 3
                        SEG PROGRAM

                        cmp state.level
                        bne .queueSound
                        rts
.queueSound
                        sta state.queueLevelSound
state.SetLevelCore
                        sta state.level
                        lda #0
                        ldx #11
.clearLoop
                        sta points.Tab,x
                        dex
                        bpl .clearLoop
                        sed
                        ldy state.level
.multiplyLoop
                        ldx #9
.innerLoop
                        clc
                        lda scores.Tab,x
                        adc points.Tab,x
                        sta points.Tab,x
                        lda scores.Tab+1,x
                        adc points.Tab+1,x
                        sta points.Tab+1,x
                        lda scores.Tab+2,x
                        adc points.Tab+2,x
                        sta points.Tab+2,x
                        dex
                        dex
                        dex
                        bpl .innerLoop

                        dey
                        bpl .multiplyLoop

                        cld
                        rts


; -----------------------------------------------------------------------------
; state.CalcSpeed
; -----------------------------------------------------------------------------
; Inputs: state.level
; Outputs: state.speed

state.CalcSpeed SUBROUTINE
                        lda state.level         ; Would it be easier just to have a hex representation of level???
                        lsr                     ; Because look at us...
                        lsr                     ; Shifting bits...
                        lsr                     ; Toiling...
                        lsr                     ; For what?
                        tay                     ; To convert BCD back to a plain old 8-bit number.
                        lda state.level
                        and #$0F
                        clc
.speedCalcLoop
                        dey
                        bmi .endSpeedCalc
                        adc #10
                        jmp .speedCalcLoop
.endSpeedCalc
                        tax
                        lda state.SpeedTab,x
                        sta speed
                        rts

state.SpeedTab          DC.B 30
                        DC.B 27
                        DC.B 25
                        DC.B 22
                        DC.B 20
                        DC.B 17
                        DC.B 15
                        DC.B 11
                        DC.B 9
                        DC.B 7
                        DC.B 7
                        DC.B 6
                        DC.B 6
                        DC.B 5
                        DC.B 5
                        DC.B 5
                        DC.B 4
                        DC.B 4
                        DC.B 3
                        DC.B 3
                        DC.B 2

; -----------------------------------------------------------------------------
; state.TryAddDrops
; -----------------------------------------------------------------------------

state.TryAddDrops SUBROUTINE
                        bit zp.Flags
                        bvs .skipDropTally
                        sed
                        clc
                        lda state.score
                        adc state.drops        ; Game A drops fit into one byte
                        sta state.score
                        lda state.score+1
                        adc #0                 ; So we just disregard the other two
                        sta state.score+1
                        lda state.score+2
                        adc #0
                        sta state.score+2
                        cld

                        lda #0
                        sta state.drops        ; And only reset the one byte
.skipDropTally
                        rts

; ****************************************
; state.updateScores
; ****************************************
; A = lines

state.updateScores      SUBROUTINE

                        SEG.U DATA
state.queueLevelSound   DS.B 1
.clearedLines           DS.B 1
.tempLevel              DS.B 1
                        SEG PROGRAM

                        sta .clearedLines
                        bit zp.Flags
                        bvs .gameB
.gameA
                        asl                     ; Multiple # of lines by 3 for indexing
                        clc
                        adc .clearedLines
                        tay
                        sed
                        clc
                        lda points.Tab-3,y
                        adc state.score
                        sta state.score
                        lda points.Tab+1-3,y
                        adc state.score+1
                        sta state.score+1
                        lda points.Tab+2-3,y
                        adc state.score+2
                        sta state.score+2

                        lda .clearedLines       ; add lines to line counter (game type A)
                        clc
                        adc state.lines
                        sta state.lines
                        sta .tempLevel
                        bcc .checkLevel
                        lda #0
                        adc state.lines+1
                        sta state.lines+1

                        ; Increment level
                        ; level = max(currentLevel, min(floor(lines / 10), 20))
                        ; 0 lines = level 0, 10 lines = level 1, 20 lines = level 2, etc.
                        ; Starting on level > 0 does not increment until lines >= level*10+10
.checkLevel
                        lda #MAX_LEVEL
                        cmp state.level
                        beq .end
                        ldy #4
                        lda state.lines+1
.levelLoop
                        lsr
                        ror .tempLevel
                        dey
                        bne .levelLoop
                        lda .tempLevel
                        cmp state.level
                        bmi .end
                        jsr state.SetLevel
                        cld
                        rts
.gameB
                        tax
                        sed
                        clc
                        lda state.lineTypeCount-1,x
                        adc #$01
                        sta state.lineTypeCount-1,x
                        sec                     ; subtract lines from line counter (game type B)
                        lda state.lines
                        sbc .clearedLines
                        sta state.lines
                        bcs .end                ; don't let it go below 0
                        lda #0
                        sta state.lines

.end
                        cld
                        rts

scores.Tab
                        dc.b $40, $00, $00
                        dc.b $00, $01, $00
                        dc.b $00, $03, $00
                        dc.b $00, $12, $00
