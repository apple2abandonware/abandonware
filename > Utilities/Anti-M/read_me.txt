Many early Apple II games only worked on the original Apple II or Apple
][+. They refuse to boot on later models, often displaying an "M" error
code. This was due to overly aggressive copy protection; late in the
boot process, there is code that checksums the ROM and reboots if it's
not recognized. The games themselves would work fine if they were
allowed to boot past this ROM check.

see https://github.com/a2-4am/anti-m