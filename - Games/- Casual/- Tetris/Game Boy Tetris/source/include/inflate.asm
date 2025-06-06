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
; inflate - uncompress data stored in the DEFLATE format
; by Piotr Fusik <fox@scene.pl>
; Last modified: 2017-11-07
;
; Compile with xasm (http://xasm.atari.org/), for example:
; xasm inflate.asx /l /d:inflate=$b700 /d:inflate_data=$b900 /d:inflate_zp=$f0
; inflate is 508 bytes of code and constants
; inflate_data is 765 bytes of uninitialized data
; inflate_zp is 10 bytes on page zero
;
; This code is licensed under the standard zlib license.
;
; Copyright (C) 2000-2017 Piotr Fusik
;
; This software is provided 'as-is', without any express or implied warranty.
; In no event will the authors be held liable for any damages arising from the
; use of this software.
;
; Permission is granted to anyone to use this software for any purpose,
; including commercial applications, and to alter it and redistribute it
; freely, subject to the following ; restrictions:
;
; The origin of this software must not be misrepresented; you must not claim
; that you wrote the original software. If you use this software in a product,
; an acknowledgment in the ; product documentation would be appreciated but is
; not required.
;
; Altered source versions must be plainly marked as such, and must not be
; misrepresented as being the original software.
;
; This notice may not be removed or altered from any source distribution.
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
; Modification for GB Tetris by Lee Fastenau
;
; I strongly recommend going directly to the source if you want to use this
; routine in your own project. All of the modifications I've made are specific
; to GB Tetris.
;
; Original: https://github.com/pfusik/zlib6502
; -----------------------------------------------------------------------------

                        SEG.U ZEROPAGE
inflate_zp              DS.B 10
                        SEG PROGRAM

; Pointer to compressed data
inputPointer                    equ     inflate_zp    ; 2 bytes

; Pointer to uncompressed data
outputPointer                   equ     inflate_zp+2  ; 2 bytes

; Local variables

getBit_buffer                   equ     inflate_zp+4  ; 1 byte

getBits_base                    equ     inflate_zp+5  ; 1 byte
inflateStored_pageCounter       equ     inflate_zp+5  ; 1 byte

inflateCodes_sourcePointer      equ     inflate_zp+6  ; 2 bytes
inflateDynamic_symbol           equ     inflate_zp+6  ; 1 byte
inflateDynamic_lastLength       equ     inflate_zp+7  ; 1 byte
inflateDynamic_tempCodes        equ     inflate_zp+7  ; 1 byte

inflateCodes_lengthMinus2       equ     inflate_zp+8  ; 1 byte
inflateDynamic_allCodes         equ     inflate_zp+8  ; 1 byte

inflateDynamic_primaryCodes     equ     inflate_zp+9  ; 1 byte


; Argument values for getBits
GET_1_BIT                       equ     $81
GET_2_BITS                      equ     $82
GET_3_BITS                      equ     $84
GET_4_BITS                      equ     $88
GET_5_BITS                      equ     $90
GET_6_BITS                      equ     $a0
GET_7_BITS                      equ     $c0

; Huffman trees
TREE_SIZE                       equ     16
PRIMARY_TREE                    equ     0
DISTANCE_TREE                   equ     TREE_SIZE

; Alphabet
LENGTH_SYMBOLS                  equ     1+29+2
DISTANCE_SYMBOLS                equ     30
CONTROL_SYMBOLS                 equ     LENGTH_SYMBOLS+DISTANCE_SYMBOLS



; Uncompress DEFLATE stream starting from the address stored in inputPointer
; to the memory starting from the address stored in outputPointer
inflate SUBROUTINE
        MVY #0, getBit_buffer
inflate_blockLoop
; Get a bit of EOF and two bits of block type
;       ldy     #0
        sty     getBits_base
        lda     #GET_3_BITS
        jsr     getBits
        lsr
        php
        bne     inflateCompressed

; Copy uncompressed block
;       ldy     #0
        sty     getBit_buffer  ; ignore bits until byte boundary
        jsr     getWord        ; skip the length we don't need
        jsr     getWord        ; get the one's complement length
        sta     inflateStored_pageCounter
;       jmp     inflateStored_firstByte
        bcs     inflateStored_firstByte
inflateStored_copyByte
        jsr     getByte
        jsr     storeByte
inflateStored_firstByte
        inx
        bne     inflateStored_copyByte
        inc     inflateStored_pageCounter
        bne     inflateStored_copyByte

inflate_nextBlock
        plp
        bcc     inflate_blockLoop
        rts

inflateCompressed
; A=1: fixed block, initialize with fixed codes
; A=2: dynamic block, start by clearing all code lengths
; A=3: invalid compressed data, not handled in this routine
        eor     #2

;       ldy     #0
inflateCompressed_setCodeLengths
        tax
        beq     inflateCompressed_setLiteralCodeLength
; fixed Huffman literal codes:
; :144 DTA 8
; :112 DTA 9
        lda     #4
        cpy     #144
        rol
inflateCompressed_setLiteralCodeLength
        sta     literalSymbolCodeLength,y
        beq     inflateCompressed_setControlCodeLength
; fixed Huffman control codes:
; :24  DTA 7
; :6   DTA 8
; :2   DTA 8 ; meaningless codes
; :30  DTA 5+DISTANCE_TREE
        lda     #5+DISTANCE_TREE
        cpy     #LENGTH_SYMBOLS
        bcs     inflateCompressed_setControlCodeLength
        cpy     #24
        adc     #2-DISTANCE_TREE
inflateCompressed_setControlCodeLength
        cpy     #CONTROL_SYMBOLS
        SCS sta controlSymbolCodeLength,y
        iny
        bne     inflateCompressed_setCodeLengths

        tax
        bne     inflateCodes

; Decompress a block reading Huffman trees first

; Build the tree for temporary codes
        jsr     buildTempHuffmanTree

; Use temporary codes to get lengths of literal/length and distance codes
;       ldx     #0
;       sec
inflateDynamic_decodeLength
; C=1: literal codes
; C=0: control codes
        stx     inflateDynamic_symbol
        php
; Fetch a temporary code
        jsr     fetchPrimaryCode
; Temporary code 0..15: put this length
        bpl     inflateDynamic_verbatimLength
; Temporary code 16: repeat last length 3 + getBits(2) times
; Temporary code 17: put zero length 3 + getBits(3) times
; Temporary code 18: put zero length 11 + getBits(7) times
        tax
        jsr     getBits
        cpx     #GET_3_BITS
        bcc     inflateDynamic_repeatLast
        SEQ adc #7
;       ldy     #0
        sty     inflateDynamic_lastLength
inflateDynamic_repeatLast
        tay
        lda     inflateDynamic_lastLength
        iny
        iny
inflateDynamic_verbatimLength
        iny
        plp
        ldx     inflateDynamic_symbol
inflateDynamic_storeLength
        bcc     inflateDynamic_controlSymbolCodeLength
        sta     literalSymbolCodeLength,x
        inx
        cpx     #1
inflateDynamic_storeNext
        dey
        bne     inflateDynamic_storeLength
        sta     inflateDynamic_lastLength
;       jmp     inflateDynamic_decodeLength
        beq     inflateDynamic_decodeLength
inflateDynamic_controlSymbolCodeLength
        cpx     inflateDynamic_primaryCodes
        bcc     inflateDynamic_storeControl
; the code lengths we skip here were zero-initialized
; in inflateCompressed_setControlCodeLength
        SNE ldx #LENGTH_SYMBOLS
        ora     #DISTANCE_TREE
inflateDynamic_storeControl
        sta     controlSymbolCodeLength,x
        inx
        cpx     inflateDynamic_allCodes
        bcc     inflateDynamic_storeNext
        dey
;       ldy     #0

; Decompress a block
inflateCodes
        jsr     buildHuffmanTree
;       jmp     inflateCodes_loop
        beq     inflateCodes_loop
inflateCodes_literal
        jsr     storeByte
inflateCodes_loop
        jsr     fetchPrimaryCode
        bcc     inflateCodes_literal
        beq     inflate_nextBlock
; Copy sequence from look-behind buffer
;       ldy     #0
        sty     getBits_base
        cmp     #9
        bcc     inflateCodes_setSequenceLength
        tya
;       lda     #0
        cpx     #1+28
        bcs     inflateCodes_setSequenceLength
        dex
        txa
        lsr
        ror     getBits_base
        inc     getBits_base
        lsr
        rol     getBits_base
        jsr     getAMinus1BitsMax8
;       sec
        adc     #0
inflateCodes_setSequenceLength
        sta     inflateCodes_lengthMinus2
        ldx     #DISTANCE_TREE
        jsr     fetchCode
        cmp     #4
        bcc     inflateCodes_setOffsetLowByte
        inc     getBits_base
        lsr
        jsr     getAMinus1BitsMax8
inflateCodes_setOffsetLowByte
        eor     #$ff
        sta     inflateCodes_sourcePointer
        lda     getBits_base
        cpx     #10
        bcc     inflateCodes_setOffsetHighByte
        lda     getNPlus1Bits_mask-10,x
        jsr     getBits
        clc
inflateCodes_setOffsetHighByte
        eor     #$ff
;       clc
        adc     outputPointer+1
        sta     inflateCodes_sourcePointer+1
        jsr     copyByte
        jsr     copyByte
inflateCodes_copyByte
        jsr     copyByte
        dec     inflateCodes_lengthMinus2
        bne     inflateCodes_copyByte
;       jmp     inflateCodes_loop
        beq     inflateCodes_loop

; Get dynamic block header and use it to build the temporary tree
buildTempHuffmanTree
;       ldy     #0
; numberOfPrimaryCodes = 257 + getBits(5)
; numberOfDistanceCodes = 1 + getBits(5)
; numberOfTemporaryCodes = 4 + getBits(4)
        ldx     #3
inflateDynamic_getHeader
        lda     inflateDynamic_headerBits-1,x
        jsr     getBits
;       sec
        adc     inflateDynamic_headerBase-1,x
        sta     inflateDynamic_tempCodes-1,x
        dex
        bne     inflateDynamic_getHeader

; Get lengths of temporary codes in the order stored in inflateDynamic_tempSymbols
;       ldx     #0
inflateDynamic_getTempCodeLengths
        lda     #GET_3_BITS
        jsr     getBits
        ldy     inflateDynamic_tempSymbols,x
        sta     literalSymbolCodeLength,y
        ldy     #0
        inx
        cpx     inflateDynamic_tempCodes
        bcc     inflateDynamic_getTempCodeLengths

; Build Huffman trees basing on code lengths (in bits)
; stored in the *SymbolCodeLength arrays
buildHuffmanTree
; Clear nBitCode_literalCount, nBitCode_controlCount
        tya
;       lda     #0
.leeoop0
        sta nBitCode_clearFrom,y
        iny
        bne .leeoop0
; Count number of codes of each length
;       ldy     #0
buildHuffmanTree_countCodeLengths
        ldx     literalSymbolCodeLength,y
        inc     nBitCode_literalCount,x
        SNE stx allLiteralsCodeLength
        cpy     #CONTROL_SYMBOLS
        bcs     buildHuffmanTree_noControlSymbol
        ldx     controlSymbolCodeLength,y
        inc     nBitCode_controlCount,x
buildHuffmanTree_noControlSymbol
        iny
        bne     buildHuffmanTree_countCodeLengths
; Calculate offsets of symbols sorted by code length
;       lda     #0
        ldx     #-4*TREE_SIZE
buildHuffmanTree_calculateOffsets
        sta     nBitCode_literalOffset+4*TREE_SIZE-$100,x
        ADD     nBitCode_literalCount+4*TREE_SIZE-$100,x
        inx
        bne     buildHuffmanTree_calculateOffsets
; Put symbols in their place in the sorted array
;       ldy     #0
buildHuffmanTree_assignCode
        tya
        ldx     literalSymbolCodeLength,y
        ldy     nBitCode_literalOffset,x
        inc     nBitCode_literalOffset,x
        sta     codeToLiteralSymbol,y
        tay
        cpy     #CONTROL_SYMBOLS
        bcs     buildHuffmanTree_noControlSymbol2
        ldx     controlSymbolCodeLength,y
        ldy     nBitCode_controlOffset,x
        inc     nBitCode_controlOffset,x
        sta     codeToControlSymbol,y
        tay
buildHuffmanTree_noControlSymbol2
        iny
        bne     buildHuffmanTree_assignCode
        rts

; Read Huffman code using the primary tree
fetchPrimaryCode
        ldx     #PRIMARY_TREE
; Read a code from input using the tree specified in X,
; return low byte of this code in A,
; return C flag reset for literal code, set for length code
fetchCode
;       ldy     #0
        tya
fetchCode_nextBit
        jsr     getBit
        rol
        inx
        bcs     fetchCode_ge256
; are all 256 literal codes of this length?
        cpx     allLiteralsCodeLength
        beq     fetchCode_allLiterals
; is it literal code of length X?
        SUB     nBitCode_literalCount,x
        bcs     fetchCode_notLiteral
; literal code
;       clc
        adc     nBitCode_literalOffset,x
        tax
        lda     codeToLiteralSymbol,x
fetchCode_allLiterals
        clc
        rts
; code >= 256, must be control
fetchCode_ge256
;       sec
        sbc     nBitCode_literalCount,x
        sec
; is it control code of length X?
fetchCode_notLiteral
;       sec
        sbc     nBitCode_controlCount,x
        bcs     fetchCode_nextBit
; control code
;       clc
        adc     nBitCode_controlOffset,x
        tax
        lda     codeToControlSymbol,x
        and     #$1f    ; make distance symbols zero-based
        tax
;       sec
        rts

; Read A minus 1 bits, but no more than 8
getAMinus1BitsMax8
        rol     getBits_base
        tax
        cmp     #9
        bcs     getByte
        lda     getNPlus1Bits_mask-2,x
getBits
        jsr     getBits_loop
getBits_normalizeLoop
        lsr     getBits_base
        ror
        bcc     getBits_normalizeLoop
        rts

; Read 16 bits
getWord
        jsr     getByte
        tax
; Read 8 bits
getByte
        lda     #$80
getBits_loop
        jsr     getBit
        ror
        bcc     getBits_loop
        rts

; Read one bit, return in the C flag
getBit
        lsr     getBit_buffer
        bne     getBit_return
        pha
;       ldy     #0
        lda     (inputPointer),y
        INW     inputPointer
        sec
        ror
        sta     getBit_buffer
        pla
getBit_return
        rts

; Copy a previously written byte
copyByte
        ldy     outputPointer
        lda     (inflateCodes_sourcePointer),y
        ldy     #0
; Write a byte
storeByte
;       ldy     #0
        sta     (outputPointer),y
        inc     outputPointer
        bne     storeByte_return
        inc     outputPointer+1
        inc     inflateCodes_sourcePointer+1
storeByte_return
        rts

getNPlus1Bits_mask
        DTA     GET_1_BIT,GET_2_BITS,GET_3_BITS,GET_4_BITS,GET_5_BITS,GET_6_BITS,GET_7_BITS

inflateDynamic_tempSymbols
        DTA     GET_2_BITS,GET_3_BITS,GET_7_BITS,0,8,7,9,6,10,5,11,4,12,3,13,2,14,1,15

inflateDynamic_headerBits
        DTA     GET_4_BITS,GET_5_BITS,GET_5_BITS
inflateDynamic_headerBase
        DTA     3,LENGTH_SYMBOLS,0

        SEG.U
        ORG $4000
inflate_data
; Data for building trees

literalSymbolCodeLength
        DS.B 256
controlSymbolCodeLength
        DS.B CONTROL_SYMBOLS

; Huffman trees

nBitCode_clearFrom
nBitCode_literalCount
        DS.B 2*TREE_SIZE
nBitCode_controlCount
        DS.B 2*TREE_SIZE
nBitCode_literalOffset
        DS.B 2*TREE_SIZE
nBitCode_controlOffset
        DS.B 2*TREE_SIZE
allLiteralsCodeLength
        DS.B 1

codeToLiteralSymbol
        DS.B 256
codeToControlSymbol
        DS.B CONTROL_SYMBOLS

inflate_data_end
        SEG PROGRAM
