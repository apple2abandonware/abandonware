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

sound.MODE_PHASE        EQU $f0
sound.MODE_NO_PHASE     EQU $d0
sound.PRIORITY_NORMAL   EQU $01
sound.PRIORITY_HIGH     EQU $02

; -----------------------------------------------------------------------------
; PLAY_SOUND (Macro)
; -----------------------------------------------------------------------------
; Arguments: sound effect, register [a|x|y]

                MAC PLAY_SOUND
                        PLAY_SOUND_CORE {1}, sound.MODE_PHASE, sound.PRIORITY_NORMAL
                ENDM

                MAC PLAY_SOUND_CORE
.soundEffect            EQU {1}
.soundEffectLen         EQU {1}Len
.phaseInstr             EQU {2}
.priority               EQU {3}

                        lda #.soundEffectLen
                        sta sound.Length
                        ldx <#.soundEffect
                        ldy >#.soundEffect
                        lda #.priority
                        jsr sound.Play
                        IF .phaseInstr == sound.MODE_NO_PHASE
                                lda #.phaseInstr
                                sta skipPhase_SMC
                        EIF
                ENDM


; -----------------------------------------------------------------------------
; STOP_SOUND (Macro)
; -----------------------------------------------------------------------------
; Arguments: none

                MAC STOP_SOUND
                        lda #0
                        sta zp.SoundIndex
                ENDM

; -----------------------------------------------------------------------------
; WAIT_MUSIC (Macro)
; -----------------------------------------------------------------------------
; Arguments: none

                MAC WAIT_MUSIC
.loop
                        WAIT_KEY 1
                        lda sound.MusicIsPlaying
                        bne .loop
                ENDM