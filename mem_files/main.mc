# r2 holds the player score
ANDI $0 %r2

# r3 points next glyph write location
ANDI $0 %r3
ORI $15 %r3
LSHI $12 %r3

# r7 holds a number for checking notes. don't touch
ANDI $0 %r7
ORI $1 %r7
LSHI $8 %r7

# r8 holds the start of glyph memory
ANDI $0 %r8
ORI $15 %r8
LSHI $12 %r8

# r10 holds the end of glyph memory
ANDI $0 %r10
OR %r8 %r10
ADDI $19 %r10

# r14 points to the player score
ANDI $0 %r14
NOT %r14
ANDI $0 %r9
STOR %r9 %r14

# establish note delay
ANDI $0 %r9
ORI $125 %r9
LSHI $3 %r9
ANDI $0 %r0
STOR %r0 %r9
ADDI $1 %r9
ORI $50 %r0
STOR %r0 %r9

JPT .main_loop_start %r9
JUC %r9

.busy_loop
ANDI $0 %r0
ORI $-1 %r0
ANDI $0 %r0
ANDI $0 %r1
ORI $100 %r1
LSHI $7 %r1
.busy_loop_inner
ADDI $1 %r0
JPT .busy_loop_inner %r9
CMPU %r0 %r1
JLS %r9
ANDI $0 %r0

JPT .main_loop_start %r9
JUC %r9

.bump
ADDI $1 %r0
STOR %r0 %r11

# go home
JPT .glyph_next %r9
JUC %r9

.main_loop_start
ANDI $0 %r5
ORI $10 %r5

ANDI $0 %r11
OR %r8 %r11

ANDI $0 %r9
ORI $125 %r9
LSHI $3 %r9
LOAD %r0 %r9
ADDI $1 %r0
STOR %r0 %r9

# JPT .guitar_stuff %r4
# ANDI $0 %r1
# ORI $2 %r1
# AND %r0 %r1
# CMP %r1 %r0
# JEQ %r4

ADDI $1 %r9
LOAD %r1 %r9

JPT .guitar_stuff %r4
CMP %r0 %r1
JLT %r4

SUBI $1 %r9
ANDI $0 %r0
STOR %r0 %r9

.note_check
SUBI $1 %r5

JPT .guitar_stuff %r9

# if r5 < 5 jump to guitar_stuff
CMPI $5 %r5
JGT %r9

# Split r15 get bits 9 - 5 to render immediately
# check each bit from r15 to render
# check bit 9
ANDI $0 %r4
ORI $1 %r4
LSH %r5 %r4
AND %r15 %r4

JPT .note_check %r9

CMPI $0 %r4
JEQ %r9 # if r4 is 0, move to the next note

# else
ANDI $0 %r6
.count_loop
# if r4 > 256
JPT .count_loop_end %r9
CMP %r4 %r7
JGT %r9
# else
LSHI $1 %r4
ADDI $1 %r6

JPT .count_loop %r9
JUC %r9
.count_loop_end

LSHI $12 %r6
ADDI $4 %r6
STOR %r6 %r3
ADDI $1 %r3

JPT .continue %r9

# if r3 <= r10
CMPU %r3 %r10
JLS %r9
# reset glyph pointer
ANDI $0 %r3
OR %r8 %r3
.continue

# jump back to note check
JPT .note_check %r9
JUC %r9

# display
.guitar_stuff
ANDI $0 %r4
ORI $1 %r4
LSH %r5 %r4

ANDI $0 %r11
OR %r8 %r11

JPT .glyph_move %r9
CMPI $0 %r5
JGT %r9
SUBI $1 %r5

AND %r15 %r4
JPT .guitar_stuff %r9

# if r4 == 0 move to check the next button
CMPI $0 %r4
JEQ %r9

.glyph_loop
# set glyph lower threshold
ANDI $0 %r12
ADDI $92 %r12
LSHI $2 %r12

LOAD %r0 %r11

# extract position
ANDI $0 %r13
ORI $15 %r13
LSHI $12 %r13
NOT %r13

AND %r0 %r13

JPT .glyph_loop_end %r9
# if pos < lower threshold
CMP %r13 %r12
JLT %r9
# if pos > upper threshold
ADDI $64 %r12
#420 eyy
CMP %r13 %r12
JGT %r9

# extract type
ANDI $0 %r13
ORI $15 %r13
LSHI $12 %r13
AND %r0 %r13
RSHI $12 %r13

ANDI $0 %r0
ORI $16 %r0
RSH %r13 %r0

# if type != button pressed
CMP %r0 %r4
JNE %r9

# add to score
ADDI $1 %r2

# delete glyph
ANDI $0 %r0
ADDI $125 %r0
LSHI $2 %r0
STOR %r0 %r11

# reset glyph pointer
ANDI $0 %r11
OR %r8 %r11

# next button
JPT .guitar_stuff %r9
JUC %r9

# if the button is pressed, but current glyph isn't right
.glyph_loop_end
ADDI $1 %r11
JPT .glyph_loop %r9

# if r11 <= glyph end threshold
CMPU %r11 %r10
JLS %r9

#else - done with glyphs
# SUBI $1 %r2

# next button
JPT .guitar_stuff %r9
JUC %r9

.glyph_next
ADDI $1 %r11

.glyph_move
JPT .busy_loop %r9
CMPU %r11 %r10
JHI %r9

LOAD %r0 %r11

JPT .glyph_next %r9

# if glyph == 500, next glyph
ANDI $0 %r1
ORI $125 %r1
LSHI $2 %r1
CMP %r0 %r1
JEQ %r9

# extract position
ANDI $0 %r13
ORI $15 %r13
LSHI $12 %r13
NOT %r13
AND %r0 %r13

# set end threshold
ANDI $0 %r6
ADDI $120 %r6
LSHI $2 %r6

JPT .bump %r9
# if position < 480
CMP %r13 %r6
JLT %r9
#else

# score --
SUBI $1 %r2

# delete glyph
ANDI $0 %r6
ADDI $125 %r6
LSHI $2 %r6
STOR %r6 %r11

JPT .glyph_next %r9
JUC %r9

# cash money

