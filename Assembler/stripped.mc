ADDI $1 %r15 
ADDI $0 %r14 
ADDI $10 %r13 
ADDI $100 %r12 
ADDI $1 %r11 
ADDI $3 %r10 
ADDI $11 %r8 
ADDI $122 %r1 
ADDI $3 %r7 
ADDI $-3 %r4 
ADDI $0 %r6 
KEY %r0 %r9 
CMPI $41 %r9 
BNE $18 
SUB %r0 %r0 
SUB %r1 %r1 
SUB %r2 %r2 
SUB %r3 %r3 
SUB %r4 %r4 
SUB %r5 %r5 
SUB %r6 %r6 
SUB %r7 %r7 
SUB %r8 %r8 
SUB %r9 %r9 
SUB %r10 %r10 
SUB %r11 %r11 
SUB %r12 %r12 
SUB %r13 %r13 
SUB %r14 %r14 
SUB %r15 %r15 
JUC %r0 
SUB %r5 %r5 
ADDI $63 %r5 
CMPI $30 %r6 
JNE %r5 
SUB %r6 %r6 
CMPI $28 %r9 
BNE $2 
SUB %r10 %r15 
CMPI $35 %r9 
BNE $2 
ADD %r10 %r15 
CMPI $29 %r9 
BNE $2 
SUB %r10 %r14 
ADD %r11 %r14 
CMP %r15 %r7 
BLE $3 
SUB %r15 %r15 
ADD %r7 %r15 
CMP %r14 %r7 
BLE $3 
SUB %r14 %r14 
ADD %r7 %r14 
CMP %r15 %r4 
BGE $3 
SUB %r15 %r15 
ADD %r4 %r15 
CMP %r14 %r4 
BGE $3 
SUB %r14 %r14 
ADD %r4 %r14 
CMPI $0 %r12 
BLT $2 
MULI $-1 %r14 
CMPI $0 %r13 
BLT $2 
MULI $-1 %r15 
SUB %r0 %r0 
ADDI $61 %r0 
MULI $10 %r0 
CMP %r0 %r13 
BGT $2 
MULI $-1 %r15 
SUB %r0 %r0 
ADDI $16 %r0 
MULI $10 %r0 
SUBI $14 %r0 
CMP %r0 %r13 
BLT $11 
SUB %r0 %r0 
ADDI $38 %r0 
MULI $10 %r0 
ADDI $5 %r0 
CMP %r0 %r12 
JGT %r1 
SUB %r15 %r15 
SUB %r14 %r14 
SUB %r11 %r11 
SUB %r10 %r10 
SUB %r0 %r0 
ADDI $26 %r0 
MULI $10 %r0 
CMP %r0 %r13 
BLT $11 
SUB %r0 %r0 
ADDI $28 %r0 
MULI $10 %r0 
ADDI $5 %r0 
CMP %r0 %r12 
JGT %r1 
SUB %r15 %r15 
SUB %r14 %r14 
SUB %r11 %r11 
SUB %r10 %r10 
SUB %r0 %r0 
ADDI $41 %r0 
MULI $10 %r0 
SUBI $14 %r0 
CMP %r0 %r13 
BLT $11 
SUB %r0 %r0 
ADDI $43 %r0 
MULI $10 %r0 
ADDI $5 %r0 
CMP %r0 %r12 
JGT %r1 
SUB %r15 %r15 
SUB %r14 %r14 
SUB %r11 %r11 
SUB %r10 %r10 
ADD %r15 %r13 
ADD %r14 %r12 
WAIT %r12 %r13 
ADDI $1 %r6 
JUC %r8 
