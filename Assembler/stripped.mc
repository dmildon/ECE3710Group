MOVI $0 %r0 
MOVI $13 %r1 
MULI $10 %r1 
ADDI $5 %r1 
MOVI $0 %r2 
MOVI $13 %r3 
MULI $10 %r3 
ADDI $10 %r3 
MOVI $-3 %r4 
MOVI $15 %r5 
MULI $10 %r5 
ADDI $1 %r5 
MOVI $0 %r6 
MOVI $3 %r7 
MOVI $23 %r8 
MOVI $0 %r9 
MOVI $3 %r10 
MOVI $1 %r11 
MOVI $100 %r12 
MOVI $10 %r13 
MOVI $0 %r14 
MOVI $1 %r15 
KEY %r0 %r9 
CMPI $41 %r9 
BNE $3 
MOVI $0 %r0 
JUC %r0 
MOVI $54 %r5 
CMPI $25 %r6 
JGE %r5 
MOVI $0 %r6 
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
BLE $2 
MOVI $3 %r15 
CMP %r14 %r7 
BLE $2 
MOVI $3 %r14 
CMP %r15 %r4 
BGE $2 
MOVI $-3 %r15 
CMP %r14 %r4 
BGE $2 
MOVI $-3 %r14 
CMPI $0 %r12 
BLE $3 
MULI $-1 %r14 
MOVI $1 %r12 
CMPI $0 %r13 
BLE $3 
MULI $-1 %r15 
MOVI $0 %r13 
MOVI $61 %r0 
MULI $10 %r0 
CMP %r0 %r13 
BGT $2 
MULI $-1 %r15 
MOVI $16 %r0 
MULI $10 %r0 
SUBI $14 %r0 
CMP %r0 %r13 
BLT $11 
MOVI $38 %r0 
MULI $10 %r0 
ADDI $5 %r0 
CMP %r0 %r12 
JGT %r1 
MOVI $0 %r15 
MOVI $0 %r14 
MOVI $0 %r11 
MOVI $0 %r10 
JUC %r3 
MOVI $26 %r0 
MULI $10 %r0 
CMP %r0 %r13 
BLT $11 
MOVI $28 %r0 
MULI $10 %r0 
ADDI $5 %r0 
CMP %r0 %r12 
JGT %r1 
MOVI $0 %r15 
MOVI $0 %r14 
MOVI $0 %r11 
MOVI $0 %r10 
JUC %r3 
MOVI $41 %r0 
MULI $10 %r0 
SUBI $14 %r0 
CMP %r0 %r13 
BLT $11 
MOVI $43 %r0 
MULI $10 %r0 
ADDI $5 %r0 
CMP %r0 %r12 
JGT %r1 
MOVI $0 %r15 
MOVI $0 %r14 
MOVI $0 %r11 
MOVI $0 %r10 
JUC %r3 
MOVI $52 %r0 
MULI $10 %r0 
ADDI $5 %r0 
CMP %r0 %r13 
BLT $11 
MOVI $30 %r0 
MULI $10 %r0 
ADDI $5 %r0 
CMP %r0 %r12 
JGT %r1 
MOVI $0 %r15 
MOVI $0 %r14 
MOVI $0 %r11 
MOVI $0 %r10 
JUC %r3 
MOVI $41 %r0 
MULI $10 %r0 
CMP %r0 %r12 
JGT %r1 
MOVI $0 %r15 
MOVI $0 %r14 
MOVI $0 %r11 
MOVI $0 %r10 
JUC %r3 
ADD %r15 %r13 
ADD %r14 %r12 
WAIT %r12 %r13 
ADDI $1 %r6 
JUC %r8 
CMPI $10 %r13 
BGE $7 
CMPI $70 %r13 
BLE $5 
MOVI $102 %r12 
MULI $20 %r12 
ADDI $8 %r12 
BUC $4 
MOVI $102 %r12 
MULI $10 %r12 
ADDI $4 %r12 
WAIT %r12 %r13 
KEY %r0 %r9 
CMPI $41 %r9 
JNE %r5 
MOVI $0 %r0 
JUC %r0 
