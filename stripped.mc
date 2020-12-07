ANDI $0 %r0 
ANDI $0 %r1 
ANDI $0 %r2 
ANDI $0 %r3 
ANDI $0 %r4 
ANDI $0 %r5 
NOT %r0 
RSHI $4 %r0 
NOT %r2 
RSHI $1 %r2 
ORI $15 %r3 
LSHI $12 %r3 
ORI $15 %r4 
LSHI $12 %r4 
ADDI $4 %r4 
ORI $100 %r9 
ORI $100 %r10 
ADD %r9 %r9 
ADD %r9 %r9 
ADD %r10 %r9 
ANDI $0 %r6 
ORI $28 %r6 
ANDI $0 %r7 
ORI $38 %r7 
ANDI $0 %r8 
ORI $51 %r8 
ANDI $0 %r12 
ORI $48 %r12 
LOAD %r1 %r3 
NOP 
NOP 
ADDI $4 %r1 
ANDI $0 %r11 
OR %r0 %r11 
AND %r1 %r11 
CMP %r11 %r9 
JGE %r12 
ANDI $0 %r5 
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
RSHI $12 %r1 
LSHI $12 %r1 
JUC %r7 
ANDI $0 %r3 
ORI $15 %r3 
LSHI $12 %r3 
JUC %r6 
