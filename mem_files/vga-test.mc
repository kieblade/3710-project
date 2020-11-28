# Initialize variables
ANDI $0 %r6
ANDI $0 %r7
ANDI $0 %r8
ANDI $0 %r9
ANDI $0 %r1

# Create end state
ORI $100 %r6 # r6 = 100
ORI $80 %r9  # r9 = 80
ADD %r6 %r6  # r6 = 200
ADD %r6 %r6  # r6 = 400
ADD %r9 %r6  # r6 = 480

# Create return value
ORI $100 %r7

# Store address in register
ORI $15 %r8
LSHI $12 %r8

# Store lables in register
# ANDI $0 %r3
# ORI .store_postition %r3
ANDI $0 %r4
ORI .load_position %r4
# ANDI $0 %r5
# ORI .Return %r5

.load_position
# Retrieve from memory
LOAD %r1 %r8

# Add 4 to position
ADDI $4 %r1

# if r10 >= 480
# CMP %r6 %r1
# JGE %r5

# .store_postition
# Store in memory
# STOR %r1 %r8
# LOAD %r1 %r8
# JUC %r4

# .Return
# ANDI $0 %r1
# OR %r7 %r1
# JUC %r3