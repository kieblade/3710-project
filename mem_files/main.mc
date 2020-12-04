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
ADDI $20 %r10

# r11 is the check glyph pointer
ANDI $0 %r11
OR %r8 %r11

# r14 points to the player score
ANDI $0 %r14
NOT %r14
ANDI $0 %r9
STOR %r9 %r14

.bump
ADDI $4 %r0
STOR %r0 %r11

# go home
ANDI $0 %r9
ORI .glyph_move %r9
JUC %r9


.main_loop_start
ANDI $0 %r5
ORI $10 %r5

ANDI $0 %r11
OR %r8 %r11

.note_check
SUBI $1 %r5

ANDI $0 %r9
ORI .guitar_stuff %r9

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

ANDI $0 %r9
ORI .note_check %r9

CMPI $0 %r4
JEQ %r9 # if r4 is 0, move to the next note

# else
ANDI $0 %r6
.count_loop
# if r4 > 256
CMP %r4 %r7

ANDI $0 %r9
ORI .count_loop_end %r9
JGT %r9
# else
LSHI $1 %r4
ADDI $1 %r6

ANDI $0 %r9
ORI .count_loop %r9
JUC %r9
.count_loop_end

LSHI $12 %r6
ADDI $4 %r6
STOR %r6 %r3
ADDI $1 %r3

ANDI $0 %r9
ORI .continue %r9

# if r3 < r10
CMP %r3 %r10
JLE %r9
# reset glyph pointer
AND %r8 %r3
.continue

# jump back to note check
ANDI $0 %r9
ORI .note_check %r9
JUC %r9

# display
.guitar_stuff
ANDI $0 %r4
ORI $1 %r4
LSH %r5 %r4
SUBI $1 %r5

ANDI $0 %r11
OR %r8 %r11

ANDI $0 %r9
ORI .glyph_move %r9
CMPI $0 %r5
JGT %r9

AND %r15 %r4
ANDI $0 %r9
ORI .guitar_stuff %r9

# if r4 == 0 move to check the next button
CMPI $0 %r4
JEQ %r9

.glyph_loop
# set glyph lower threshold
ANDI $0 %r12
ADDI $126 %r12
ADDI $126 %r12
ADDI $98 %r12

LOAD %r0 %r11

# extract position
ANDI $0 %r13
ORI $15 %r13
LSHI $12 %r13
NOT %r13

AND %r0 %r13

ANDI $0 %r9
ORI .glyph_loop_end %r9
# if pos < lower threshold
CMP %r13 %r12
JLT %r9
# if pos > upper threshold
ADDI $40 %r12
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
LOAD %r0 %r14
ADDI $1 %r0
STOR %r0 %r14

# delete glyph
ANDI $0 %r0
STOR %r0 %r11

# reset glyph pointer
ANDI $0 %r11
OR %r8 %r11

# next button
ANDI $0 %r9
ORI .guitar_stuff %r9
JUC %r9

# if the button is pressed, but current glyph isn't right
.glyph_loop_end
ADDI $1 %r11
ANDI $0 %r9
ORI .glyph_loop %r9

# if r11 <= glyph end threshold
CMP %r11 %r10
JLE %r9

#else - done with glyphs
LOAD %r0 %r14
SUBI $1 %r0
STOR %r0 %r14

# next button
ANDI $0 %r9
ORI .guitar_stuff %r9
JUC %r9

.glyph_move
ANDI $0 %r9
ORI .main_loop_start %r9
CMP %r11 %r10
JGT %r9

LOAD %r0 %r11
ADDI $1 %r11

ANDI $0 %r9
ORI .glyph_move %r9

# if glyph == 0, next glyph
CMPI $0 %r0
JEQ %r9

# extract position
ANDI $0 %r13
ORI $15 %r13
LSHI $12 %r13
NOT %r13
AND %r0 %r13

# set end threshold
ANDI $0 %r6
ADDI $125 %r6
LSHI $2 %r6

ANDI $0 %r9
ORI .bump %r9
# if position < 500
CMP %r13 %r6
JLT %r9
#else

# score --
LOAD %r6 %r14
SUBI $1 %r6
STOR %r6 %r14

# delete glyph
ANDI $0 %r6
STOR %r6 %r11

ANDI $0 %r9
ORI .glyph_move %r9
JUC %r9


# cash money

