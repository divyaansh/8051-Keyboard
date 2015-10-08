ORG   0H 
;MOV   A,#38H;INIT. LCD 2 LINES, 5X7 MATRIX 
;ACALL COMNWRT ;call command subroutine 
;ACALL DELAY   ;give LCD some time 
MOV   A,#0CH;display on, cursor off
ACALL COMNWRT ;call command subroutine 
ACALL DELAY   ;give LCD some time 
MOV   A,#01;clear LCD 
ACALL COMNWRT ;call command subroutine 
ACALL DELAY   ;give LCD some time 
;MOV   A,#06H;shift cursor right 
;ACALL COMNWRT ;call command subroutine 
;ACALL DELAY   ;give LCD some time 
MOV   A,#80H;cursor at line 1, pos. 0 
ACALL COMNWRT ;call command subroutine 
ACALL DELAY   ;give LCD some time 

MOV   A,#4EH ;display letter N 
ACALL DATAWRT  ;call display subroutine 
ACALL DELAY    ;give LCD some time 
MOV   A,#4FH ;display letter O 
ACALL DATAWRT  ;call display subroutine 
AGAIN:  SJMP  AGAIN    ;stay here 

COMNWRT:               ;send command to LCD 
;ACALL READY       ;is LCD ready? 
MOV   P2,A     ;copy regA to port 1 
CLR   P3.0     ;RS=0 for command 
CLR   P3.1     ;R/W=0 for write 
SETB  P3.2     ;E=1 for high pulse 
ACALL DELAY    ;give LCD some time 
CLR   P3.2     ;E=0 for H-to-L pulse 
RET 

DATAWRT:               ;write data to LCD 
;ACALL READY       ;is LCD ready? 
MOV   P2,A     ;copy regA to port 1 
SETB  P3.0     ;RS=1 for data 
CLR   P3.1     ;R/W=0 for write 
SETB  P3.2     ;E=1 for high pulse 
ACALL DELAY    ;give LCD some time 
CLR   P3.2     ;E=0 for H-to-L pulse 
RET 

READY: 
SETB  P2.7        ;make P2.7 input port 
CLR   P3.0        ;RS=0 access command reg 
SETB  P3.1        ;R/W=1 read command reg 
;read command regand check busy flag 
BACK:SETB  P3.2        ;E=1 for H-to-L pulse 
MOV   R4,#255  ;R4 = 255 
HERE3:   DJNZ  R4,HERE3
CLR   P3.2        ;E=0 H-to-L pulse 
JB    P2.7,BACK   ;stay until busy flag=0 
RET 

DELAY:  
MOV   R3,#50   ;50 or higher for fast CPUs 
HERE2:  MOV   R4,#255  ;R4 = 255 
HERE:   DJNZ  R4,HERE  ;stay until R4 becomes 0 
DJNZ  R3,HERE2 
RET 

END  
