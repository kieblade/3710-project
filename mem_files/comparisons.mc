# intialize some regs to 0
ANDI $0 %r0
ANDI $0 %r10

# load the same value into each
ORI $2 %r0
ORI $2 %r10

# first comparison, should be equal
CMP %r0 %r10

# perform left shift
LSHI $2 %r10

# compare again
CMP %r0 %r10

# move the value of r10 into r1
ANDI $0 %r1
OR %r10 %r1

# shift it back
RSH %r0 %r10

# final cmp, B is greater than A
CMPI $3 %r10

# move the value of r10 into r1
ANDI $0 %r1
OR %r10 %r1