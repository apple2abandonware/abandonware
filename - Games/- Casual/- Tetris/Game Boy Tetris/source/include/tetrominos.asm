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

tetrominos.Tab                                  ; Base addresses for each tetromino
.index                  SET tetrominos.Data
                        REPEAT 7
                        dc.w .index
.index                  SET .index + 64
                        REPEND

; -----------------------------------------------------------------------------

tetrominos.Rotation                             ; Rotation offset (added to base addr)
                        DC.B $00
                        DC.B $10
                        DC.B $20
                        DC.B $30

; -----------------------------------------------------------------------------

tetrominos.Data
                        INCLUDE "__gfx_tet_L_raw.asm"
                        INCLUDE "__gfx_tet_J_raw.asm"
                        INCLUDE "__gfx_tet_I_raw.asm"
                        INCLUDE "__gfx_tet_O_raw.asm"
                        INCLUDE "__gfx_tet_Z_raw.asm"
                        INCLUDE "__gfx_tet_S_raw.asm"
                        INCLUDE "__gfx_tet_T_raw.asm"
