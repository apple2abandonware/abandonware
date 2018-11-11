working .dsk version.
don't use "init" option to create more character disks.
if you need more character disks, then duplicate the blank character disk and use that instead.
how it works:
we find an unused byte in a common location for all three disks, and place the volume number in that byte.
for each access using a different volume number, we read the sector that holds the special byte.
if they match, then it's the right disk.  if not, then not.
almost as fast as the original.

- peter ferrie, 2013/09/13