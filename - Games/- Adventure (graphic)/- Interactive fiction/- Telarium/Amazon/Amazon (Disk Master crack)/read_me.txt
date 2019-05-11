Apple ][: Amazon [Games/Adventure]

This game is *NOT* protected, but since it utilizes disk volume numbers
to identify the disk sides (vol 1 = side 1, vol 2 = side 2, etc.), it
must be played in NIB format.  Side 3 is the boot side.

The satellite communications portion of the game utilizes a routine at
$0B7C which does a lot of page flipping.  This may bog down your emulator.
To fix this problem under AppleWin, hit F7 as the landsat screen loads,
enter ME B84 EA EA EA, and press F7 to resume execution.  You won't get
the "TV static" effect, but you will have enough time to press the left
and right arrows to tune in the picture.  Hackers can find the disk
volume number comparrison code at $BC20.  Enjoy!
