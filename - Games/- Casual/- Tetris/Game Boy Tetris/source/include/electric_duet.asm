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
; Portions of this file copyright © 1979-2015 by Paul Lutus
; http://arachnoid.com/administration
;
; This program is free software; you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation; either version 2 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with this program; if not, write to the
; Free Software Foundation, Inc.,
; 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
; Modification for GB Tetris by Lee Fastenau
;
; I strongly recommend going directly to the source if you want to use this
; routine in your own project. All of the modifications I've made are specific
; to GB Tetris.
;
; Original: https://arachnoid.com/electric_duet/index.html
; -----------------------------------------------------------------------------


INST_EOR                EQU $49
INST_CMP                EQU $c9

                        SEG.U ZEROPAGE
MusicL                  DS.B 1                  ; Current entry address
MusicH                  DS.B 1                  ; These two bytes must be initialized to the beginning of the song before playing
Note1                   DS.B 1
Note2                   DS.B 1
ZP6                     DS.B 1
ZP7                     DS.B 1
Duration                DS.B 1
                        SEG PROGRAM


; -----------------------------------------------------------------------------
; ElecDuet
; -----------------------------------------------------------------------------
; Inputs: none

ElecDuet SUBROUTINE
                        lda #$01                ; 2 *!*         Initialize some stuff...
                        pha                     ; 3             Seed the stack (used later to pop and push A, X, and Y)
                        pha                     ; 3
                        pha                     ; 3
                        bne .readFirstByte      ; 4 *!*         Unconditional branch to read the first note
.changeVoice
                        iny                     ; 2
                        lda (MusicL),Y          ; 5 *!*
                        iny                     ; 2
                        lda (MusicL),Y          ; 5 *!*
.nextEntry
                        lda MusicL              ; 3 *!*         Increment the music entry pointer by 3 and then read the next entry
                        clc                     ; 2
                        adc #$03                ; 2 *!*
                        sta MusicL              ; 3
                        bcc .readFirstByte      ; 4 *!*
                        inc MusicH              ; 5
.readFirstByte
                        ldy #$FF
                        jmp .setDuration

.readNote
                        ldx #INST_EOR           ; 2 *!*         Instruction code for EOR (prep for self-modifying magic on .checkNote1/.checkNote2)
                        iny                     ; 2
                        lda (MusicL),Y          ; 5 *!*         Read second or third byte (Y = 1 or 2)
                        bne .return             ; 4 *!*         Is it a note? (A > 0, X = EOR)
                        ldx #INST_CMP           ; 2 *!*         No, it's a rest. (A = 0, X = CMP)
.return
                        rts                     ; 6
.setDuration
                        lda #02                 ;               Note duration (self-modifying)
music.TickDuration_SMC  equ *-1
                        sta Duration            ; 3
                        jsr .readNote           ; 6             Read Note1, A = 0 (rest), or 1-255 (note), X =.checkNote1 code CMP (rest) or EOR (note)
                        stx .checkNote1         ; 4             Modify code
                        sta Note1               ; 3
                        ;ldx Voice1             ; 3 *!*
                        ldx #1                  ; 3 *!*
.calcFactor1
                        lsr                     ; 2             Divide Note1 by 2^Voice1
                        dex                     ; 2
                        bne .calcFactor1        ; 4 *!*
                        sta .voiceFactor1       ; 4             Store calculated factor (self-modifying code)
                        jsr .readNote           ; 6             Read Note2, A = 0 (rest), or 1-255 (note), X =.checkNote1 code CMP (rest) or EOR (note)
                        stx .checkNote2         ; 4             Modify code
                        sta Note2               ; 3
                        ;ldx Voice2             ; 3 *!*
                        ldx #3                  ; 3 *!*
.calcFactor2
                        lsr                     ; 2             Divide Note2 by 2^Voice2
                        dex                     ; 2
                        bne .calcFactor2        ; 4 *!*
                        sta .voiceFactor2       ; 4             Store calculated factor (self-modifying code)
                        pla                     ; 4             Pop A, X, and Y
                        tay                     ; 2
                        pla                     ; 4
                        tax                     ; 2
                        pla                     ; 4
                        bne .skipClick1         ; 4 *!*         First time through, A=1, so this will branch
.click1
                        bit SPKR                ; 4
ed.Spkr1_SMC            equ *-2

.skipClick1
                        cmp #$00                ; 2             I'm going to be real with you, the rest of this is pure timing magic.
                        bmi .click2             ; 4 *!*         Much respect to Paul Lutus for figuring this out...
                        nop                     ; 2             Someone with greater disassembling fortitude than I can help with the rest.
                        bpl .skipClick2         ; 4 *!*
.click2
                        bit SPKR                ; 4
ed.Spkr2_SMC            equ *-2

.skipClick2
                        sta ZP6                 ; 3
                        bit KBD                 ; 4             For the in-game music, we want the full note to play without keyboard interruption
                        nop                     ; 2             And waste two cycles instead
                        dey                     ; 2
                        bne .label14            ; 4 *!*
                        beq .label15            ; 4 *!*
.label14
                        cpy #$00                ; 2

.voiceFactor1           EQU *-1                 ; self-modifying

                        beq .checkNote1         ; 4 *!*
                        bne .label16            ; 4 *!*
.label15
                        ldy Note1               ; 3 *!*
.checkNote1
                        eor #$40                ; 2 *!*         EOR if Note1 is a note, else CMP if rest
.label16
                        bit ZP6                 ; 3
                        bvc .label17            ; 4 *!*
                        bvs .label18            ; 4 *!*
.label18
                        bpl .label19            ; 4 *!*
                        nop                     ; 2
                        bmi .label20            ; 4 *!*
.label17
                        nop                     ; 2
                        bmi .label19            ; 4 *!*
                        nop                     ; 2
                        bpl .label20            ; 4 *!*
.label19
                        cmp SPKR                ; 4
ed.Spkr3_SMC            equ *-2

.label20
                        dec ZP7                 ; 5
                        bne .label21            ; 4 *!*
                        dec Duration            ; 5
                        bne .label21            ; 4 *!*
                        bvc .skipClick3         ; 4 *!*
                        bit SPKR                ; 4
ed.Spkr4_SMC            equ *-2

.skipClick3
                        ;pha                     ; 3
                        ;txa                     ; 2
                        ;pha                     ; 3
                        ;tya                     ; 2
                        ;pha                     ; 3
                        ;jmp .nextEntry          ; 3
                        rts
.label21
                        dex                     ; 2
                        bne .label24            ; 4 *!*
                        beq .label25            ; 4 *!*
.label24
                        cpx #$00                ; 2

.voiceFactor2           EQU *-1                 ; self-modifying

                        beq .checkNote2         ; 4 *!*
                        bne .label26            ; 4 *!*
.label25
                        ldx Note2               ; 3 *!*
.checkNote2
                        eor #$80                ; 2 *!*         EOR if Note2 is a note, else CMP if rest
.label26
                        bvs .click1             ; 4 *!*         Note2 is a note
                        nop                     ; 2
                        bvc .skipClick1         ; 4 *!*         Note2 is a rest
