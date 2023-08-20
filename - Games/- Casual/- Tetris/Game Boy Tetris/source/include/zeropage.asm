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

                        SEG.U ZEROPAGE

zp.Flags                DS.B 1                  ; bit7 = gfx page 0/1
                                                ; bit6 = game A/B
                                                ; bit1-0 = music selection A/B/C/Off
zp.TileL                DS.B 1
zp.TileH                DS.B 1
zp.PieceIndex           DS.B 1
zp.PieceGridL           DS.B 1
zp.PieceGridH           DS.B 1
zp.SoundL               DS.B 1
zp.SoundH               DS.B 1
zp.SoundIndex           DS.B 1

digits.BCDAddr          DS.W 1


                        SEG PROGRAM

; -----------------------------------------------------------------------------
; zp.Save
; -----------------------------------------------------------------------------

zp.Save SUBROUTINE
                        ldx #0
.loop
                        lda $00,x
                        sta $0200,x
                        dex
                        bne .loop
                        rts

; -----------------------------------------------------------------------------
; zp.Restore
; -----------------------------------------------------------------------------

zp.Restore SUBROUTINE
                        ldx #0
.loop
                        lda $0200,x
                        sta $00,x
                        dex
                        bne .loop
                        rts