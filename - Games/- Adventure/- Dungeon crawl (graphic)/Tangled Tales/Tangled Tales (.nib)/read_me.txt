Tangled Tales is protected by a non-standard 18 sector-per-track data
encoding scheme and a nibble check that is invoked after the player's
character sleeps.  The nibble check routine and its caller are reloaded
from disk before each invocation, and the nibble check itself is
encrypted by being XOR'd with #$FF.

All but two of the tracks on each disk are encoded with the 18 sector-
per-track-scheme.  Each sector has a short header followed by 343 6+2
encoded data bytes and a short gap of FF's.  The 343 bytes decode into
256 data bytes and 1 checksum byte.  The format is as follows:

   D5 <track> <sector> <volume> <343 bytes> FF FF FF FF FF FF

The track, sector, and volume numbers are also 6+2 encoded bytes.
The layout of the data bytes differs slightly from that of DOS 3.3
6+2 encoded bytes.  Rather than 256 "6" bytes followed by 86 "2"
bytes, the data is stored as repeating sets of the "2" byte followed
by its 3 corresponding "6" bytes as such:

   0 0 X7 X6 Y7 Y6 Z7 Z6
   0 0 X5 X4 X3 X2 X1 X0
   0 0 Y5 Y4 Y3 Y2 Y1 Y0
   0 0 Z5 Z4 Z3 Z2 Z1 Z0

The nibble check routine can be defeated by replacing its first
instruction with a RTS.  Since the data encoding scheme for the game
has been revealed, this modification may be made directly to the .NIB
disk images, but care must be taken to preserve the data checksum of
the modified sector.  The encrypted nibble check routine looks like
this in memory:

   $a4ab - 40 d7 56 f0 7a fd

To defeat the routine, a RTS instruction needs to be encrypted ($60
XOR $FF = $9F) and placed at $a4ad.  In order to preserve the sector's
checksum, the following byte must also be changed so that when the two
bytes are XOR'd they result in the same value.  E.g., $56 XOR $F0 = $A6
and $9F XOR $39 = $A6 also.  We now have:

   $a4ab - 40 d7 56 f0 7a fd   ; original bytes
   $a4ab - 40 d7 9f 39 7a fd   ; patched bytes

When these bytes are encoded with the game's 6+2 scheme, the result
looks like:

   ce 96 bc bb f6 ed fa fd   ; original raw disk bytes
   cf 96 bc d3 a6 f9 fa fd   ; patched raw disk bytes

Note that this pattern appears once on each of the 3 Tangled Tales
"Adventure" disks.  This is due to the fact that the nibble check
routine is always reloaded before being executed.

Acknowledgements go to Thomas Lai for providing the original disks,
Rich the Datawiz for finding the nibble check routine, and the
AppleWin debugger!

Appendix: memory locations of related routines and variables:

   $61b2 - routine to read and decode a sector
   $627f - track to read
   $6280 - sector to read
   $6019 - expected volume number
   $6200 - 6+2 read translate table

   $a207 - call to routine that de/encodes nibble check routine in memory
   $a20d - ""
   $a20a - call to nibble check routine
   $a4ad - start of nibble check routine

lotek@netcom.com 
