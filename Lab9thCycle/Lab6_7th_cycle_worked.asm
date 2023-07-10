.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB 'ENTER A CHARACTER:', 0DH, 0AH, '$'
MSG_BIN DB 0DH,0AH,'BINARY OF ASCII VALUE OF INPUT CHARACTER: $'
MSG_REV DB 0DH,0AH,'REVERSE BINARY OF ASCII VALUE OF INPUT CHARACTER: $'
ODD DB  0DH, 0AH,'REVERSE BINARY OF INPUT CHARACTER IS: ODD$'
EVEN DB 0DH, 0AH,'REVERSE BINARY OF INPUT CHARACTER IS: EVEN$'
MSG_CNT1 DB 0DH,0AH,'NUMBER OF 1 IN ASCII VALUE: $'
CNT1 DB ?
 

.CODE
MAIN PROC
    ; initialize DS
    MOV AX, @DATA
    MOV DS, AX 
    
    MOV AH, 9 
    LEA DX,MSG1;INPUT PROMT
    INT 21H
    
    MOV AH, 1
    INT 21H ;READ CHAR IN AL
    MOV BL,AL
    MOV BH,AL
    MOV CNT1,'0';INITIALIZE
    
    
    ;DISPALY BINARY
    MOV AH,9 
    LEA DX,MSG_BIN
    INT 21H  
    
    MOV AH,2    
    MOV CX,8
    BINARY_LOOP: 
        ROL BL,1
        ;IF CF==1 
        JC IF
        
        MOV DL,'0'
        JNC ENDIF:
        
        IF:
        MOV DL,'1'
        ENDIF: 
        INT 21H
     LOOP BINARY_LOOP 
     
     
    ;DISPALY BINARY REVERSE
    MOV AH,9 
    LEA DX,MSG_REV
    INT 21H  
    
    MOV AH,2
    MOV CX,8
    REV_LOOP: 
        ROR BH,1
        ;IF CF==1 
        JC IFR
        
        MOV DL,'0'
        JNC ENDIFR:
        
        IFR:
        MOV DL,'1'
        ADD CNT1,1;INCREASE NUMBER OF ONE IN ASCII VALUE
        ENDIFR: 
        INT 21H
    LOOP REV_LOOP
    
    ;EVEN/ODD?
    MOV AH,9
    ROL AL,1;MSB OF MAIN NUM= LSB OF REV-> IF 0: rev is EVEN,ELSE:ODD 
    JNC D_EVEN
    LEA DX,ODD
    JC END_C
    D_EVEN: 
    LEA DX,EVEN
    END_C:
    INT 21H                               
    
    ;DISPLAY NUMBER OF ONE IN ASCII VALUE  
    MOV AH,9
    LEA DX,MSG_CNT1
    INT 21H
    MOV AH,2
    MOV DL,CNT1
    INT 21H
    
    EXIT:
    MOV AH, 4CH
    INT 21H
    MAIN ENDP
END MAIN

;enter a character,binary of it's ascii value.
;Reverse of the binary.
;The no(REV) is even/odd.
;No of 1 in ascii value's binary