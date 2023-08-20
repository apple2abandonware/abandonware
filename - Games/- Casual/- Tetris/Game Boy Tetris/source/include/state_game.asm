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
; state.game
; -----------------------------------------------------------------------------
; Inputs: none

                        SEG.U DATA
speed                   DS.B 1
dropCounter             DS.B 1
dropSpeed               DS.B 1
needsRedraw             DS.B 1
dropScore               DS.B 1
interruptDrop           DS.B 1
downIsLocked            DS.B 1
joyDrop                 DS.B 1
                        SEG PROGRAM

state.game SUBROUTINE
                        PREVIOUS_STATE= nil
                        NEXT_STATE= gameOver

                        jsr state.initNewGame
                        jsr view.DrawGameScreen

.outer
                        lda #$01                ; Compute and preview next tetromino
                        sta pcOpaque
                        jsr getNextPiece
                        lda previewPiece
                        sta pcNum
                        lda #13
                        sta pcY
                        lda #15
                        sta pcX
                        lda #0
                        sta pcRot
                        jsr pcDraw
                        jsr screen.Toggle
                        jsr pcDraw

                        lda #$ff                ; Prepare to start drawing the current tetromino
                        sta pcX_o1
                        sta pcX_o2
                        lda currentPiece
                        sta pcNum
                        lda #$00
                        sta pcOpaque

                        lda #5                  ; Set position
                        sta pcX
                        sta downIsLocked
                        lda #0
                        sta pcY
                        sta pcRot
                        sta dropScore
                        sta interruptDrop
                        sta joyDrop

                        jsr state.CalcSpeed

                        lda speed
                        sta dropSpeed
                        sta dropCounter
                        lda state.initialDropDone
                        bne .notIntialDrop
                        lda #state.INITIAL_PAUSE
                        sta dropCounter
.notIntialDrop

                        bit KBDSTRB             ; Wipe any buffered keypress

                        jsr pcClear
                        jsr pcDraw
                        jsr screen.Toggle

                        jsr checkCollision      ; Check for game over
                        beq .mainLoop
                        rts
.mainLoop
                        lda dropSpeed
                        cmp #1
                        bne .continue
                        sed
                        clc
                        lda dropScore
                        adc #1
                        sta dropScore
                        cld
.continue
                        lda #0
                        sta needsRedraw
                        jsr sound.Tick
                        jsr input.ReadInput
                        beq .joyDown            ; If there's any input AND it's not joystick down, then interrupt fast drop
                        lda input.lastJoy
                        cmp #input.DOWN
                        beq .joyDown
                        lda dropSpeed
                        cmp #1
                        bne .checkKey
                        lda speed
                        sta dropSpeed
                        sta dropCounter
                        sta interruptDrop
                        lda #0
                        sta dropScore
.checkKey               lda input.lastInput
.inputLeft              cmp #input.LEFT
                        bne .inputRight
                        jsr tryMoveLeft
                        jmp .kbdDone
.inputRight             cmp #input.RIGHT
                        bne .inputRotateCCW
                        jsr tryMoveRight
                        jmp .kbdDone
.inputRotateCCW         cmp #input.ROTLEFT
                        bne .inputRotateCW
                        jsr tryRotateCCW
                        jmp .kbdDone
.inputRotateCW          cmp #input.ROTRIGHT
                        bne .inputStart
                        jsr tryRotateCW
                        jmp .kbdDone
.inputStart             cmp #input.START
                        bne .inputBack
                        jsr pause
                        jmp .kbdDone
.inputBack              cmp #input.BACK
                        bne .keyDown
                        jsr pause
                        jmp .kbdDone
.keyDown                lda input.lastKey
                        cmp #input.DOWN
                        bne .joyDown
                        lda interruptDrop
                        bne .kbdDone
                        lda #1
                        sta dropSpeed
                        sta dropCounter
                        jmp .kbdDone
