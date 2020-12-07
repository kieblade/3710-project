# Initialize variables
ANDI $0 %r0
ANDI $0 %r1
ORI $1 %r7 # r7 = 1
ANDI $0 %r2
ANDI $0 %r3
ANDI $0 %r4
ANDI $0 %r5

NOT %r0
RSHI $4 %r0
NOT %r2
RSHI $1 %r2

# Store address in register
ORI $15 %r3 # r3 = 15
LSHI $12 %r3
ORI $15 %r4
LSHI $12 %r4
ADDI $4 %r4

# Create end state
ORI $100 %r9 # r9 = 100
ORI $100 %r10  # r10 = 100
ADD %r9 %r9  # r9 = 200
ADD %r9 %r9  # r9 = 400
ADD %r10 %r9  # r9 = 500

# Store lables in register
ANDI $0 %r6
ORI .load_position %r6 # r6 = load_position
ANDI $0 %r7
ORI .store_postition %r7 # r7 = store_position
ANDI $0 %r8
ORI .reset_fret %r8
ANDI $0 %r12
ORI .return %r12

.load_position
# Retrieve from memory
LOAD %r1 %r3
NOP
NOP

# Add 4 to position
ADDI $4 %r1

# if r1 >= 480
ANDI $0 %r11
OR %r0 %r11
AND %r1 %r11
CMP %r11 %r9
JGE %r12

ANDI $0 %r5
.store_postition
# Store in memory
ADDI $1 %r5
CMP %r5 %r2
JLT %r7
STOR %r1 %r3
NOP
NOP
ADDI $1 %r3
CMP %r3 %r4
JGT %r8
JUC %r6

.return
RSHI $12 %r1
LSHI $12 %r1
JUC %r7

.reset_fret
ANDI $0 %r3
ORI $15 %r3
LSHI $12 %r3
JUC %r6
