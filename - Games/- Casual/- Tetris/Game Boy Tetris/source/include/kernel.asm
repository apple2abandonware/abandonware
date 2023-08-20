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
; DrawTile
; -----------------------------------------------------------------------------
; Inputs: TileNum, TileX, TileY

TileNum                 EQU TileNum_SMC         ; Tile number to be drawn
TileX                   EQU TileX_SMC           ; Tile position
TileY                   EQU TileY_SMC

DrawTile SUBROUTINE
                        ldx #0
TileNum_SMC             EQU *-1
                        lda gfx.TabL,x
                        sta zp.TileL
                        lda gfx.TabH,x
                        sta zp.TileH
                        ; No RTS... this falls through to DrawTileCore

; -----------------------------------------------------------------------------
; DrawTileCore
; -----------------------------------------------------------------------------
; Inputs:  TileNum, TileX, TileY, zp.TileL, zp.TileH

DrawTileCore SUBROUTINE
                        SEG.U ZEROPAGE
.left                   DS.B 1                  ; Tile work area, lots of bit shifting
.right                  DS.B 1                  ; Tile work area, lots of bit shifting
.rowCounter             DS.B 1                  ; 9 accesses
.mask0                  DS.B 1                  ; 9 accesses
.mask1                  DS.B 1                  ; 9 accesses
HBASL                   DS.B 1
HBASH                   DS.B 1
                        SEG PROGRAM

                        inc sound.MusicDelay    ; Account for tile drawing time
                        ldx #0                  ; It's just luck the x & y registers can hold x & y positions...
TileX_SMC               EQU *-1
                        ldy #0
TileY_SMC               EQU *-1
                        CALC_BASE
DrawTileRaw
                        ldy #0
                        sty .left
                        ldy #7                  ; prep to count down from 7 to 0 (rows)
Shift_SMC               equ *-1
                        sty .rowCounter
                        lda sprShift,x          ; how many pixels to the right we need to shift the sprite
                        sta .shiftOffset_SMC
                        lda sprMask0,x          ; mask for left byte
                        sta .mask0
                        lda sprMask1,x          ; mask for right byte
                        sta .mask1
.loop
                        ldy .rowCounter
                        lda (zp.TileL),y
                        ; eor #%11111111        ; "Dark mode"
                        sta .right

                ; Notes:
                ; A byte in video memory is rendered right to left, where
                ; LSB (bit 0) is the leftmost and bit 6 is the rightmost.
                ; The MSB (bit 7) is the color bit. Our tile data is
                ; appropriately flipped, but uses all 8 bits for pixel data and
                ; doesn't use the color bit, so the shifter will always shift
                ; the MSB out of the left byte into the neighboring right byte.

                        bne .fake               ; Magic...
.shiftOffset_SMC        EQU *-1
.fake
                        lsr .right
                        ror .left
                        lsr .right
                        ror .left
                        lsr .right
                        ror .left
                        lsr .right
                        ror .left
                        lsr .right
                        ror .left
                        lsr .right
                        ror .left
                        lsr .right
                        ror .left
                        lsr .left               ; Carry will be clear, important for later
                        ldy #0
                        lda (HBASL),y
                        and .mask0
                        ora .left
                        sta (HBASL),y
                        sty .left
                        iny
                        lda (HBASL),y
                        and .mask1
                        ora .right
                        sta (HBASL),y
                        lda HBASH
                        sbc #3                  ; Carry is always clear, so this is equivalent to sec, sbc #4
                        sta HBASH
                        dec .rowCounter
                        bpl .loop
                        rts

; -----------------------------------------------------------------------------

tileOffset              SUBROUTINE
.n                      SET 0
.count                  SET screen.FINE_OFFSET_X
                        REPEAT 5
                        REPEAT 4
                        DC.B .n
.n                      SET .n + 1
.count                  SET .count +1
                        if .count = 7
.count                  SET 0
.n                      SET .n + 1
                        endif
                        REPEND
                        REPEND

sprMask0
.sub                    SET %00000001
                        REPEAT screen.FINE_OFFSET_X
.sub                    SET .sub << 1
                        REPEND
                        REPEAT 20
                        DC.B (<(.sub - 1)) | %10000000
.sub                    SET .sub << 1
                        if .sub = %10000000
.sub                    SET %00000001
                        endif
                        REPEND

sprMask1
.sub                    SET %00000010
                        REPEAT screen.FINE_OFFSET_X
.sub                    SET .sub << 1
                        REPEND
                        REPEAT 20
                        DC.B <(.sub - 1) ^ $ff
.sub                    SET .sub << 1
                        if <.sub = 0
.sub                    SET %00000010
                        endif
                        REPEND

sprShift                SUBROUTINE
.shift                  SET screen.FINE_OFFSET_X
                        REPEAT 20
                        DC.B .shift * 4
.shift                  SET .shift + 1
                        if .shift = 7
.shift                  SET 0
                        endif
                        REPEND

