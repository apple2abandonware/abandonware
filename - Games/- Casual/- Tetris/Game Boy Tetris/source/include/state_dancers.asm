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
; state.dancers
; -----------------------------------------------------------------------------
; Inputs: none

state.dancers SUBROUTINE
                        PREVIOUS_STATE= nil
                        NEXT_STATE= rockets

                        jsr glitch.Stop

                        bit zp.Flags
                        bvc .skipDancers

                        START_TUNE success
                        WAIT_MUSIC

                        lda state.playerBlevel
                        cmp #$09
                        bne .skipDancers

                        jsr view.DrawDancersBackground ; Sets write direction to Up


                        lda state.playerHigh
                        asl
                        tax
                        lda .dancersTab,x
                        sta .danceStart_SMC
                        lda .dancersTab+1,x
                        sta .danceStart_SMC+1

                        SET_WRITE_DIRECTION_UP

                        jsr startDancers0
.danceStart_SMC         EQU *-2

                        SET_WRITE_DIRECTION_DOWN

                        WAIT_KEY 10
                        bne .skipDancers
.loop
                        jsr screen.Toggle
                        WAIT_KEY 10
                        bne .skipDancers
                        lda sound.MusicIsPlaying
                        bne .loop
.skipDancers
                        rts

.dancersTab
                        DC.W startDancers0
                        DC.W startDancers1
                        DC.W startDancers2
                        DC.W startDancers3
                        DC.W startDancers4
                        DC.W startDancers5

startDancers0 subroutine
                        jsr showDancers0
                        START_TUNE dance0
                        rts

startDancers1 subroutine
                        jsr showDancers1
                        START_TUNE dance1
                        rts

startDancers2 subroutine
                        jsr showDancers2
                        START_TUNE dance2
                        rts

startDancers3 subroutine
                        jsr showDancers3
                        jsr showDancers2
                        START_TUNE dance3
                        rts

startDancers4 subroutine
                        jsr showDancers4
                        jsr showDancers3
                        jsr showDancers2
                        START_TUNE dance4
                        rts

startDancers5 subroutine
                        jsr showDancers6
                        jsr showDancers5
                        jsr showDancers3
                        jsr showDancers2
                        START_TUNE dance5
                        rts

showDancers0 subroutine
                        jsr screen.ToggleActive
                        WRITE_GFX 6, 6
                        INCLUDE "__gfx_dance0frame0_flip.asm"

                        jsr screen.ToggleActive
                        WRITE_GFX 6, 6
                        INCLUDE "__gfx_dance0frame1_flip.asm"
                        rts

showDancers1 subroutine
                        jsr screen.ToggleActive
                        WRITE_GFX 2, 6
                        INCLUDE "__gfx_dance1frame0_flip.asm"

                        jsr screen.ToggleActive
                        WRITE_GFX 2, 6
                        INCLUDE "__gfx_dance1frame1_flip.asm"
                        rts

showDancers2 subroutine
                        jsr screen.ToggleActive
                        WRITE_GFX 2, 6
                        INCLUDE "__gfx_dance2frame0_flip.asm"

                        jsr screen.ToggleActive
                        WRITE_GFX 2, 6
                        INCLUDE "__gfx_dance2frame1_flip.asm"
                        rts

showDancers3 subroutine
                        jsr screen.ToggleActive
                        WRITE_GFX 2, 13
                        INCLUDE "__gfx_dance3frame0_flip.asm"

                        jsr screen.ToggleActive
                        WRITE_GFX 2, 13
                        INCLUDE "__gfx_dance3frame1_flip.asm"
                        rts

showDancers4 subroutine
                        jsr screen.ToggleActive
                        WRITE_GFX 7, 15
                        INCLUDE "__gfx_dance4frame0_flip.asm"

                        jsr screen.ToggleActive
                        WRITE_GFX 7, 15
                        INCLUDE "__gfx_dance4frame1_flip.asm"
                        rts

showDancers5 subroutine
                        jsr screen.ToggleActive
                        WRITE_GFX 7, 15
                        INCLUDE "__gfx_dance5frame0_flip.asm"

                        jsr screen.ToggleActive
                        WRITE_GFX 7, 15
                        INCLUDE "__gfx_dance5frame1_flip.asm"
                        rts

showDancers6 subroutine
                        jsr screen.ToggleActive
                        WRITE_GFX 15, 16
                        INCLUDE "__gfx_dance6frame0_flip.asm"

                        jsr screen.ToggleActive
                        WRITE_GFX 15, 16
                        INCLUDE "__gfx_dance6frame1_flip.asm"
                        rts

