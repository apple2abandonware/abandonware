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

                MAC MVY
                        ldy {1}
                        sty {2}
                ENDM

                MAC SCS
                        BCS .skip
                        {0}
.skip
                ENDM

                MAC SEQ
                        BEQ .skip
                        {0}
.skip
                ENDM

                MAC SNE
                        BNE .skip
                        {0}
.skip
                ENDM

                MAC ADD
                        CLC
                        ADC {0}
                ENDM

                MAC SUB
                        SEC
                        SBC {0}
                ENDM

                MAC INW
                        inc {0}
                        SNE inc {0}+1
                ENDM

                MAC DTA
                        DC.B {0}
                ENDM
