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
; state.rockets
; -----------------------------------------------------------------------------
; Inputs: none

state.rockets SUBROUTINE
                        PREVIOUS_STATE= nil
                        NEXT_STATE= scoreTally

                MAC SETUP_ROCKET
.addr                   EQU view.Draw{1}
.x                      EQU {2}
.y                      EQU {3}
.top                    EQU {4}
                        ldx #<.addr
                        stx rockets.drawSub_SMC
                        ldx #>.addr
                        stx rockets.drawSub_SMC+1
                        ldx #.x
                        ldy #.y
                        lda #.top
                        jsr rockets.PrepRocket
                ENDM

                        bit zp.Flags
                        bvs .gameB
                        lda #2
                        sta .animDelay_SMC
                        lda state.score+2
                        cmp #$20
                        bcs .bigRocket
                        cmp #$15
                        bcs .mediumRocket
                        cmp #$10
                        bcs .smallRocket
                        rts
.gameB
                        lda #1
                        sta .animDelay_SMC
                        lda state.playerBlevel
                        cmp #9
                        bne .noRocket
                        lda state.playerHigh
                        cmp #5
                        bne .noRocket
                        lda state.lines
                        beq .buranShuttle
.noRocket
                        rts
.smallRocket
                        SETUP_ROCKET SmallRocket, 9, 9, -6
                        jmp .wait
.mediumRocket
                        SETUP_ROCKET MediumRocket, 9, 8, -7
                        jmp .wait
.bigRocket
                        SETUP_ROCKET BigRocket, 9, 6, -9
                        jmp .wait
.buranShuttle
                        SETUP_ROCKET BuranShuttle, 8, 5, -11
.wait
                        lda #rocket.DRAW_DUST
                        jsr view.DrawSomeRocket

                        START_TUNE rocket
                        CLEAR_KEYS
                        WAIT_KEY 50
                        bne .cleanup

                        jsr rockets.BlinkDust
                        bne .cleanup
                        bit zp.Flags
                        bvc .noBigDust

                        lda #rocket.DRAW_BIGDUST
                        jsr view.DrawSomeRocket
                        jsr rockets.BlinkDust
                        bne .cleanup
.noBigDust

                        lda #rocket.DRAW_NODUST
                        jsr view.DrawSomeRocket
.outerShiftLoop
                        lda #7
.verticalShift_SMC      EQU *-1
                        sta kernel.vShift
.shiftLoop
                        lda #0
rockets.x_SMC           EQU *-1
                        sta TileX
                        lda #0
rockets.y_SMC           EQU *-1
                        sta TileY
                        lda #rocket.DRAW_FULL
                        jsr view.DrawSomeRocket
                        jsr screen.Toggle
                        lda #2
.animDelay_SMC          EQU *-1
                        jsr input.WaitKey
                        bne .cleanup
                        dec kernel.vShift
                        bmi .bigShift
                        jmp .shiftLoop
.bigShift
                        dec rockets.y_SMC
                        lda rockets.y_SMC
                        cmp #0
rockets.top_SMC         EQU *-1
                        bmi .offscreen
                        jmp .outerShiftLoop
.offscreen
                        WAIT_KEY 20
                        bne .cleanup
                        bit zp.Flags
                        bvc .cleanup
                        jsr rockets.Congratulations
.cleanup
                        jsr screen.ShowActive
                        jsr screen.ToggleActive
                        jsr rockets.Cleanup

                        STOP_TUNE a
                        rts

; -----------------------------------------------------------------------------
; rockets.Cleanup
; -----------------------------------------------------------------------------

rockets.Cleanup SUBROUTINE
                        lda #0
                        sta kernel.vShift
                        lda #20
                        sta kernel.maxY
                        rts

; -----------------------------------------------------------------------------
; rockets.BlinkDust
; -----------------------------------------------------------------------------

rockets.BlinkDust SUBROUTINE
                        SEG.U DATA
.dustCounter
                        SEG PROGRAM

                        lda #26
                        sta .dustCounter
.dustLoop
                        WAIT_KEY 3
                        bne .endBlink
                        jsr screen.Toggle
                        dec .dustCounter
                        bne .dustLoop
.endBlink
                        rts

; -----------------------------------------------------------------------------
; rockets.Congratulations
; -----------------------------------------------------------------------------

rockets.Congratulations SUBROUTINE
                        SEG.U DATA
.index                  DS.B 1
                        SEG PROGRAM

                        jsr rockets.Cleanup
                        ldx #0
                        stx .index
                        jsr screen.ShowActive
.loop
                        ldx .index
                        lda .congratsString,x
                        beq .doneDrawing
                        sta .char_SMC
                        inx
                        inx
                        stx TileX
                        lda #4
                        sta TileY
                        WRITE_CHAR_CORE
                        DC.B "C",CRLF,"/",EOL
.char_SMC               EQU *-4
                        WAIT_KEY 2
                        bne .exit
                        inc .index
                        bne .loop
.doneDrawing
                        WAIT_KEY 100
.exit
                        rts

.congratsString         DC.B "CONGRATULATIONS!",0

; -----------------------------------------------------------------------------
; rockets.PrepRocket
; -----------------------------------------------------------------------------

rockets.PrepRocket SUBROUTINE
                        stx rockets.x_SMC
                        sty rockets.y_SMC
                        sta rockets.top_SMC
                        bit zp.Flags
                        bvs .gameB
                        jsr view.DrawRocketBackground
                        jsr screen.ToggleActive
                        lda #14
                        sta kernel.maxY
                        jsr .drawRocket
                        jsr screen.ToggleActive
                        jmp .drawRocket
.drawRocket
                        ldx rockets.x_SMC
                        stx TileX
                        ldx rockets.y_SMC
                        inx
                        stx TileY
                        lda #rocket.DRAW_FULL
                        jsr view.DrawSomeRocket
                        rts

.gameB
                        jsr view.DrawBuranBackground
                        lda #14
                        sta kernel.maxY
                        rts
