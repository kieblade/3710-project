# Initialize variables
ANDI $0 %r6

# Create store addresses
ORI $100 %r6

# Store in memory
STOR %r15 %r6

# Retrieve from memory
LOAD %r1 %r6