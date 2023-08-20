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
; joystick.Calibrate
; -----------------------------------------------------------------------------

joystick.Calibrate SUBROUTINE
joystick.data           EQU $2000
joystick.median         EQU joystick.data+$7F

                        SEG.U DATA
joystick.maxX
                        SEG PROGRAM

                        ldx #0
                        jsr PREAD
                        iny
                        bne .joystickPresent
                        ldx #1
                        jsr PREAD
                        iny
                        bne .joystickPresent
.noJoystick
                        lda #$10                ; Self-modifying code $10 = bpl
                        sta input.joyEnabled_SMC
                        jmp .continue
.joystickPresent
.calibrate
                        lda #0
                        sta .joy_SMC
.axisLoop
                        lda #0
                        sta .index_SMC
.sampleLoop
                        ldx #0
.joy_SMC                EQU *-1
                        jsr PREAD
                        ldx #$00
.index_SMC              EQU *-1
                        tya
                        sta joystick.data,x
                        inc .index_SMC
                        bne .sampleLoop
.sort
                        ldx #$00
.outerSort
                        txa
                        tay
                        iny
                        lda joystick.data,x
.innerSort
                        cmp joystick.data,y
                        bmi .noSwap
                        pha
                        lda joystick.data,y
                        sta joystick.data,x
                        pla
                        sta joystick.data,y
.noSwap
                        iny
                        bne .innerSort
                        inx
                        cpx #$FF
                        bne .outerSort
.setRanges
                        lda joystick.median
                        ldx .joy_SMC
                        bne .setYrange
                        sec
                        sbc #input.JOY_MIN_DELTA
                        bcc .error
                        clc
                        adc #input.JOY_SLACK
                        sta joystick.minX_SMC
                        lda joystick.median
                        clc
                        adc #input.JOY_MIN_DELTA
                        bcs .error
                        sec
                        sbc #input.JOY_SLACK
                        sta joystick.maxX_SMC
                        ;sec
                        bcs .nextAxis
.setYrange
                        sec
                        sbc #input.JOY_MIN_DELTA
                        bcc .error
                        clc
                        adc #input.JOY_SLACK
                        sta joystick.minY_SMC
                        lda joystick.median
                        clc
                        adc #input.JOY_MIN_DELTA
                        bcs .error
                        sec
                        sbc #input.JOY_SLACK
                        sta joystick.maxY_SMC
.nextAxis
                        inc .joy_SMC
                        lda .joy_SMC
                        cmp #2
                        beq .continue
                        jsr joystick.WaitPaddle1
                        jmp .axisLoop
.continue
                        rts

.error
                        PRINT "CENTER JOYSTICK AND PRESS BUTTON 0"
                        PRINT "OR PRESS ESCAPE FOR KEYBOARD"
                        bit KBDSTRB
.waitLoop
                        lda KBD
                        cmp #27 + $80
                        beq .keyboardOnly
.checkButton
                        bit RDBTN0
                        bpl .waitLoop
                        jsr MON_HOME
                        jmp .calibrate
.keyboardOnly
                        jsr MON_HOME
                        lda #$10                ; Self-modifying code $10 = bpl
                        sta input.joyEnabled_SMC
                        rts


joystick.WaitPaddle1 SUBROUTINE
                        ldx #0
.dischargeLoop
                        lda PADDL1
                        bpl .pdlLow
                        dex
                        bne .dischargeLoop
.pdlLow
                        rts
