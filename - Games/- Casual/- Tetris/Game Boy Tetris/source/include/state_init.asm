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
; state.init
; -----------------------------------------------------------------------------
; Inputs: none

state.init SUBROUTINE
                        PREVIOUS_STATE= nil
                        NEXT_STATE= credits

                        lda #20
                        sta kernel.maxY

                        lda #0
                        sta kernel.vShift
                        sta zp.Flags
                        sta zp.SoundIndex
                        sta state.playerAlevel
                        sta state.playerBlevel
                        sta state.playerHigh
                        sta sound.MusicIsPlaying
                        sta digits.LeftAligned

                        jsr state.SetLevelCore  ; Needs A=0
                        jsr screen.Init
                        jsr sound.Enable

                        lda #$80
                        sta init.FirstInit

                        rts

init.FirstInit          DC.B 0


; -----------------------------------------------------------------------------
; init.MoveChunk
; -----------------------------------------------------------------------------
; Inputs:
; gbt.COPY_SRC_START
; gbt.COPY_SRC_END
; gbt.gbt.COPY_DEST_START
; gbt.gbt.COPY_DEST_END

init.MoveChunk SUBROUTINE
                        SEG.U ZEROPAGE
copy.SrcL               DS.B 1
copy.SrcH               DS.B 1
copy.DestL              DS.B 1
copy.DestH              DS.B 1
                        SEG.U DATA
copy.SizeL              DS.B 1
copy.SizeH              DS.B 1
                        SEG PROGRAM

.chunkSize              EQU gbt.COPY_DEST_END - gbt.COPY_DEST_START

                        lda #<gbt.COPY_SRC_START
                        sta copy.SrcL
                        lda #>gbt.COPY_SRC_START
                        sta copy.SrcH
                        lda #<gbt.COPY_DEST_START
                        sta copy.DestL
                        lda #>gbt.COPY_DEST_START
                        sta copy.DestH
                        lda #<.chunkSize
                        sta copy.SizeL
                        lda #>.chunkSize
                        sta copy.SizeH

                        jmp copy.MoveUp

                        rts