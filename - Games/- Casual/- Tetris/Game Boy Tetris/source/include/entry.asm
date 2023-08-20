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

entry.SplashPause       DC.B $0B
entry.ColdStart
                        jsr entry.ResetIO ; Do this before using PRINT macro

                        PRINT ""
                        PRINT "GAMEBOY TETRIS - ",VERSION
                        PRINT ""

                        jsr zp.Save
                        jsr init.MoveChunk
                        jsr joystick.Calibrate
                        jsr splashScreen.deflate

                        bit HIRES
                        bit TXTCLR
                        bit MIXCLR
                        bit LOWSCR

                        START_TUNE typeb
                        lda #1
                        sta noteDuration_SMC
                        lda #3
                        sta music.TickDuration_SMC
                        WAIT_KEY 0

                        bit KBDSTRB
                        jsr highscore.ResetScores

entry.WarmStart
                        jmp stateMachine.Start


; -----------------------------------------------------------------------------
; entry.ResetIO
; -----------------------------------------------------------------------------
; Inputs: none

entry.ResetIO SUBROUTINE
                        ldx #3
.unhookLoop
                        lda .ioHooks,x
                        sta $36,x
                        dex
                        bpl .unhookLoop
                        rts

.ioHooks                DC.B $F0, $FD, $1B, $FD
