ANDI $0 %r0
ANDI $0 %r2
ANDI $0 %r3
ORI $1 %r3

ANDI $0 %r5
ORI .loop_start %r5
ANDI $0 %r6
ORI .loop_end %r6

.loop_start
# if r0 == 10
CMPI $15 %r0
JLE %r6

# clear out r4
ANDI $0 %r4

# copy r3 to r4
OR %r3 %r4

# r3 = r2 + r3
ADD %r2 %r3

# r2 = r4
ANDI $0 %r2
OR %r4 %r2

ADDI $1 %r0
JUC %r5

.loop_end
ANDI $0 %r1
OR %r3 %r1