.joyDown                lda input.lastJoy
                        cmp #input.DOWN
                        bne .interruptJoy
                        lda downIsLocked
                        bne .kbdDone
                        lda #1
                        sta dropSpeed
                        sta dropCounter
                        sta joyDrop
                        bne .kbdDone
.interruptJoy           lda #0
                        sta downIsLocked
                        lda joyDrop
                        beq .kbdDone
                        lda dropSpeed
                        cmp #1
                        bne .kbdDone
                        lda speed
                        sta dropSpeed
                        sta dropCounter
                        sta interruptDrop
                        lda #0
                        sta joyDrop
                        sta dropScore
.kbdDone
                        lda #0
                        sta interruptDrop
                        dec dropCounter
                        bne .noDrop
                        jsr tryMoveDown
.noDrop
                        lda needsRedraw
                        beq .noRedraw
                        jsr pcClear
                        jsr pcDraw
                        jsr screen.Toggle
.noRedraw
                        jmp .mainLoop
placePiece
                        jsr pcClear
                        jsr pcDraw
                        jsr screen.Toggle
                        jsr pcKeep
                        PLAY_SOUND soundEffect.Drop
                        jsr clearLines
                        jmp .outer

; ****************************************
; pause
; ****************************************

pause                   SUBROUTINE
                        jsr music.PauseTune
                        jsr view.DrawPause
                        PLAY_SOUND_CORE soundEffect.Pause, sound.MODE_NO_PHASE, sound.PRIORITY_NORMAL
.loop
                        jsr sound.Tick
                        jsr input.ReadInput
                        cmp #input.START
                        beq .resume
                        cmp #input.BACK
                        bne .loop
.resume
                        jsr screen.Toggle
                        jsr state.reloadBoard
                        jsr music.ResumeTune
                        rts

; ****************************************
; clearLines
; ****************************************

clearLines              SUBROUTINE

                        lda #0
                        sta .rowIndex
                        sta .clearCount
                        lda #1
                        sta .boardIndex

.rowLoop                ldx .boardIndex

                        ldy #10
.columnLoop             lda board.DataStart,x
                        beq .nextRow
                        inx
                        dey
                        bne .columnLoop

                        inc .clearCount
                        lda #$01                ; Fill row for blinking animation
                        sta TileNum
                        lda #11
                        sta TileX
                        lda .rowIndex
                        sta TileY
                        lda #10
                        sta .sprIndex
.fillLoop               jsr DrawTile
                        dec TileX
                        dec .sprIndex
                        bne .fillLoop

                        lda .boardIndex         ; Update board data (shift down one row)
                        sta .copyIndex
.copyRowLoop            lda .copyIndex
                        sta .targetIndex
                        sec
                        sbc #BOARD_DATA_WIDTH
                        sta .sourceIndex
                        ldy #10
.copyColumnLoop         ldx .sourceIndex
                        lda board.DataStart,x
                        ldx .targetIndex
                        sta board.DataStart,x
                        inc .sourceIndex
                        inc .targetIndex
                        dey
                        bne .copyColumnLoop
                        lda .copyIndex
                        sec
                        sbc #BOARD_DATA_WIDTH
                        sta .copyIndex
                        cmp #1
                        bne .copyRowLoop

.nextRow                lda .rowIndex
                        cmp #17
                        beq .endPaint
                        inc .rowIndex
                        lda .boardIndex
                        clc
                        adc #BOARD_DATA_WIDTH
                        sta .boardIndex
                        jmp .rowLoop

.endPaint
                        sed
                        clc
                        lda state.drops
                        adc dropScore
                        sta state.drops
                        lda state.drops+1
                        adc #0
                        sta state.drops+1
                        lda state.drops+2
                        adc #0
                        sta state.drops+2
                        cld

                        jsr state.TryAddDrops
                        lda .clearCount
                        beq .noLinesCleared

                        jsr state.updateScores

                        lda .clearCount
                        cmp #4
                        bne .normalClear
                        PLAY_SOUND_CORE soundEffect.Tetris, sound.MODE_NO_PHASE, sound.PRIORITY_HIGH
                        jmp .startFlash
