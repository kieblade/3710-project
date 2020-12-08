ANDI $0 %r3 
ORI $15 %r3 
LSHI $12 %r3 
ANDI $0 %r7 
ORI $1 %r7 
LSHI $8 %r7 
ANDI $0 %r8 
ORI $15 %r8 
LSHI $12 %r8 
ANDI $0 %r10 
OR %r8 %r10 
ADDI $20 %r10 
ANDI $0 %r14 
NOT %r14 
ANDI $0 %r9 
STOR %r9 %r14 
JPT .main_loop_start %r9 
JUC %r9 
ANDI $0 %r0 
ORI $-1 %r0 
ANDI $0 %r0 
ANDI $0 %r1 
ORI $100 %r1 
LSHI $8 %r1 
ADDI $1 %r0 
JPT .busy_loop_inner %r9 
CMPU %r0 %r1 
JLS %r9 
ANDI $0 %r0 
JPT .main_loop_start %r9 
JUC %r9 
ADDI $4 %r0 
STOR %r0 %r11 
JPT .glyph_next %r9 
JUC %r9 
ANDI $0 %r5 
ORI $10 %r5 
ANDI $0 %r11 
OR %r8 %r11 
SUBI $1 %r5 
JPT .guitar_stuff %r9 
CMPI $5 %r5 
JGT %r9 
ANDI $0 %r4 
ORI $1 %r4 
LSH %r5 %r4 
AND %r15 %r4 
JPT .note_check %r9 
CMPI $0 %r4 
JEQ %r9 
ANDI $0 %r6 
JPT .count_loop_end %r9 
CMP %r4 %r7 
JGT %r9 
LSHI $1 %r4 
ADDI $1 %r6 
JPT .count_loop %r9 
JUC %r9 
LSHI $12 %r6 
ADDI $4 %r6 
STOR %r6 %r3 
ADDI $1 %r3 
JPT .continue %r9 
CMPU %r3 %r10 
JLS %r9 
AND %r8 %r3 
JPT .note_check %r9 
JUC %r9 
ANDI $0 %r4 
ORI $1 %r4 
LSH %r5 %r4 
SUBI $1 %r5 
ANDI $0 %r11 
OR %r8 %r11 
JPT .glyph_move %r9 
CMPI $0 %r5 
JGT %r9 
AND %r15 %r4 
JPT .guitar_stuff %r9 
CMPI $0 %r4 
JEQ %r9 
ANDI $0 %r12 
ADDI $95 %r12 
LSHI $2 %r12 
LOAD %r0 %r11 
ANDI $0 %r13 
ORI $15 %r13 
LSHI $12 %r13 
NOT %r13 
AND %r0 %r13 
JPT .glyph_loop_end %r9 
CMP %r13 %r12 
JLT %r9 
ADDI $40 %r12 
CMP %r13 %r12 
JGT %r9 
ANDI $0 %r13 
ORI $15 %r13 
LSHI $12 %r13 
AND %r0 %r13 
RSHI $12 %r13 
ANDI $0 %r0 
ORI $16 %r0 
RSH %r13 %r0 
CMP %r0 %r4 
JNE %r9 
LOAD %r0 %r14 
ADDI $1 %r0 
STOR %r0 %r14 
ANDI $0 %r0 
ADDI $125 %r0 
LSHI $2 %r0 
STOR %r0 %r11 
ANDI $0 %r11 
OR %r8 %r11 
JPT .guitar_stuff %r9 
JUC %r9 
ADDI $1 %r11 
JPT .glyph_loop %r9 
CMPU %r11 %r10 
JLS %r9 
LOAD %r0 %r14 
SUBI $1 %r0 
STOR %r0 %r14 
JPT .guitar_stuff %r9 
JUC %r9 
ADDI $1 %r11 
JPT .busy_loop %r9 
CMPU %r11 %r10 
JHI %r9 
LOAD %r0 %r11 
JPT .glyph_next %r9 
ANDI $0 %r1 
ORI $125 %r1 
LSHI $2 %r1 
CMP %r0 %r1 
JEQ %r9 
ANDI $0 %r13 
ORI $15 %r13 
LSHI $12 %r13 
NOT %r13 
AND %r0 %r13 
ANDI $0 %r6 
ADDI $120 %r6 
LSHI $2 %r6 
JPT .bump %r9 
CMP %r13 %r6 
JLT %r9 
LOAD %r6 %r14 
SUBI $1 %r6 
STOR %r6 %r14 
ANDI $0 %r6 
ADDI $125 %r6 
LSHI $2 %r6 
STOR %r6 %r11 
JPT .glyph_next %r9 
JUC %r9 
