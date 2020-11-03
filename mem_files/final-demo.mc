# create our initial number
ANDI $0 %r0
ORI $1 %r0

# find a spot in memory
ANDI $0 %r15
ORI $100 %r15
ADDI $100 %r15

ANDI $0 %r10
ORI .loopstart %r10
ANDI $0 %r11
ORI .loopend %r11
ANDI $0 %r12
ORI .double %r12

.loopstart
ANDI $0 %r14
ORI $100 %r14
LSHI $4 %r14
CMP %r14 %r0
JLE %r11

STOR %r0 %r15
JALR %r14 %r12
ANDI $0 %r0
OR %r3 %r0

JUC %r10
.loopend

ANDI $0 %r10
ORI .end %r10

JUC %r10

.double
LOAD %r3 %r15
LSHI $1 %r3
JUC %r14

.end
ANDI $0 %r1
OR %r0 %r1

ANDI $0 %r2
ORI .inf_nop %r2
.inf_nop
NOP
NOP
JUC %r2