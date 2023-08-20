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
; state.scoreTally
; -----------------------------------------------------------------------------
; Inputs: none

state.scoreTally SUBROUTINE
                        PREVIOUS_STATE= nil
                        NEXT_STATE= highScore

                        SEG.U DATA
.count                  DS.B 1
.subTotal               DS.B 3
.dropCount              EQU .subTotal
                        SEG PROGRAM

                        bit zp.Flags
                        bvs .gameB
                        rts             ; Game A doesn't show scoreTally, so jump right to the high score screen
.gameB
                        lda state.lines
                        beq .continue
                        rts
.continue
                        STOP_TUNE a

                        jsr view.DrawGameUI
                        jsr view.ClearPreviewWindow
                        jsr screen.Toggle
                        jsr screen.ToggleActive

                        SET_WRITE_DIRECTION_UP
                        WRITE_CHAR 2, 17
                        INCLUDE "__char_score_flip.asm"
                        SET_WRITE_DIRECTION_DOWN

                        jsr .drawPoints
                        WAIT 60
                        jsr .tally
                        jsr .drops
                        jsr screen.ToggleActive

                        CLEAR_KEYS
                        WAIT_KEY 0
                        rts

.drawPoints
                        lda #1
                        sta digits.LeftAligned

                        lda #10
                        sta .pointsY_SMC

                        lda #9
                        sta .pointsOffset_SMC
.drawPointsLoop
                        lda #7
                        sta TileX
                        lda #1
.pointsY_SMC            EQU *-1
                        sta TileY
                        lda #3
                        sta digits.BCDLength
                        lda #0
.pointsOffset_SMC       equ *-1
                        clc
                        adc #<points.Tab
                        sta digits.BCDAddr
                        lda #0
                        adc #>points.Tab
                        sta digits.BCDAddr+1
                        jsr digits.WriteDigits

                        ldx #3
.decLoop
                        dec .pointsY_SMC
                        dec .pointsOffset_SMC
                        dex
                        bne .decLoop
                        lda .pointsOffset_SMC
                        bpl .drawPointsLoop

                        lda #0
                        sta digits.LeftAligned
                        rts

.tally
                        SEG.U DATA
.tallyMax               DS.B
                        SEG PROGRAM

                        lda #0
                        sta .tallyOffset_SMC
                        sta .pointsTabOffset_SMC
                        lda #1
                        sta .countY_SMC
                        lda #2
                        sta .subTotalY_SMC

.tallyLoop
                        ldx #0
.tallyOffset_SMC        EQU *-1
                        lda state.lineTypeCount,x
                        beq .skipTally
                        sta .tallyMax
                        jsr .animate
.skipTally
                        ldx #3
.decLoop2
                        inc .countY_SMC
                        inc .subTotalY_SMC
                        inc .pointsTabOffset_SMC
                        dex
                        bne .decLoop2

                        inc .tallyOffset_SMC
                        lda .tallyOffset_SMC
                        cmp #4
                        bne .tallyLoop

                        rts

.animate
                        lda #0
                        sta .count
                        sta .subTotal
                        sta .subTotal+1
                        sta .subTotal+2

                        lda #0
                        sta digits.UseBothPages_SMC

.animationLoop
                        jsr sound.Tick
                        sed
                        clc
                        lda #1
                        adc .count
                        sta .count

                        clc
                        ldx #0
.pointsTabOffset_SMC    EQU *-1
                        lda points.Tab,x
                        adc .subTotal
                        sta .subTotal
                        lda points.Tab+1,x
                        adc .subTotal + 1
                        sta .subTotal + 1
                        lda points.Tab+2,x
                        adc .subTotal + 2
                        sta .subTotal + 2

                        clc
                        lda points.Tab,x
                        adc state.score
                        sta state.score
                        lda points.Tab+1,x
                        adc state.score + 1
                        sta state.score + 1
                        lda points.Tab+2,x
                        adc state.score + 2
                        sta state.score + 2
                        cld

                        lda #2
                        sta TileX
                        lda #1
.countY_SMC             EQU *-1
                        sta TileY
                        lda #1
                        sta digits.BCDLength
                        lda #<.count
                        sta digits.BCDAddr
                        lda #>.count
                        sta digits.BCDAddr+1
                        jsr digits.WriteDigits

                        lda #5
                        sta TileX
                        lda #2
.subTotalY_SMC          EQU *-1
                        sta TileY
                        lda #3
                        sta digits.BCDLength
                        lda #<.subTotal
                        sta digits.BCDAddr
                        lda #>.subTotal
                        sta digits.BCDAddr+1
                        jsr digits.WriteDigits

                        jsr digits.WriteScoreTally

                        PLAY_SOUND soundEffect.Score
                        WAIT 2

                        lda .tallyMax
                        cmp .count
                        beq .endTallyAnimation
                        jmp .animationLoop
.endTallyAnimation
                        WAIT 25
                        rts

.drops
                        lda #0
                        sta .dropCount
                        sta .dropCount+1
                        sta .dropCount+2

                        lda state.drops
                        ora state.drops+1
                        ora state.drops+2
                        bne .loopDrops
                        rts

.loopDrops

                        jsr .dropMath

                        lda state.drops
                        ora state.drops+1
                        ora state.drops+2
                        beq .endDrops

                        jsr .dropMath

                        jsr .drawDropCount

                        PLAY_SOUND soundEffect.Score
                        jsr sound.Tick

                        lda state.drops
                        ora state.drops+1
                        ora state.drops+2
                        bne .loopDrops
.endDrops
                        jsr .drawDropCount
                        rts

.dropMath
                        sed
                        sec
                        lda state.drops
                        sbc #1
                        sta state.drops
                        lda state.drops+1
                        sbc #0
                        sta state.drops+1
                        lda state.drops+2
                        sbc #0
                        sta state.drops+2

                        clc
                        lda .dropCount
                        adc #1
                        sta .dropCount
                        lda .dropCount+1
                        adc #0
                        sta .dropCount+1
                        lda .dropCount+2
                        adc #0
                        sta .dropCount+2

                        clc
                        lda state.score
                        adc #1
                        sta state.score
                        lda state.score+1
                        adc #0
                        sta state.score+1
                        lda state.score+2
                        adc #0
                        sta state.score+2
                        cld
                        rts

.drawDropCount
tmpDropCount            EQU .dropCount
                        WRITE_DIGITS tmpDropCount, 3, 5, 13, 0
                        jsr digits.WriteScoreTally
                        rts
