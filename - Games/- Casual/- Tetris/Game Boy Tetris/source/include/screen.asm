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
; screen.Toggle
; -----------------------------------------------------------------------------
; Inputs: none

screen.Toggle SUBROUTINE
                        lda #flags.GFX_PAGE_MASK
                        eor zp.Flags
                        sta zp.Flags
                        bmi .isPage1
.isPage0                bit HISCR
                        rts
.isPage1                bit LOWSCR
                        rts


; -----------------------------------------------------------------------------
; screen.ShowActive
; -----------------------------------------------------------------------------
; Inputs: none

screen.ShowActive SUBROUTINE
                        bit zp.Flags
                        bmi .isPage1
.isPage0                bit LOWSCR
                        rts
.isPage1                bit HISCR
                        rts

; -----------------------------------------------------------------------------
; screen.ToggleActive
; -----------------------------------------------------------------------------
; Inputs: none

screen.ToggleActive SUBROUTINE
                        lda #flags.GFX_PAGE_MASK
                        eor zp.Flags
                        sta zp.Flags
                        rts

; -----------------------------------------------------------------------------
; screen.Init
; -----------------------------------------------------------------------------
; Inputs: none

screen.Init SUBROUTINE
                        bit init.FirstInit
                        bvc .skipTextMode
                        lda LOWSCR
                        lda TXTSET
.skipTextMode
                        jsr screen.TextureFill
                        lda HIRES
                        lda TXTCLR
                        lda MIXCLR
                        jsr screen.Toggle
                        rts

; -----------------------------------------------------------------------------
; screen.TextureFill
; -----------------------------------------------------------------------------
; Inputs: none

screen.TextureFill SUBROUTINE
                        lda #$20
                        sta .addrH_SMC
                        lda #$00
                        sta .addrL_SMC
.loop
                        jsr .swapPattern
.skipSwap
                        lda #%10101010
.pattern_SMC            EQU *-1

                        sta $2000
.addrH_SMC              EQU *-1
.addrL_SMC              EQU *-2

                        inc .addrL_SMC
                        bne .loop
                        inc .addrH_SMC
                        lda .addrH_SMC
                        cmp #$60
                        beq .end
                        and #%00000011
                        beq .skipSwap
                        bne .loop
.end
                        jsr .swapPattern        ; Ensures .altPattern and .pattern_SMC are ready for a subsequent fill
                        rts

.swapPattern
                        ldy .altPattern
                        lda .pattern_SMC
                        sta .altPattern
                        sty .pattern_SMC
                        rts

.altPattern             DC.B #%11010101

; -----------------------------------------------------------------------------
; CALC_BASE_ADDRESS (Macro)
; -----------------------------------------------------------------------------
; Arguments: First Row Address, Low or High Byte (<,>)

                ; To compute HGR row base address, where N is the row...
                ; (N-INT(N/8)*8)*1024+INT(N/8)*128-INT(N/64)*984
                ; [N % 8] * 1024 + [N >> 3] * 128 - [N >> 6] * 984
                ; Simple, right?

                MAC CALC_BASE_ADDRESS   ; Local macro
.firstRowAddr           EQU {1} + screen.COARSE_OFFSET_X
.row                            SET screen.OFFSET_Y*8+7
                        REPEAT 18
.addr                           SET .firstRowAddr + [[.row & %00000111] << 10] + [[.row & %11111000] << 4] - [[.row >> 6] * 984]
                                DC.B {2}.addr
.row                                    SET .row + 8
                        REPEND
                ENDM

; -----------------------------------------------------------------------------

screen.Pg0TabL
                        CALC_BASE_ADDRESS $2000, <
screen.Pg0TabH
                        CALC_BASE_ADDRESS $2000, >

screen.Pg1TabL
                        CALC_BASE_ADDRESS $4000, <
screen.Pg1TabH
                        CALC_BASE_ADDRESS $4000, >

