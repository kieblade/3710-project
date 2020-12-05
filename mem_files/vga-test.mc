# Initialize variables
ANDI $0 %r2
ANDI $0 %r6
ANDI $0 %r7
ANDI $0 %r8
ANDI $0 %r9
ANDI $0 %r1
ANDI $0 %r10
ANDI $0 %r11
ANDI $0 %r12

# Create end state
ORI $100 %r6 # r6 = 100
ORI $80 %r9  # r9 = 80
ADD %r6 %r6  # r6 = 200
ADD %r6 %r6  # r6 = 400
ADD %r9 %r6  # r6 = 480

ORI $12 %r2
ORI $4 %r7 # r7 = 4

NOT %r12
RSH %r7 %r12
ANDI $0 %r7
ORI $1 %r7 # r7 = 1
NOT %r10
RSH %r7 %r10
ANDI $0 %r7
OR %r10 %r7


# Store address in register
ORI $15 %r8 # r8 = 15
LSHI $12 %r8
ORI $15 %r11
LSHI $12 %r11
ADDI $3 %r11

# Store lables in register
ANDI $0 %r3 # r3 = 0
ORI .store_postition %r3 # r3 = store_position
ANDI $0 %r4
ORI .load_position %r4 # r4 = load_position
ANDI $0 %r5
ORI .Return %r5 # r5 = Return
ANDI $0 %r10
ORI .reset_fret %r10

.load_position
# Retrieve from memory
LOAD %r1 %r8
NOP
NOP

# Add 4 to position
ADDI $4 %r1

# if r1 >= 480
ANDI $0 %r13
OR %r12 %r13
AND %r1 %r13
CMP %r13 %r6
JGE %r5

ANDI $0 %r14
.store_postition
# Store in memory
ADDI $1 %r14
CMP %r14 %r7
JLT %r3
STOR %r1 %r8
NOP
NOP
ADDI $1 %r8
CMP %r8 %r11
JGT %r10
JUC %r4

.Return
RSH %r2 %r1
LSHI $12 %r1
JUC %r3

.reset_fret
ANDI $0 %r8
ORI $15 %r8
LSHI $12 %r8
JUC %r4
