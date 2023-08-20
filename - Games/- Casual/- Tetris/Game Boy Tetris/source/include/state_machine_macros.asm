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
; MERCHANTABILITY or FITNESS FOR A PARTiICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with GB Tetris for Apple II.  If not, see:
; https://choosealicense.com/licenses/gpl-3.0/
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
; VECTOR (Macro)
; -----------------------------------------------------------------------------
; Arguments: Name

                MAC VECTOR
__state.{1}             EQU VECTOR_OFFSET
                        DC.W state.{1}
VECTOR_OFFSET           SET VECTOR_OFFSET + 1
                ENDM

; -----------------------------------------------------------------------------
; PREVIOUS_STATE= (Macro)
; -----------------------------------------------------------------------------
; Arguments: The name of the previous state

                MAC PREVIOUS_STATE=
                        lda #__state.{1}
                        sta stateMachine.previous
                ENDM

; -----------------------------------------------------------------------------
; NEXT_STATE= (Macro)
; -----------------------------------------------------------------------------
; Arguments: The name of the next state

                MAC NEXT_STATE=
                        lda #__state.{1}
                        sta stateMachine.next
                ENDM
