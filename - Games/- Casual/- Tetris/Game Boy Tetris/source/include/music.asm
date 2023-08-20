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
; music.StartTune
; -----------------------------------------------------------------------------
; Inputs: music.Address

music.StartTune SUBROUTINE
                        SEG.U DATA
music.Address           DS.W 1
                        SEG PROGRAM

                        lda #0
                        sta sound.MusicDelay
                        sta sound.MusicDelay2
                        lda #1
                        sta sound.MusicTimer
                        lda music.Address
                        sta MusicL
                        lda music.Address+1
                        sta MusicH
                        ldy #0
                        lda (MusicL),y
                        sta noteDuration_SMC
                        iny
                        lda (MusicL),y
                        sta music.TickDuration_SMC

                        sty sound.MusicIsPlaying

                        rts

; -----------------------------------------------------------------------------
; music.RestartTune
; -----------------------------------------------------------------------------
; Inputs: None

music.RestartTune SUBROUTINE
                        SEG.U DATA
.startIndex             DS.B 1
                        SEG PROGRAM

                        sta .startIndex
                        dec .startIndex
                        asl .startIndex

                        lda music.Address
                        sta MusicL
                        lda music.Address+1
                        sta MusicH

                        clc
                        lda MusicL
                        adc .startIndex
                        sta MusicL
                        lda MusicH
                        adc #0
                        sta MusicH
                        rts

; -----------------------------------------------------------------------------
; music.StartGameTune
; -----------------------------------------------------------------------------
; Inputs: zp.Flags two low order bits

music.StartGameTune SUBROUTINE
                        lda zp.Flags
                        and #flags.MUSIC_MASK
                        bne .checkTypeB
                        START_TUNE typea        ; 0 = Type A
                        jmp .setMusicParams
.checkTypeB
                        cmp #1
                        bne .checkTypeC
                        START_TUNE typeb        ; 1 = Type B
                        jmp .setMusicParams
.checkTypeC
                        cmp #2
                        bne .noMusic
                        START_TUNE typec        ; 2 = Type C

.setMusicParams
                        lda #2
                        sta noteDuration_SMC
                        lda #1
                        sta music.TickDuration_SMC
                        rts
.noMusic
                        STOP_TUNE a             ; 3 = No Music
                        rts

; -----------------------------------------------------------------------------
; music.PauseTune
; -----------------------------------------------------------------------------
; Inputs: None
                        SEG.U DATA
music.WasPlaying        DS.B 1
                        SEG PROGRAM

music.PauseTune SUBROUTINE
                        pha
                        lda sound.MusicIsPlaying
                        sta music.WasPlaying
                        STOP_TUNE a
                        pla
                        rts

music.ResumeTune SUBROUTINE
                        pha
                        lda music.WasPlaying
                        sta sound.MusicIsPlaying
                        pla
                        rts
