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

                        PROCESSOR 6502
                        INCLUDE "version.txt"
                        INCLUDE "io.asm"
                        INCLUDE "io_macros.asm"
                        INCLUDE "kernel_macros.asm"
                        INCLUDE "input_macros.asm"
                        INCLUDE "digits_macros.asm"
                        INCLUDE "state_machine_macros.asm"
                        INCLUDE "state_macros.asm"
                        INCLUDE "sound_macros.asm"
                        INCLUDE "music_macros.asm"
                        INCLUDE "debug_macros.asm"
                        INCLUDE "sleep_macros.asm"
                        INCLUDE "xasm_macros.asm"

gbt.BINARY_MAX_SIZE     EQU $7FFF               ; DOS 3.3 max file size (for reasons, I guess)

; -----------------------------------------------------------------------------

                        SEG.U ZEROPAGE          ; You are my sunshine
                        ORG $00

; -----------------------------------------------------------------------------

gbt.DATA_START          EQU $300                ; Uninitialized DATA segment between GETLN buffer...
gbt.DATA_MAX_SIZE       EQU $400 - gbt.DATA_START  ; and text page 1
gbt.DATA_LENGTH         EQU gbt.DATA_END - gbt.DATA_START
gbt.DATA_BYTES_FREE     EQU gbt.DATA_MAX_SIZE - gbt.DATA_LENGTH

                        SEG.U DATA              ; Keeps things tidy and reduces filesize
                        ORG gbt.DATA_START

; -----------------------------------------------------------------------------

                        SEG.U TRAILING_DATA     ; Memory consumed after the main program
                        ORG gbt.COPY_DEST_END

; -----------------------------------------------------------------------------

gbt.PROGRAM_START       EQU $800                ; PROGRAM segment after text page 1
gbt.PROGRAM_MAX_SIZE    EQU gbt.BINARY_MAX_SIZE ; I was trying to keep this below the DOS buffer ($9600), but DOS said no
gbt.PROGRAM_LENGTH      EQU gbt.PROGRAM_END - gbt.PROGRAM_START
gbt.PROGRAM_BYTES_FREE  EQU gbt.PROGRAM_MAX_SIZE - gbt.PROGRAM_LENGTH + gbt.WASTED_SPACE

                        SEG PROGRAM
                        ORG gbt.PROGRAM_START

; -----------------------------------------------------------------------------

gbt.WASTED_SPACE        EQU $2000-gbt.COPY_SRC_START ; The space before HGR page 1, leftover after the mem copy

; -----------------------------------------------------------------------------

                        ECHO ""
                        ECHO "G A M E B O Y   T E T R I S"
                        ECHO "Apple II port by Lee Fastenau (thelbane@gmail.com)"
                        ECHO "https://github.com/thelbane/gb-tetris"
                        ECHO ""
                        ECHO "]CALL", [entry.WarmStart]d, "(", entry.WarmStart ,")"
                        ECHO "Zero Page:", [gbt.ZEROPAGE_END]d, "bytes used"
                        ECHO "Data Segment: (", gbt.DATA_START, "-", gbt.DATA_END, ")", [gbt.DATA_LENGTH]d, "bytes used,", [gbt.DATA_BYTES_FREE]d , "bytes free"
                        ECHO "Program Segment: (", gbt.PROGRAM_START, "-", gbt.PROGRAM_END, ")", [gbt.PROGRAM_LENGTH]d, "disk bytes used,", [gbt.PROGRAM_BYTES_FREE]d , "disk bytes free"
                        ECHO "Board Location: (", board.DataStart, "-", board.DataEnd, ")", [BOARD_LENGTH]d, "bytes"
                        ECHO "High Scores Location: (", highscore.DATA, "-", highscore.DATA_END, ")", [highscore.DATA_LENGTH]d, "bytes"
                        ECHO "Inflate Data Location: (", inflate_data, "-", inflate_data_end, ")", [inflate_data_end-inflate_data]d, "bytes"
                        ECHO "Program Split:", gbt.COPY_SRC_START, "(Gfx Page 1 Gap:", [gbt.WASTED_SPACE]d, "bytes)"
                        ECHO "Distance to $C000:", [$c000 - gbt.TRAILING_DATA_END]d, "bytes"

                        IF gbt.WASTED_SPACE < 0
                                ECHO "🛑 FATAL: gbt.WASTED_SPACE must be >= 0, try moving gbt.COPY_SRC_START up."

                        EIF

