ANDI $0 %r0
ORI $20 %r0

# Setup registers for jump
ANDI $0 %r3
ORI .first %r3
JALR %r13 %r3

.second
# This part should be done second. 
LSHI $1 %r0
ANDI $0 %r3
ORI .end %r3
JALR %r13 %r3

.first
# This part should be done first.
ADDI $10 %r0
# Returns
JALR %r14 %r13

.end
# This is the end
ANDI $0 %r1
OR %r0 %r1