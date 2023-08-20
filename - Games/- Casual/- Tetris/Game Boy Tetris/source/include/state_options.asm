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
; state.options
; -----------------------------------------------------------------------------
; Inputs: none

state.options SUBROUTINE
                        PREVIOUS_STATE= title
                        NEXT_STATE= nil

                        WRITE_CHAR 0,0
                        INCLUDE "__char_options.asm"
                        jsr screen.ShowActive

                        jsr select.refreshMusicType

                        jsr music.StartGameTune
                        
.selectGameType
                        jsr select.gameType
                        lda selector.NewValue
                        cmp #selector.CANCEL
                        beq .cancel
.selectMusic
                        jsr select.music
                        lda selector.NewValue
                        cmp #selector.CANCEL
                        beq .selectGameType

                        PLAY_SOUND soundEffect.Select
                        jsr sound.Tick
                        jsr sound.Tick

                        bit zp.Flags
                        bvs .gameTypeB
.gameTypeA
                        NEXT_STATE= optionsAType
                        bne .exit

.gameTypeB
                        NEXT_STATE= optionsBType
                        bne .exit

.cancel
                        NEXT_STATE= PREVIOUS

.exit
                        jsr screen.ToggleActive
                        rts