.normalClear
                        PLAY_SOUND soundEffect.Clear
.startFlash
                        lda #4
                        sta .flashCount
.flashLoop              dec .flashCount
                        jsr screen.Toggle
                        WAIT 10
                        lda #0
.flashCount             EQU *-1
                        bne .flashLoop

                        jsr screen.Toggle
                        jsr state.reloadBoard
                        jsr screen.Toggle
                        jsr state.reloadBoard

                        lda state.queueLevelSound
                        beq .normalClunk
                        PLAY_SOUND_CORE soundEffect.Level, sound.MODE_NO_PHASE, sound.PRIORITY_HIGH
                        lda #0
                        sta state.queueLevelSound
                        beq .checkGameBEnd
.normalClunk
                        PLAY_SOUND soundEffect.Drop
.checkGameBEnd
                        jsr game.checkBTypeGameEnd
                        rts
.noLinesCleared
                        jsr screen.Toggle
                        jsr state.reloadScores
                        jsr screen.Toggle
                        jsr state.reloadScores
                        rts

.clearCount             DC.B 0
.rowIndex               DC.B 0
.boardIndex             DC.B 0
.sprIndex               DC.B 0
.copyIndex              DC.B 0
.targetIndex            DC.B 0
.sourceIndex            DC.B 0

; -----------------------------------------------------------------------------
; game.checkBTypeGameEnd
; -----------------------------------------------------------------------------

game.checkBTypeGameEnd SUBROUTINE
                        bit zp.Flags
                        bvs .gameB
                        rts
.gameB
                        lda state.lines
                        bne .end
                        pla
                        pla
                        pla
                        pla
                        NEXT_STATE= dancers
.end
                        rts

; ****************************************
; tryRotateCCW
; ****************************************

tryRotateCCW            SUBROUTINE
                        SEG.U ZEROPAGE
.oldValue               DS.B 1
                        SEG PROGRAM

                        lda pcRot
                        sta .oldValue
                        dec pcRot
                        lda pcRot
                        and #3
                        sta pcRot
                        jsr checkCollision
                        bne .fail
                        PLAY_SOUND soundEffect.Turn
                        inc needsRedraw
                        rts
.fail                   lda .oldValue
                        sta pcRot
.end                    rts

; ****************************************
; tryRotateCW
; ****************************************

tryRotateCW             SUBROUTINE
                        SEG.U ZEROPAGE
.oldValue               DS.B 1
                        SEG PROGRAM

                        lda pcRot
                        sta .oldValue
                        inc pcRot
                        lda pcRot
                        and #3
                        sta pcRot
                        jsr checkCollision
                        bne .fail
                        PLAY_SOUND soundEffect.Turn
                        inc needsRedraw
                        rts
.fail                   lda .oldValue
                        sta pcRot
.end                    rts

; ****************************************
; tryMoveLeft
; ****************************************

tryMoveLeft             SUBROUTINE
                        dec pcX
                        jsr checkCollision
                        bne .fail
                        PLAY_SOUND soundEffect.Move
                        inc needsRedraw
                        rts
.fail                   inc pcX
.end                    rts

; ****************************************
; tryMoveRight
; ****************************************

tryMoveRight            SUBROUTINE
                        inc pcX
                        jsr checkCollision
                        bne .fail
                        PLAY_SOUND soundEffect.Move
                        inc needsRedraw
                        rts
.fail                   dec pcX
.end                    rts

; ****************************************
; tryMoveDown
; ****************************************

tryMoveDown             SUBROUTINE
                        inc pcY
                        jsr checkCollision
                        bne .fail
                        inc zp.RandomSeed
                        lda dropSpeed
                        sta dropCounter
                        sta state.initialDropDone
                        inc needsRedraw
                        rts
.fail                   dec pcY
                        pla
                        pla
                        jmp placePiece

