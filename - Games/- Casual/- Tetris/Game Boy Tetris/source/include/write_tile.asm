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
; WriteTile
; -----------------------------------------------------------------------------

WriteTile SUBROUTINE
                        SEG.U DATA
kernel.horzOffset       DS.B 1
kernel.crlfPosition     DS.B 1
kernel.vShift           DS.B 1
kernel.maxY             DS.B 1
                        SEG PROGRAM

                        lda TileX
                        sta kernel.crlfPosition
                        pla
                        sta .strAddr_SMC
                        pla
                        sta .strAddr_SMC+1
.nextChar
                        inc .strAddr_SMC
                        bne .continue
                        inc .strAddr_SMC+1
.continue
                        lda $FFFF
.strAddr_SMC            EQU *-2
                        cmp #CRLF
                        beq .CRLF
                        cmp #EOL
                        bne .noEOL
.CRLF
                        ldx kernel.crlfPosition
                        stx TileX
tiles.Direction_SMC     inc TileY
                        cmp #CRLF
                        beq .nextChar
                        jmp .end
.noEOL
                        tay
                        ldx #$00
tiles.WriteMode_SMC     EQU *-1
                        bne .textMode
                        lda gfx.TabL,y
                        sta zp.TileL
                        lda gfx.TabH,y
                        sta zp.TileH
                        jmp .draw
.textMode
                        lda char.TabL,y
                        sta zp.TileL
                        lda char.TabH,y
                        sta zp.TileH
.draw
                        lda kernel.vShift
                        beq .noShift


                        sec
                        lda #7
                        sbc kernel.vShift
                        sta Shift_SMC
                        sta .offset_SMC
                        lda TileY
                        bmi .drawBottom
                        cmp kernel.maxY
                        bpl .drawBottom
                        jsr DrawTileCore

.drawBottom
                        ldx kernel.vShift
                        dex
                        stx Shift_SMC
                        ldx TileX
                        ldy TileY
                        iny
                        bmi .endDraw
                        cpy kernel.maxY
                        bpl .endDraw

                        jsr calcBase
                        ldy #7
.offset_SMC             EQU *-1
                        iny
.loop
                        sec
                        lda HBASH
                        sbc #4
                        sta HBASH
                        inc zp.TileL
                        bne .noCarry
                        inc zp.TileH
.noCarry
                        dey
                        bne .loop
                        jsr DrawTileRaw
                        jmp .endDraw
.noShift
                        lda TileY
                        bmi .endDraw
                        cmp kernel.maxY
                        bpl .endDraw
                        jsr DrawTileCore
.endDraw
                        lda #7
                        sta Shift_SMC
                        inc TileX
                        jmp .nextChar
.end
                        lda .strAddr_SMC+1
                        pha
                        lda .strAddr_SMC
                        pha
                        rts

calcBase SUBROUTINE
                        CALC_BASE
                        rts

