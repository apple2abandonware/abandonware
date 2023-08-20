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
; SLEEP (Macro)
; -----------------------------------------------------------------------------
; Arguments:

; lda $zp = 3 cycles
; nop = 2 cycles
; bxx = 2 if none, 3 if taken, 4 if taken over boundary
; jsr, rts = 6
;
;

                MAC SLEEP
                        IF {1} < 20
                                ECHO "WAIT too small"
                                ERR
                        ENDIF
.cycles                 EQU {1}
.coarse                 EQU [.cycles - 15] / 5
.fine                   EQU .cycles - [.coarse * 5 + 15]

                        ; ECHO "✅", [.cycles]d, [.coarse]d, [.fine]d
                        ldx #.coarse    ; +2
                        jsr sleep       ; +6

                        IF .fine = 0
                                nop
                        ENDIF
                        IF .fine = 1
                                ldx $00
                        ENDIF
                        IF .fine = 2
                                nop
                                nop
                        ENDIF
                        IF .fine = 3
                                nop
                                ldx $00
                        ENDIF
                        IF .fine = 4
                                ldx $00
                                ldx $00
                        ENDIF
                ENDM
