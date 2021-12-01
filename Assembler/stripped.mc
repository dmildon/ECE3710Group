ADDI $5 %r15 
ADDI $0 %r14 
ADDI $10 %r13 
ADDI $100 %r12 
ADDI $1 %r11 
ADDI $3 %r10 
ADDI $9 %r8 
ADDI $7 %r7 
ADDI $0 %r6 
ADDCI $0 %r0 
CMPI $28 %r9 
BNE $1 
SUB %r10 %r15 
CMPI $35 %r9 
BNE $1 
ADD %r10 %r15 
CMPI $29 %r9 
BNE $1 
SUB %r10 %r14 
ADD %r11 %r14 
CMP %r15 %r7 
BGE $2 
SUB %r15 %r15 
ADD %r7 %r15 
CMP %r14 %r7 
BGE $2 
SUB %r14 %r14 
ADD %r7 %r14 
ADD %r15 %r13 
ADD %r14 %r12 
ADDCI $1 %r0 
ADDI $1 %r6 
JUC %r8 
