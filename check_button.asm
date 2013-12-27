BEGIN:
    MOV P3,#01111111B;
    JNB P1.0, L0 
    JNB P1.1, L1 
    JNB P1.2, L2 
    JNB P1.3, L3
   
    MOV P3,#10111111B;
    JNB P1.0, L4 
    JNB P1.1, L5 
    JNB P1.2, L6 
    JNB P1.3, L7


L0:
    ADD A, #0D
    JMP LOOP1
L1:
    ADD A, #1D
    JMP LOOP1

    JMP BEGIN
