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
; view.DrawBuranBackground
; -----------------------------------------------------------------------------

view.DrawBuranBackground SUBROUTINE
                        jsr .draw
                        jsr .draw
                        rts
.draw
                        WRITE_GFX 0,0
                        INCLUDE "__gfx_buran_bg.asm"
                        jsr screen.Toggle
                        rts

; -----------------------------------------------------------------------------
; view.DrawRocketBackground
; -----------------------------------------------------------------------------

view.DrawRocketBackground SUBROUTINE
                        jsr .draw
                        jsr .draw
                        rts
.draw
                        WRITE_GFX 0,0
                        INCLUDE "__gfx_rocket_bg.asm"
                        jsr screen.Toggle
                        rts

; -----------------------------------------------------------------------------
; view.DrawSomeRocket
; -----------------------------------------------------------------------------
; Inputs: Set A to one of the following immediately before jumping here.

rocket.DRAW_FULL        EQU 0
rocket.DRAW_DUST        EQU 1
rocket.DRAW_BIGDUST     EQU 2
rocket.DRAW_NODUST      EQU -1

view.DrawSomeRocket SUBROUTINE
                        jmp $FFFF
rockets.drawSub_SMC     EQU *-2

; -----------------------------------------------------------------------------
; view.DrawSmallRocket
; -----------------------------------------------------------------------------

view.DrawSmallRocket SUBROUTINE
                        beq .drawFull
                        bmi .noDust
                        WRITE_CHAR 6,13
                        INCLUDE "__char_rocket_small_dust_2.asm"
                        rts
.noDust
                        WRITE_CHAR 6,13
                        INCLUDE "__char_rocket_small_dust_1.asm"
                        rts
.drawFull
                        bit zp.Flags
                        bmi .frameTwo
                        WRITE_CHAR_CORE
                        INCLUDE "__char_rocket_small_1.asm"
                        rts
.frameTwo
                        WRITE_CHAR_CORE
                        INCLUDE "__char_rocket_small_2.asm"
                        rts

; -----------------------------------------------------------------------------
; view.DrawMediumRocket
; -----------------------------------------------------------------------------

view.DrawMediumRocket SUBROUTINE
                        beq .drawFull
                        bmi .noDust
                        WRITE_CHAR 6,13
                        INCLUDE "__char_rocket_medium_dust_2.asm"
                        rts
.noDust
                        WRITE_CHAR 6,13
                        INCLUDE "__char_rocket_medium_dust_1.asm"
                        rts
.drawFull
                        bit zp.Flags
                        bmi .frameTwo
                        WRITE_CHAR_CORE
                        INCLUDE "__char_rocket_medium_1.asm"
                        rts
.frameTwo
                        WRITE_CHAR_CORE
                        INCLUDE "__char_rocket_medium_2.asm"
                        rts

; -----------------------------------------------------------------------------
; view.DrawBigRocket
; -----------------------------------------------------------------------------

view.DrawBigRocket SUBROUTINE
                        beq .drawFull
                        bmi .noDust
                        WRITE_CHAR 6,13
                        INCLUDE "__char_rocket_big_dust_2.asm"
                        rts
.noDust
                        WRITE_CHAR 6,13
                        INCLUDE "__char_rocket_big_dust_1.asm"
                        rts
.drawFull
                        bit zp.Flags
                        bmi .frameTwo
                        WRITE_CHAR_CORE
                        INCLUDE "__char_rocket_big_1.asm"
                        rts
.frameTwo
                        WRITE_CHAR_CORE
                        INCLUDE "__char_rocket_big_2.asm"
                        rts

; -----------------------------------------------------------------------------
; view.DrawBuranShuttle
; -----------------------------------------------------------------------------

view.DrawBuranShuttle SUBROUTINE
                        beq .drawFull
                        bmi .noDust
                        cmp #1
                        beq .smallDust
                        WRITE_CHAR 6,12
                        INCLUDE "__char_buran_dust_4.asm"
                        rts
.smallDust
                        WRITE_CHAR 6,13
                        INCLUDE "__char_buran_dust_2.asm"
                        rts
.noDust
                        WRITE_CHAR 6,12
                        INCLUDE "__char_buran_dust_3.asm"
                        rts
.drawFull
                        bit zp.Flags
                        bmi .frameTwo
                        WRITE_GFX_CORE
                        INCLUDE "__gfx_shuttle_1a.asm"
                        jsr sound.Tick
                        WRITE_GFX_CORE
                        INCLUDE "__gfx_shuttle_1b.asm"
                        rts
.frameTwo
                        WRITE_GFX_CORE
                        INCLUDE "__gfx_shuttle_2a.asm"
                        jsr sound.Tick
                        WRITE_GFX_CORE
                        INCLUDE "__gfx_shuttle_2b.asm"
                        rts