; ****************************************
; checkCollision
; ****************************************
; Compares piece pattern (zp.PieceGridL/H),pieceIndex to board,boardIndex
; Return something

checkCollision          SUBROUTINE
                        SEG.U ZEROPAGE
.count                  DS.B 1
                        SEG PROGRAM

                        clc
                        lda pcY
                        adc #4                  ; Bottom row of piece grid
                        tay
                        lda #0
.rowLoop                dey
                        beq .end
                        adc #BOARD_DATA_WIDTH
                        bne .rowLoop            ; Unconditional branch
.end                    adc pcX                 ; Add column of piece (base is 2)
                        adc #2                  ; Piece column 0 out of phase with board coordinates by +2
                        tax
                        ldy pcRot
                        lda tetrominos.Rotation,y
                        clc
                        adc #$0f
                        tay
                        lda #4
                        sta .count

                        mac CmpBoard
                        lda (zp.PieceGridL),y
                        beq .cont
                        lda board.DataStart,x
                        bne endCollision
.cont                   dey
                        dex
                        endm

.cmpLoop                REPEAT 4
                        CmpBoard
                        REPEND

                        dec .count
                        beq .noCollide
                        txa
                        sec
                        sbc #BOARD_DATA_WIDTH
                        clc
                        adc #4
                        tax
                        bne .cmpLoop            ; Unconditional branch

.noCollide              lda #0
endCollision            rts

; ****************************************
; pcKeep
; ****************************************

pcKeep                  SUBROUTINE
                        SEG.U ZEROPAGE
.count                  DS.B 1
                        SEG PROGRAM

                        jsr pcClear
                        jsr pcDraw
                        lda #$ff
                        sta pcX_o1
                        sta pcX_o2

                        clc
                        lda pcY
                        adc #4                  ; Bottom row of piece grid
                        tay
                        lda #0
.rowLoop                dey
                        beq .end
                        adc #BOARD_DATA_WIDTH
                        bne .rowLoop            ; Unconditional branch
.end                    adc pcX                 ; Add column of piece (base is 2)
                        adc #2                  ; Piece column 0 out of phase with board coordinates by +2
                        tax
                        ldy pcRot
                        lda tetrominos.Rotation,y
                        clc
                        adc #$0f
                        tay
                        lda #4
                        sta .count

                        mac KeepBoard
                        lda (zp.PieceGridL),y
                        beq .cont
                        sta board.DataStart,x
.cont                   dey
                        dex
                        endm

.cmpLoop                REPEAT 4
                        KeepBoard
                        REPEND

                        dec .count
                        beq .noCollide
                        txa
                        sec
                        sbc #BOARD_DATA_WIDTH
                        adc #3
                        tax
                        bne .cmpLoop            ; Unconditional branch

.noCollide              lda #0
                        rts

; ****************************************
; pcClear
; ****************************************
; Erase piece (pcNum) with rotation (pcRot) at (pcX,pcY) on page gfxPage.

pcX_o1                  DC.B $ff
pcY_o1                  DC.B $ff
pcStartIndex_o1         DC.B $ff
pcEndIndex_o1           DC.B $ff
pieceGridL_o1           DC.B $ff
pieceGridH_o1           DC.B $ff

pcX_o2                  DC.B $ff
pcY_o2                  DC.B $ff
pcStartIndex_o2         DC.B $ff
pcEndIndex_o2           DC.B $ff
pieceGridL_o2           DC.B $ff
pieceGridH_o2           DC.B $ff

pcClear                 SUBROUTINE
                        lda pcX_o2
                        bpl .okay
                        rts
.okay                   sta TileX
                        lda pcY_o2
                        sta TileY
                        lda pieceGridL_o2
                        sta zp.PieceGridL
                        lda pieceGridH_o2
                        sta zp.PieceGridH
                        lda pcStartIndex_o2
                        sta zp.PieceIndex
                        lda #BACKGROUND_TILE
                        sta TileNum

