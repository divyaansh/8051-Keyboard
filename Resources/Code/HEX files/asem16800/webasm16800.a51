ORG 0h

RS BIT P3.0
RW BIT P3.1
EN BIT P3.2

CLR RS
CLR RW
MOV A,#0Ch
ACALL ENPULSE
MOV A,#01h
ACALL ENPULSE
MOV A,#80h
ACALL ENPULSE

SETB RS
MOV A,#4Fh
ACALL ENPULSE
AGAIN: SJMP AGAIN

ENPULSE:
	MOV P2,A
	SETB EN
	ACALL DELAY
	CLR EN
	ACALL DELAY
RET

DELAY:
	MOV R3,#50
	OUTER:
		MOV R4,#255
		INNER:
			DJNZ R4,INNER
		DJNZ R3,OUTER
RET

END
