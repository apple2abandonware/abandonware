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
; sound.Play
; -----------------------------------------------------------------------------
; Inputs: A - Wait interval

sound.Play SUBROUTINE
                        SEG.U DATA
sound.Length            DS.B 1
                        SEG PROGRAM

                        pha
                        lda zp.SoundIndex
                        beq .noCurrentSound
                        pla
                        cmp sound.Priority
                        bpl .play
                        bmi .skip
.noCurrentSound
                        pla
.play
                        sta sound.Priority
                        lda sound.Length
                        sta zp.SoundIndex
                        stx zp.SoundL
                        sty zp.SoundH
                        lda #sound.MODE_PHASE
                        sta skipPhase_SMC
.skip
                        rts

; -----------------------------------------------------------------------------
; sound.Enable
; -----------------------------------------------------------------------------
; Inputs: none

sound.Enable SUBROUTINE
                        lda #$30
                        jmp sound.SetAll

; -----------------------------------------------------------------------------
; sound.Toggle
; -----------------------------------------------------------------------------
; Inputs: none

sound.Toggle SUBROUTINE
                        lda sound.Spkr1_SMC
                        eor #$10                ; Thanks for this suggestion, Sellam!
                        jsr sound.SetAll
                        cmp #$30
                        bne .notEnabling
                        ldx #$10                ; Play a "tick" sound when enabling
.durLoop
                        ldy #$20
.freqLoop
                        dey
                        bne .freqLoop
                        bit SPKR
                        dex
                        bne .durLoop
.notEnabling
                        rts

; -----------------------------------------------------------------------------
; sound.SetAll
; -----------------------------------------------------------------------------
; Inputs: A - Low bit of SPKR/TAPEOUT address (e.g., #$30 or #$20)

sound.SetAll SUBROUTINE
                        sta sound.Spkr1_SMC
                        sta sound.Spkr2_SMC
                        sta ed.Spkr1_SMC
                        sta ed.Spkr2_SMC
                        sta ed.Spkr3_SMC
                        sta ed.Spkr4_SMC
                        rts


; -----------------------------------------------------------------------------
; sound.Tick
; -----------------------------------------------------------------------------
; Inputs: none

sound.Tick SUBROUTINE
                        SEG.U DATA
sound.MusicIsPlaying    DS.B 1
sound.MusicTimer        DS.B 1
sound.MusicTick         DS.B 1
sound.MusicDelay        DS.B 1
sound.MusicDelay2       DS.B 1
sound.Priority          DS.B 1
                        SEG PROGRAM

                        lda sound.MusicIsPlaying
                        bne .tryMusic
                        jmp .playEffect
.tryMusic 
                        lda #0
                        sta zp.SoundIndex
                        lda #$0A
                        sec
                        sbc sound.MusicDelay2
                        bmi .skipDelay

                        tay
                        iny
.wait1a                 ldx #$FF
.wait2a                 dex
                        bne .wait2a
                        dey
                        bne .wait1a

.skipDelay
                        ldy sound.MusicDelay
                        sty sound.MusicDelay2
                        ldy #0
                        sty sound.MusicDelay
                        inc sound.MusicTick
                        lda sound.MusicTick
                        cmp #1
                        beq .playTick

                        ldy #$08
.wait1                  ldx #$FF
.wait2                  dex
                        bne .wait2
                        
                        dey
                        bne .wait1
                        rts

.playTick
                        lda #0
                        sta sound.MusicTick
                        lda #$EA                ; NOP
                        sta .playMusic_SMC
.incrementMusic
                        dec sound.MusicTimer
                        bne .playMusic_SMC
                        lda #1
noteDuration_SMC        EQU *-1
                        sta sound.MusicTimer
.nextNote
                        clc                     ; Increment the music entry pointer by 3 and then read the next entry
                        lda #2
                        adc MusicL
                        sta MusicL             
                        lda #0
                        adc MusicH
                        sta MusicH

                        ldy #0
                        lda (MusicL),y


                        cmp #$FF                ; Has the tune ended?
                        bne .playMusic_SMC

                        iny
                        lda (MusicL),y
                        beq .stopPlaying
                        jsr music.RestartTune 
                        jmp .nextNote           ; Skip over first two values
.stopPlaying
                        STOP_TUNE a
                        rts

.playMusic_SMC
                        rts                     ; self-modifying RTS or NOP
                        jmp ElecDuet
.playEffect
                        ldy zp.SoundIndex
                        beq .silence
                        beq .skipPhase          ; Unconditional jump to either 
skipPhase_SMC           EQU *-2                 ; $d0 = BNE (no phase), $f0 = BEQ (phase)
                        sty .soundPhase_SMC
                        asl .soundPhase_SMC
                        asl .soundPhase_SMC
                        jmp .phaseDone
.skipPhase
                        lda #$10
                        sta .soundPhase_SMC
.phaseDone
                        dey
                        sty zp.SoundIndex
                        lda (zp.SoundL),y
                        beq .silence
                        sta .freq
                        tax
                        lda sound.DurationsTab,x
                        tax
                                                ;      outer inner
.outer                  ldy #0                  ; +2   2
.freq                   EQU *-1
.inner_SMC              dey                     ; +2         2
                        cpy #5                  ; +2         4
.soundPhase_SMC         EQU *-1
                        bne .next               ; +2/3       6 /7
                        lda $C050
sound.Glitch_SMC        equ *-2
                        lda SPKR                ; +2         8 /7
sound.Spkr1_SMC         equ *-2

.next                   cpy #0                  ; +2         10/9
                        bne .inner_SMC          ; +2/3       12/12 (2 only once per inner loop, else 3)
                        lda $C050
                        lda SPKR                ; +2   4
sound.Spkr2_SMC         equ *-2

                        dex                     ; +2   6
                        bne .outer              ; +2/3 8/9
.end                    rts

.silence                ldx #255
                        lda sound.DurationsTab,x
                        tax
.silenceOuter           ldy #255
.silenceInner           dey
                        cpy #5
                        bne .silenceNext
                        rol
.silenceNext            cpy #0
                        bne .silenceInner
                        rol
                        dex
                        bne .silenceOuter
                        rts

; -----------------------------------------------------------------------------
;
; Durations (D) for each frequency (F) computed based on number of cycles (C)
; it takes to play the lowest frequence (F = 255) for 10 cycles
; C(F=255,D=10) = ((F * 12) + 9) * D = 30690
; D = 30690 / ((F * 12) + 9)
;
sound.DurationsTab SUBROUTINE
.cycles                 SET ((255 * 12) + 9) * TONE_DURATION
.freq                   SET #0
                        REPEAT 256
.dur                    SET .cycles / ((.freq * 12) + 9)
                        if .dur > 255
.dur                    SET 255
                        endif
                        DC.B .dur
.freq                   SET .freq + 1
                        REPEND

