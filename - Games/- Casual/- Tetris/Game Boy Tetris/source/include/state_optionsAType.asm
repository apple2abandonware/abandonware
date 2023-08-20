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
; state.optionsAType
; -----------------------------------------------------------------------------
; Inputs: none

state.optionsAType SUBROUTINE
                        PREVIOUS_STATE= options
                        NEXT_STATE= game

                        jsr view.DrawOptionsATypeScreen
                        jsr highscore.RenderScores
                        jsr screen.ShowActive
                        jsr music.StartGameTune
.selectLevel
                        jsr select.level
                        lda selector.CurrentValue
                        jsr state.SetLevelCore
                        jsr screen.ToggleActive
                        lda selector.NewValue
                        cmp #selector.CANCEL
                        bne .exit
                        NEXT_STATE= PREVIOUS
.exit
                        rts