; -----------------------------------------------------------------------------

                        jmp entry.ColdStart

; -----------------------------------------------------------------------------

                MAC LINCLUDE
LSTART                  SET *
                        INCLUDE {1}
LLEN                    SET *-LSTART
                        IF 0
                                ECHO LSTART, [LLEN]d, {1}
                        ENDIF
                ENDM

                        LINCLUDE "constants.asm"
                        LINCLUDE "applesoft_tokens.asm"
                        LINCLUDE "entry.asm"
                        LINCLUDE "zeropage.asm"

                        LINCLUDE "kernel.asm"
                        LINCLUDE "electric_duet.asm"
                        LINCLUDE "state_machine.asm"
                        LINCLUDE "state_init.asm"
                        LINCLUDE "write_tile.asm"
                        LINCLUDE "copy.asm"
                        LINCLUDE "music.asm"
                        LINCLUDE "sound.asm"
                        LINCLUDE "sound_effects.asm"
                        LINCLUDE "select_music.asm"
                        LINCLUDE "select_gameType.asm"
                        LINCLUDE "select_level.asm"
                        LINCLUDE "select_high.asm"
                        LINCLUDE "screen.asm"
                        LINCLUDE "tetrominos.asm"
                        LINCLUDE "prng.asm"
                        LINCLUDE "input.asm"
                        LINCLUDE "joystick.asm"
                        LINCLUDE "levels.asm"
                        LINCLUDE "glitch.asm"
                        LINCLUDE "state_gameOver.asm"

gbt.COPY_SRC_START      EQU *
                        ECHO "------ split at",gbt.COPY_SRC_START,[gbt.WASTED_SPACE]d,"bytes wasted ------"
                        RORG $5277 ; inflate+splash_screen length
gbt.COPY_DEST_START     EQU *
                        LINCLUDE "inflate.asm"
                        LINCLUDE "splash_screen.asm"
                        IF * != $6000
                                ECHO "🛑 FATAL: Set gbt.COPY_DEST_START to", $6000-[*-gbt.COPY_DEST_START]
                                ERR
                        EIF

                        LINCLUDE "selector.asm"         ;after sound_effects
                        LINCLUDE "digits.asm"
                        LINCLUDE "state.asm"
                        LINCLUDE "state_game.asm"
                        LINCLUDE "state_credits.asm"
                        LINCLUDE "state_title.asm"
                        LINCLUDE "state_options.asm"
                        LINCLUDE "state_optionsAType.asm"
                        LINCLUDE "state_optionsBType.asm"
                        LINCLUDE "state_scoreTally.asm"
                        LINCLUDE "state_dancers.asm"
                        LINCLUDE "state_rockets.asm"
                        LINCLUDE "state_highScore.asm"
                        LINCLUDE "state_nil.asm"
                        LINCLUDE "view_title.asm"
                        LINCLUDE "view_options.asm"
                        LINCLUDE "view_game.asm"
                        LINCLUDE "view_gameover.asm"
                        LINCLUDE "view_pause.asm"
                        LINCLUDE "view_rockets.asm"
                        LINCLUDE "view_dancers.asm"
                        LINCLUDE "highscore.asm"
                        LINCLUDE "char.asm"
                        LINCLUDE "gfx.asm"
                        LINCLUDE "tunes.asm"

                IFCONST debug.INCLUDE_DEBUG
                        LINCLUDE "debug.asm"
                EIF

gbt.COPY_DEST_END       EQU *
                        REND
gbt.COPY_SRC_END        EQU *

; -----------------------------------------------------------------------------

                        SEG PROGRAM
gbt.PROGRAM_END         EQU *

; -----------------------------------------------------------------------------

                        SEG.U ZEROPAGE
gbt.ZEROPAGE_END        EQU *

; -----------------------------------------------------------------------------

                        SEG.U DATA
gbt.DATA_END            EQU *

; -----------------------------------------------------------------------------

                        SEG.U TRAILING_DATA
gbt.TRAILING_DATA_END   EQU *

