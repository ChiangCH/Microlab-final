;------------------------------------------
; TRIAL: using P1.0 and P1.1 as triggered
;------------------------------------------

SPEAKER REG P0.0
TONE    REG R0
MCOUNT  REG R1
TEMPO   REG R2
TIME    REG R3


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
	MOV MCOUNT,#0	;read the 1st row of table
	MOV R4,#1	;choose the first entry from table
	CALL BEGIN2	;call the buzzer function
	
    JMP BEGIN

L1:
	MOV MCOUNT,#2	;read the 2nd row of table
	MOV R4,#1	;choose the first entry from table
	CALL BEGIN2

    JMP BEGIN


BEGIN2:
	MOV     DPTR,#SCALE
	MOV     A,MCOUNT
	MOVC    A,@A+DPTR
	MOV     TONE,A
	INC     MCOUNT
	MOVC    A,@A+DPTR
	MOV     TEMPO,A
	ACALL   SOUND
	INC     MCOUNT
	DJNZ    R4,BEGIN2
	;JMP    START
	
	RET

SOUND:
	MOV     TIME, #2
sound1:
	SETB    SPEAKER
	ACALL   SDELAY
	CLR     SPEAKER
	ACALL   SDELAY
	DJNZ    TIME,sound1
	DJNZ    TEMPO,SOUND
	RET

SDELAY:
	MOV     B,TONE
delay1:
	MOV     R5,#6
	DJNZ    R5,$
	DJNZ    TONE,delay1
	MOV     TONE,B
	RET
END:

SCALE:
	DB    126,131  	;do
	DB    113,147	;re
	DB    100,165	;mi
	DB    95 ,175	;fa
	DB    85 ,196	;sol
	DB    75 ,220	;la
	DB    67 ,247	;si
	DB    63 ,261	;Do
