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
; Move memory up
; -----------------------------------------------------------------------------
; Source: http://6502.org/source/general/memory_move.html
; -----------------------------------------------------------------------------

copy.MoveUp SUBROUTINE
                        ldx copy.SizeH  ; the last byte must be moved first
                        clc             ; start at the final pages of from and to
                        txa
                        adc copy.SrcH
                        sta copy.SrcH
                        clc
                        txa
                        adc copy.DestH
                        sta copy.DestH
                        inx             ; allows the use of bne after the dex below
                        ldy copy.SizeL
                        beq .mu3
                        dey             ; move bytes on the last page first
                        beq .mu2
.mu1                    lda (copy.SrcL),y
                        sta (copy.DestL),y
                        dey
                        bne .mu1
.mu2                    lda (copy.SrcL),y    ; handle y = 0 separately
                        sta (copy.DestL),y
.mu3                    dey
                        dec copy.SrcH      ; move the next page (if any)
                        dec copy.DestH
                        dex
                        bne .mu1
                        rts

; -----------------------------------------------------------------------------
; Move memory down
; -----------------------------------------------------------------------------
; Source: http://6502.org/source/general/memory_move.html
; -----------------------------------------------------------------------------

copy.MoveDown SUBROUTINE
                        ldy #0
                        ldx copy.SizeH
                        beq .md2
.md1                    lda (copy.SrcL),y ; move a page at a time
                        sta (copy.DestL),y
                        iny
                        bne .md1
                        inc copy.SrcH
                        inc copy.DestH
                        dex
                        bne .md1
.md2                    ldx copy.SizeL
                        beq .md4
.md3                    lda (copy.SrcL),y ; move the remaining bytes
                        sta (copy.DestL),y
                        iny
                        dex
                        bne .md3
.md4                    rts
