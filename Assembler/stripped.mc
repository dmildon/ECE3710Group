MOVI $0 %r0 
MOVI $12 %r1 
MULI $10 %r1 
ADDI $7 %r1 
MOVI $0 %r2 
MOVI $0 %r3 
MOVI $-3 %r4 
MOVI $0 %r5 
MOVI $0 %r6 
MOVI $3 %r7 
MOVI $19 %r8 
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
MOVI $50 %r5 
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
MOV %r7 %r15 
CMP %r14 %r7 
BLE $2 
MOV %r7 %r14 
CMP %r15 %r4 
BGE $2 
MOV %r4 %r15 
CMP %r14 %r4 
BGE $2 
MOV %r4 %r14 
CMPI $0 %r12 
BLE $3 
MULI $-1 %r14 
MOVI $0 %r12 
CMPI $0 %r13 
BLE $3 
MULI $-1 %r15 
MOVI $0 %r13 
MOVI $61 %r0 
MULI $10 %r0 
CMP %r0 %r13 
BGT $3 
MULI $-1 %r15 
MOV %r0 %r13 
MOVI $16 %r0 
MULI $10 %r0 
SUBI $14 %r0 
CMP %r0 %r13 
BLT $10 
MOVI $38 %r0 
MULI $10 %r0 
ADDI $5 %r0 
CMP %r0 %r12 
JGT %r1 
MOVI $0 %r15 
MOVI $0 %r14 
MOVI $0 %r11 
MOVI $0 %r10 
MOVI $26 %r0 
MULI $10 %r0 
CMP %r0 %r13 
BLT $10 
MOVI $28 %r0 
MULI $10 %r0 
ADDI $5 %r0 
CMP %r0 %r12 
JGT %r1 
MOVI $0 %r15 
MOVI $0 %r14 
MOVI $0 %r11 
MOVI $0 %r10 
MOVI $41 %r0 
MULI $10 %r0 
SUBI $14 %r0 
CMP %r0 %r13 
BLT $10 
MOVI $43 %r0 
MULI $10 %r0 
ADDI $5 %r0 
CMP %r0 %r12 
JGT %r1 
MOVI $0 %r15 
MOVI $0 %r14 
MOVI $0 %r11 
MOVI $0 %r10 
MOVI $52 %r0 
MULI $10 %r0 
ADDI $5 %r0 
CMP %r0 %r13 
BLT $10 
MOVI $30 %r0 
MULI $10 %r0 
ADDI $5 %r0 
CMP %r0 %r12 
JGT %r1 
MOVI $0 %r15 
MOVI $0 %r14 
MOVI $0 %r11 
MOVI $0 %r10 
MOVI $41 %r0 
MULI $10 %r0 
CMP %r0 %r12 
JGT %r1 
MOVI $0 %r15 
MOVI $0 %r14 
MOVI $0 %r11 
MOVI $0 %r10 
ADD %r15 %r13 
ADD %r14 %r12 
WAIT %r12 %r13 
ADDI $1 %r6 
JUC %r8 
