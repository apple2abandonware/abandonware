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

soundEffect.Turn        DC.B 239,82,255,124,239,82,255,124,239,82,239,77
soundEffect.TurnLen     EQU *-soundEffect.Turn

; -----------------------------------------------------------------------------

soundEffect.Move        DC.B 100
soundEffect.MoveLen     EQU *-soundEffect.Move

; -----------------------------------------------------------------------------

soundEffect.Menu        DC.B 124,124,124
soundEffect.MenuLen     EQU *-soundEffect.Menu

; -----------------------------------------------------------------------------

soundEffect.Select      DC.B 82,82
soundEffect.SelectLen   EQU *-soundEffect.Select

; -----------------------------------------------------------------------------

soundEffect.Score       DC.B 82
soundEffect.ScoreLen    EQU *-soundEffect.Score

; -----------------------------------------------------------------------------

soundEffect.Level       DC.B 82,82,0,0,0,39,39,0,0,0,55,55,0,0,0,65,65,0,0,0,82,82
soundEffect.LevelLen    EQU [*-soundEffect.Level]

; -----------------------------------------------------------------------------

soundEffect.Tetris      DC.B 150,140,130,120,100,110,120,130,110,110,70,80,90
                        DC.B 100,110,0,52,52,0,0,39,39,0,0,52,52,0,0,39,39
soundEffect.TetrisLen   EQU [*-soundEffect.Tetris]

; -----------------------------------------------------------------------------

soundEffect.Drop        DC.B 255,245,255,235,255,215,255
soundEffect.DropLen     EQU *-soundEffect.Drop

; -----------------------------------------------------------------------------

.low                    EQU 81
.high                   EQU [.low / 2]
soundEffect.Pause       DC.B .high,.high,0,0,0,.low,.low,0,0,0,.high,.high,0,0,0,.low,.low
soundEffect.PauseLen    EQU *-soundEffect.Pause

; -----------------------------------------------------------------------------

soundEffect.Clear SUBROUTINE
.count                  EQU 5
.duration               EQU 7
.bigStep                EQU 20
.smallStep              EQU 10
.start                  EQU 255 - (.count * .bigStep) - (.duration * .smallStep)

.freq                   SET .start
                        REPEAT .count
.f                      SET .freq
                        REPEAT .duration
                        DC.B .f
.f                      SET .f + .smallStep
                        REPEND
.freq                   SET .freq + .bigStep
                        REPEND
soundEffect.ClearLen    EQU *-soundEffect.Clear
