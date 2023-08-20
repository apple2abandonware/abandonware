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

input.CTRL_MASK         EQU $3F
input.JOY_TRIGGER       EQU 64
input.JOY_SLACK         EQU 16
input.JOY_MIN_DELTA     EQU input.JOY_TRIGGER + input.JOY_SLACK

input.Map               EQU *-1

input.LEFT              EQU *-input.Map      ; input.LEFT/RIGHT/etc. are indexes into input.Map
                        DC.B 'J

input.RIGHT             EQU *-input.Map
                        DC.B 'L

input.UP                EQU *-input.Map
                        DC.B 'I

input.DOWN              EQU *-input.Map
                        DC.B 'K

input.BUTTONA           EQU *-input.Map
input.ROTLEFT           EQU *-input.Map
                        DC.B 'A

input.BUTTONB           EQU *-input.Map
input.ROTRIGHT          EQU *-input.Map
                        DC.B 'S

input.START             EQU *-input.Map
                        DC.B 'M & input.CTRL_MASK

input.BACK              EQU *-input.Map
                        DC.B 27 ;ESC

input.RESET             EQU *-input.Map
                        DC.B 'R & input.CTRL_MASK

input.SOUND             EQU *-input.Map
                        DC.B 'S & input.CTRL_MASK

input.PADDLE            EQU *-input.Map
                        DC.B 'P & input.CTRL_MASK

input.GLITCH            EQU *-input.Map
                        DC.B 'G & input.CTRL_MASK

input.MAPCOUNT          EQU *-input.Map-1

; -----------------------------------------------------------------------------
; input.ReadInput
; -----------------------------------------------------------------------------
; Inputs: none
; Outputs: A = Filtered UI input value

input.ReadInput SUBROUTINE

                        SEG.U DATA
input.lastInput         DS.B 1                  ; Filtered UI input value (keyboard or joystick)
input.lastJoy           DS.B 1                  ; Last joystick input value (unfiltered)
input.lastKey           DS.B 1                  ; Last keyboard input value
input.lastKeyCode       DS.B 1                  ; Last keyboard raw ascii (for high score input)
input.joyCooldown       DS.B 1
                        SEG PROGRAM

                        lda #0
                        sta input.lastInput
                        sta input.lastKey
                        sta input.lastKeyCode

                        lda KBD
                        bpl .checkJoystick         ; bit 7 not set means no key pressed
                        jmp .keyPressed
.checkJoystick
input.joyEnabled_SMC
                        bmi .noJoy              ; bmi ($30) = joystick enabled, bpl ($10) = joystick disabled
.joystickEnabled
                        bit RDBTN0
                        bpl .noButton0
                        lda #input.ROTLEFT
                        cmp input.lastJoy
                        beq .filterOutJoystickInput
                        bne .yesJoy
.noButton0
                        bit BUTN1
                        bpl .noButton1
                        lda #input.ROTRIGHT
                        cmp input.lastJoy
                        beq .filterOutJoystickInput
                        bne .yesJoy
.noButton1
                        ldx #0                  ; Read joystick X-axis (pdl 0)
                        jsr PREAD
                        cpy #[127-input.JOY_TRIGGER]
joystick.minX_SMC       EQU *-1
                        bcs .noJoyLeft
                        lda #input.LEFT
                        bne .yesJoy
.noJoyLeft
                        cpy #[127+input.JOY_TRIGGER]
joystick.maxX_SMC       EQU *-1
                        bcc .noJoyRight
                        lda #input.RIGHT
                        bne .yesJoy
.noJoyRight
                        jsr joystick.WaitPaddle1
                        ldx #1                  ; Read joystick Y-axis (pdl 1)
                        jsr PREAD
                        cpy #[127-input.JOY_TRIGGER]
joystick.minY_SMC       EQU *-1
                        bcs .noJoyUp
                        lda #input.UP
                        bne .yesJoy
.noJoyUp
                        cpy #[127+input.JOY_TRIGGER]
joystick.maxY_SMC       EQU *-1
                        bcc .noJoy
                        lda #input.DOWN
                        bne .yesJoy
.yesJoy
                        cmp input.lastJoy
                        beq .checkCooldown
                        sta input.lastJoy
                        sta input.lastInput
                        ldx #10
                        stx input.joyCooldown
                        rts                     ; Z processor status must be FALSE
.checkCooldown
                        ldx input.joyCooldown
                        beq .joyRepeat
                        dec input.joyCooldown
.filterOutJoystickInput
                        lda #0
                        sta input.lastInput
                        rts
.joyRepeat
                        sta input.lastInput
                        ldx #1
                        stx input.joyCooldown
                        rts                     ; Z processor status must be FALSE
.noJoy
                        lda #0
                        sta input.lastJoy
                        rts
.keyPressed
                        bit KBDSTRB
                        and #$7F
                        cmp #$60                ; Key >= $60?
                        bcc .notLowercase
                        sec
                        sbc #$20
.notLowercase
                        sta input.lastKeyCode
                        ldy #input.MAPCOUNT     ; Prepare to loop through key mappings
.loop                   cmp input.Map,y         ; Check for a match
                        beq .done
                        dey                     ; If no match, decrement and try next mapping
                        bne .loop               ; If index is 0, then there's no match
.done                   tya

                        cmp #input.RESET
                        bne .noReset
                        jmp stateMachine.reset
.noReset
                        cmp #input.SOUND
                        bne .noToggleSound
                        jsr sound.Toggle
                        jmp .ignoreKey
.noToggleSound
                        cmp #input.PADDLE
                        bne .continueWithKey
                        lda input.joyEnabled_SMC
                        eor #$20
                        sta input.joyEnabled_SMC
.ignoreKey
                        lda #0
                        sta input.lastKeyCode
.continueWithKey
                        sta input.lastKey
                        sta input.lastInput
                        rts

; -----------------------------------------------------------------------------
; input.WaitKey
; -----------------------------------------------------------------------------
; Inputs: input.WaitTimer - Number of ticks to wait (0 is indefinite)

input.WaitKey SUBROUTINE
                        SEG.U DATA
input.WaitTimer         DS.B 1
                        SEG PROGRAM

                        sta input.WaitTimer
.readLoop
                        inc zp.RandomSeed
                        jsr input.ReadInput
input.WaitMode_SMC
                        bne .exit               ; bne = $D0, and = $29
                        jsr sound.Tick
                        lda input.WaitTimer
                        beq .readLoop
                        dec input.WaitTimer
                        bne .readLoop
.exit
                        rts

input.Wait SUBROUTINE
                        ldx #$29
                        stx input.WaitMode_SMC
                        jsr input.WaitKey
                        ldx #$D0
                        stx input.WaitMode_SMC
                        rts
