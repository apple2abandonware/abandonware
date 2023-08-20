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
; stateMachine.vectors
; -----------------------------------------------------------------------------

stateMachine.vectors
VECTOR_OFFSET           SET 0
                        VECTOR init
                        VECTOR credits
                        VECTOR title
                        VECTOR options
                        VECTOR optionsAType
                        VECTOR optionsBType
                        VECTOR game
                        VECTOR gameOver
                        VECTOR dancers
                        VECTOR rockets
                        VECTOR scoreTally
                        VECTOR highScore
                        VECTOR nil

; -----------------------------------------------------------------------------
; stateMachine.Start
; -----------------------------------------------------------------------------
; Inputs: stateMachine.next

stateMachine.Start SUBROUTINE

__state.PREVIOUS        EQU $80                 ; Negative value denotes previous state

                        SEG.U DATA
stateMachine.stackPtr   DS.B 1
stateMachine.previous   DS.B 1
stateMachine.next       DS.B 1
                        SEG PROGRAM

                        tsx
                        stx stateMachine.stackPtr
stateMachine.reset
                        ldx stateMachine.stackPtr
                        txs

                        NEXT_STATE= init

.loop
                        lda stateMachine.next
                        asl
                        tax
                        lda stateMachine.vectors,x
                        sta .target_SMC
                        lda stateMachine.vectors + 1,x
                        sta .target_SMC + 1

                        jsr $ffff
.target_SMC             EQU *-2

                        lda stateMachine.next
                        bpl .loop

                        lda stateMachine.previous
                        sta stateMachine.next
                        jmp .loop
