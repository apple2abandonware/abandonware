
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
;
; 🛑 THIS IS A GENERATED FILE. MANUAL EDITS MAY BE LOST.
;

tune.dance5
			DC.B $01	; Note Repeats
			DC.B $03	; Note Duration
			DC.B $2b, $20	; 0
			DC.B $00, $00	; 1
			DC.B $00, $00	; 2
			DC.B $2b, $20	; 3
			DC.B $2b, $22	; 4
			DC.B $00, $00	; 5
			DC.B $2b, $20	; 6
			DC.B $00, $00	; 7
			DC.B $00, $00	; 8
			DC.B $2b, $20	; 9
			DC.B $2b, $20	; 10
			DC.B $00, $00	; 11
			DC.B $40, $26	; 12
			DC.B $00, $00	; 13
			DC.B $00, $00	; 14
			DC.B $40, $2b	; 15
			DC.B $40, $2b	; 16
			DC.B $00, $00	; 17
			DC.B $40, $30	; 18
			DC.B $00, $00	; 19
			DC.B $00, $00	; 20
			DC.B $26, $26	; 21
			DC.B $00, $00	; 22
			DC.B $00, $00	; 23
			DC.B $33, $2b	; 24
			DC.B $00, $00	; 25
			DC.B $00, $00	; 26
			DC.B $33, $2b	; 27
			DC.B $33, $2d	; 28
			DC.B $00, $00	; 29
			DC.B $33, $2b	; 30
			DC.B $00, $00	; 31
			DC.B $00, $00	; 32
			DC.B $33, $2b	; 33
			DC.B $33, $20	; 34
			DC.B $00, $00	; 35
			DC.B $56, $33	; 36
			DC.B $00, $00	; 37
			DC.B $00, $00	; 38
			DC.B $56, $39	; 39
			DC.B $56, $39	; 40
			DC.B $00, $00	; 41
			DC.B $56, $40	; 42
			DC.B $00, $00	; 43
			DC.B $00, $00	; 44
			DC.B $33, $33	; 45
			DC.B $00, $2b	; 46
			DC.B $00, $00	; 47
			DC.B $56, $39	; 48
			DC.B $00, $00	; 49
			DC.B $00, $00	; 50
			DC.B $56, $39	; 51
			DC.B $56, $2b	; 52
			DC.B $00, $00	; 53
			DC.B $56, $40	; 54
			DC.B $00, $00	; 55
			DC.B $00, $00	; 56
			DC.B $56, $40	; 57
			DC.B $56, $2b	; 58
			DC.B $00, $00	; 59
			DC.B $56, $44	; 60
			DC.B $00, $00	; 61
			DC.B $00, $00	; 62
			DC.B $56, $44	; 63
			DC.B $56, $2b	; 64
			DC.B $00, $00	; 65
			DC.B $56, $39	; 66
			DC.B $00, $00	; 67
			DC.B $00, $00	; 68
			DC.B $56, $39	; 69
			DC.B $56, $2b	; 70
			DC.B $00, $00	; 71
			DC.B $56, $33	; 72
			DC.B $00, $00	; 73
			DC.B $00, $00	; 74
			DC.B $56, $33	; 75
			DC.B $56, $2b	; 76
			DC.B $00, $00	; 77
			DC.B $56, $40	; 78
			DC.B $00, $00	; 79
			DC.B $00, $00	; 80
			DC.B $56, $40	; 81
			DC.B $56, $2b	; 82
			DC.B $00, $00	; 83
			DC.B $60, $39	; 84
			DC.B $00, $00	; 85
			DC.B $00, $00	; 86
			DC.B $60, $40	; 87
			DC.B $60, $44	; 88
			DC.B $00, $00	; 89
			DC.B $60, $39	; 90
			DC.B $00, $2b	; 91
			DC.B $00, $00	; 92
			DC.B $44, $26	; 93
			DC.B $00, $22	; 94
			DC.B $00, $00	; 95
			DC.B $2b, $20	; 96
			DC.B $00, $00	; 97
			DC.B $00, $00	; 98
			DC.B $2b, $20	; 99
			DC.B $2b, $22	; 100
			DC.B $00, $00	; 101
			DC.B $2b, $20	; 102
			DC.B $00, $00	; 103
			DC.B $00, $00	; 104
			DC.B $2b, $20	; 105
			DC.B $2b, $20	; 106
			DC.B $00, $00	; 107
			DC.B $40, $26	; 108
			DC.B $00, $00	; 109
			DC.B $00, $00	; 110
			DC.B $40, $2b	; 111
			DC.B $40, $2b	; 112
			DC.B $00, $00	; 113
			DC.B $40, $30	; 114
			DC.B $00, $00	; 115
			DC.B $00, $00	; 116
			DC.B $26, $26	; 117
			DC.B $00, $00	; 118
			DC.B $00, $00	; 119
			DC.B $33, $2b	; 120
			DC.B $00, $00	; 121
			DC.B $00, $00	; 122
			DC.B $33, $2b	; 123
			DC.B $33, $2d	; 124
			DC.B $00, $00	; 125
			DC.B $33, $2b	; 126
			DC.B $00, $00	; 127
			DC.B $00, $00	; 128
			DC.B $33, $2b	; 129
			DC.B $33, $20	; 130
			DC.B $00, $00	; 131
			DC.B $56, $33	; 132
			DC.B $00, $00	; 133
			DC.B $00, $00	; 134
			DC.B $56, $39	; 135
			DC.B $56, $39	; 136
			DC.B $00, $00	; 137
			DC.B $56, $40	; 138
			DC.B $00, $00	; 139
			DC.B $00, $00	; 140
			DC.B $33, $33	; 141
			DC.B $00, $2b	; 142
			DC.B $00, $00	; 143
			DC.B $56, $39	; 144
			DC.B $00, $00	; 145
			DC.B $00, $00	; 146
			DC.B $56, $39	; 147
			DC.B $56, $2b	; 148
			DC.B $00, $00	; 149
			DC.B $56, $40	; 150
			DC.B $00, $00	; 151
			DC.B $00, $00	; 152
			DC.B $56, $40	; 153
			DC.B $56, $2b	; 154
			DC.B $00, $00	; 155
			DC.B $56, $44	; 156
			DC.B $00, $00	; 157
			DC.B $00, $00	; 158
			DC.B $56, $44	; 159
			DC.B $56, $2b	; 160
			DC.B $00, $00	; 161
			DC.B $56, $39	; 162
			DC.B $00, $00	; 163
			DC.B $00, $00	; 164
			DC.B $56, $39	; 165
			DC.B $56, $2b	; 166
			DC.B $00, $00	; 167
			DC.B $56, $33	; 168
			DC.B $00, $00	; 169
			DC.B $00, $00	; 170
			DC.B $56, $33	; 171
			DC.B $56, $2b	; 172
			DC.B $00, $00	; 173
			DC.B $56, $39	; 174
			DC.B $00, $00	; 175
			DC.B $00, $00	; 176
			DC.B $56, $39	; 177
			DC.B $56, $2b	; 178
			DC.B $00, $00	; 179
			DC.B $40, $40	; 180
			DC.B $00, $00	; 181
			DC.B $00, $00	; 182
			DC.B $56, $2b	; 183
			DC.B $00, $00	; 184
			DC.B $00, $00	; 185
			DC.B $33, $20	; 186
			DC.B $FF, $00	; Repeat Tune
