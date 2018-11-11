Wizardry II: Knight of Diamonds

This is a cracked and working version of Wizardry II that no longer needs the write 
protect notch for the boot side covered.  This allows the disk image to work properly in 
emulators without needing to set the file permissions to locked. Also, the image has been 
modified to work properly on an Apple //e with an 80-column card.

Changes in this version by Chris Torrence

- The disk image was changed to remove the write-protect check. Following the 
technique of TommyGoog on the comp.sys.apple2 newsgroup, the Pascal p-code was changed by 
1 byte on Track $21 Sector $02 at address $CD from $F6 to $00 (this is at byte 135885 in 
the disk image). The change from $F6 to $00 changes the infinite loop to jump to the next 
instruction instead of to the previous instruction. This allows the disk image to work 
properly in emulators without needing to set the file permissions to locked.
- A bug was fixed where on an Apple //e with an 80-column card in the aux slot, Wizardry 
would incorrectly switch to 80-column mode and have spaces between each character. To fix 
this, memory location $B91D was changed from a JMP instruction ($6C) to a RTS ($60). 
This prevents Wizardry from attempting to switch out of 80-column mode, which was 
actually causing it to switch into 80-columns on an Apple //e.

see https://archive.org/details/WizardryKnightOfDiamonds