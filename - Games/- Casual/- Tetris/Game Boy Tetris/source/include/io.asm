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

KBD                     EQU $C000
KBDSTRB                 EQU $C010
VBLANK                  EQU $C019
SPKR                    EQU $C030
TXTCLR                  EQU $C050
TXTSET                  EQU $C051
MIXCLR                  EQU $C052
LOWSCR                  EQU $C054
HISCR                   EQU $C055
HIRES                   EQU $C057
RDBTN0                  EQU $C061
BUTN1                   EQU $C062
PADDL0                  EQU $C064
PADDL1                  EQU $C065

PREAD                   EQU $FB1E
MON_HOME                EQU $FC58
COUT                    EQU $FDED
