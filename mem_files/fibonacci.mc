# Initialize the registers to 0
ANDI $0 %r0 
ANDI $0 %r1 
# Load 1 into reg 1
ORI $1 %r1

# Begin the fibonacci sequence
ADD %r1 %r0
ADD %r0 %r1
ADD %r1 %r0
ADD %r0 %r1
ADD %r1 %r0
ADD %r0 %r1
ADD %r1 %r0
ADD %r0 %r1
ADD %r1 %r0
ADD %r0 %r1
ADD %r1 %r0
ADD %r0 %r1