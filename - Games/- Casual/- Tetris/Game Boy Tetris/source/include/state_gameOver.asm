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
; state.gameOver
; -----------------------------------------------------------------------------
; Inputs: none

state.gameOver SUBROUTINE
                        PREVIOUS_STATE= nil
                        NEXT_STATE= rockets

                        STOP_TUNE a
                        STOP_SOUND
                        jsr glitch.Stop

                        jsr view.ClearPreviewWindow
                        jsr screen.Toggle
                        jsr screen.ToggleActive
                        jsr view.DrawGameOver
                        jsr screen.ToggleActive

                        START_TUNE end
                        CLEAR_KEYS
                        WAIT_KEY 0
                        STOP_TUNE a
                        rts
