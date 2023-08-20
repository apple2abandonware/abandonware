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
; CALC_BASE (Macro)
; -----------------------------------------------------------------------------
; Arguments: x, y

                MAC CALC_BASE
                        clc
                        bit zp.Flags
                        bmi .page1              ; get row base address...
.page0                  lda screen.Pg0TabL,y    ; First, get the low byte
                        adc tileOffset,x
                        sta HBASL               ; Save to the same reg Applesoft uses...
                        lda screen.Pg0TabH,y    ; Next, get the high byte
                        sta HBASH
                        bne .endCalcBase        ; Requires unset Z processor flag
.page1                  lda screen.Pg1TabL,y    ; First, get the low byte
                        adc tileOffset,x
                        sta HBASL               ; Save to the same reg Applesoft uses...
                        lda screen.Pg1TabH,y    ; Next, get the high byte
                        sta HBASH
.endCalcBase
                ENDM


; -----------------------------------------------------------------------------
; SET_WRITE_DIRECTION_UP (Macro)
; -----------------------------------------------------------------------------
; Arguments: none

                MAC SET_WRITE_DIRECTION_UP
                        lda #$ce                ; dec
                        sta tiles.Direction_SMC
                ENDM

; -----------------------------------------------------------------------------
; SET_WRITE_DIRECTION_DOWN (Macro)
; -----------------------------------------------------------------------------
; Arguments: none

                MAC SET_WRITE_DIRECTION_DOWN
                        lda #$ee                ; inc
                        sta tiles.Direction_SMC
                ENDM

; -----------------------------------------------------------------------------
; WRITE_CHAR_CORE (Macro)
; -----------------------------------------------------------------------------
; Arguments: none

                MAC WRITE_CHAR_CORE
                        lda #1
                        sta tiles.WriteMode_SMC
                        jsr WriteTile
                ENDM

; -----------------------------------------------------------------------------
; WRITE_GFX_CORE (Macro)
; -----------------------------------------------------------------------------
; Arguments: none

                MAC WRITE_GFX_CORE
                        lda #0
                        sta tiles.WriteMode_SMC
                        jsr WriteTile
                ENDM

; -----------------------------------------------------------------------------
; WRITE_GFX (Macro)
; -----------------------------------------------------------------------------
; Arguments: x, y

                MAC WRITE_GFX
                        lda #{1}
                        sta TileX
                        lda #{2}
                        sta TileY
                        WRITE_GFX_CORE
                ENDM

; -----------------------------------------------------------------------------
; WRITE_CHAR (Macro)
; -----------------------------------------------------------------------------
; Arguments: x, y

                MAC WRITE_CHAR
                        lda #{1}
                        sta TileX
                        lda #{2}
                        sta TileY
                        WRITE_CHAR_CORE
                ENDM

; -----------------------------------------------------------------------------
; WRITE_CHAR_OFFSET (Macro)
; -----------------------------------------------------------------------------
; Arguments: x, y, kernel.horzOffset

                MAC WRITE_CHAR_OFFSET
                        lda #{1}
                        clc
                        adc kernel.horzOffset
                        sta TileX
                        lda #{2}
                        sta TileY
                        WRITE_CHAR_CORE
                ENDM
