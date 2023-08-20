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

MAX_LEVEL               EQU $20                 ; BCD maximum level

; -----------------------------------------------------------------------------

PUBLIC_ALPHA            EQU 0                   ; Limited functionality for alpha releases

; -----------------------------------------------------------------------------

screen.OFFSET_Y         EQU #3                  ; Coarse vertical offset (0-6)
screen.COARSE_OFFSET_X  EQU #8                  ; Coarse horizontal offset (0-17 bytes (* 7 pixels))
screen.FINE_OFFSET_X    EQU #3                  ; Fine horizontal offset (0-6 pixels)

; -----------------------------------------------------------------------------

flags.GFX_PAGE_MASK     EQU %10000000
flags.GAME_A_BIT        EQU %10111111
flags.GAME_B_BIT        EQU %01000000
flags.MUSIC_MASK        EQU %00000011

; -----------------------------------------------------------------------------

BOARD_WIDTH             EQU 10
BOARD_HEIGHT            EQU 18
BOARD_DATA_WIDTH        EQU BOARD_WIDTH + 2     ; + sides
BOARD_DATA_HEIGHT       EQU BOARD_HEIGHT + 1    ; + bottom
BOARD_LENGTH            EQU BOARD_DATA_WIDTH * BOARD_DATA_HEIGHT

                        SEG.U TRAILING_DATA
board.DataStart         DS.B BOARD_LENGTH
board.DataEnd
                        SEG PROGRAM

; -----------------------------------------------------------------------------

BACKGROUND_TILE         EQU $00

; -----------------------------------------------------------------------------

TONE_DURATION           EQU 7

; -----------------------------------------------------------------------------

CRLF                    EQU $ff
EOL                     EQU $fe

; -----------------------------------------------------------------------------

CURSOR_BLINK_SPEED      EQU 10