.rowLoop
                        mac PcClearSprite
                        ldy zp.PieceIndex
                        lda (zp.PieceGridL),y
                        beq .skip
                        jsr DrawTile
.skip                   inc TileX
                        inc zp.PieceIndex
                        endm

                        REPEAT 4
                        PcClearSprite
                        REPEND

                        lda pcEndIndex_o2
                        cmp zp.PieceIndex
                        beq .out
                        sec
                        lda TileX
                        sbc #4
                        sta TileX
                        inc TileY
                        jmp .rowLoop
.out

                        rts


; ****************************************
; pcDraw
; ****************************************
; Draw a piece (pcNum) with rotation (pcRot) at (pcX,pcY) on page gfxPage.

pcNum                   DC.B
pcRot                   DC.B
pcX                     DC.B
pcY                     DC.B
pcStartIndex            DC.B
pcEndIndex              DC.B
pcOpaque                DC.B

pcDraw                  SUBROUTINE
                        SEG.U ZEROPAGE
.columnCount            DS.B 1
                        SEG PROGRAM

                        lda pcOpaque            ; Preview pieces need opaque border
                        beq .transparent        ; If zero, then border (white) is transparent
                        lda #$30                ; self-modifying... BMI - should always branch (tiles must not have neg bit set)
                        bne .continue

.transparent            lda #$F0                ; self-modifying... BEQ - branches if tile is $00

.continue               sta .modify

                        lda pcX_o1
                        sta pcX_o2
                        lda pcY_o1
                        sta pcY_o2
                        lda pcStartIndex_o1
                        sta pcStartIndex_o2
                        lda pcEndIndex_o1
                        sta pcEndIndex_o2
                        lda pieceGridL_o1
                        sta pieceGridL_o2
                        lda pieceGridH_o1
                        sta pieceGridH_o2

                        lda pcX
                        sta pcX_o1
                        sta TileX
                        lda pcY
                        sta pcY_o1
                        sta TileY
                        lda pcNum               ; Convert pcNum to address stored in .pieceGridL
                        asl                     ; piecesIndexes is a table of words, so pcNum *= 2
                        tay
                        lda tetrominos.Tab,y
                        sta zp.PieceGridL
                        sta pieceGridL_o1
                        lda tetrominos.Tab+1,y
                        sta zp.PieceGridH
                        sta pieceGridH_o1
                        ldy pcRot               ; Convert pcRot (0-3) to an offset stored in .index
                        lda tetrominos.Rotation,y    ; tetrominos.Rotation table
                        sta zp.PieceIndex
                        sta pcStartIndex
                        sta pcStartIndex_o1
                        clc                     ; Compute pcEndIndex by adding 16
                        adc #$10
                        sta pcEndIndex
                        sta pcEndIndex_o1

.rowLoop
                        lda #$04
                        sta .columnCount

.columnLoop
                        ldy zp.PieceIndex
                        lda (zp.PieceGridL),y
.modify                 beq .skip
                        sta TileNum
                        jsr DrawTile
.skip                   inc TileX
                        inc zp.PieceIndex
                        dec .columnCount
                        bne .columnLoop

                        lda pcEndIndex
                        cmp zp.PieceIndex
                        beq .out
                        sec
                        lda TileX
                        sbc #4
                        sta TileX
                        inc TileY
                        jmp .rowLoop
.out
                        rts

; ****************************************
; Select Next Piece
; ****************************************

currentPiece            DC.B
previewPiece            DC.B

getNextPiece            SUBROUTINE
                        ldy #3
.loop                   jsr prng.Cycle
                        and #%00000111
                        cmp #%00000111
                        bne .noShift
                        asl
                        and #%00000111
.noShift                sta .candidate
                        ora currentPiece
                        ora previewPiece
                        cmp .candidate
                        bne .good
                        dey
                        bne .loop
.good                   lda previewPiece
                        sta currentPiece
                        lda .candidate
                        sta previewPiece
                        rts

.candidate              DC.B
