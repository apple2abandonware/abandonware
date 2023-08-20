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
; Pseudo Random Number Generator
; By David Holz
; http://codebase64.org/doku.php?id=base:small_fast_8-bit_prng
; -----------------------------------------------------------------------------


; -----------------------------------------------------------------------------
; prng.Cycle
; -----------------------------------------------------------------------------

prng.Cycle SUBROUTINE
                        SEG.U ZEROPAGE
zp.RandomSeed           DS.B 1
                        SEG PROGRAM

                        lda zp.RandomSeed
                        beq .doEor
                        asl
                        beq .noEor ;if the input was $80, skip the EOR
                        bcc .noEor
.doEor                  eor #$1d
.noEor                  sta zp.RandomSeed
                        rts

