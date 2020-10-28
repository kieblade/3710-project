# Initialize variables
ANDI $0 %r6
ANDI $0 %r7
ANDI $0 %r8
ANDI $0 %r9

# Create non-zero values
ORI $112 %r7
ORI $-12 %r9

# Create store addresses
ORI $100 %r6
ORI $200 %r8

# Store in memory
STOR %r7 %r6
STOR %r9 %r8

# Retrieve from memory
LOAD %r14 %r6
LOAD %r15 %r8

# Modify
ADD %r14 %r15

# Move to r1
ANDI $0 %r1
OR %r15 %r1