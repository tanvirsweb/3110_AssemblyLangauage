.MODEL SMALL
.STACK 100H
.DATA  
ARR DB 100 DUP('$')

MSG_INP DB 'ENTER A STRING(like:abc def gh):', 0DH, 0AH, '$' 
NL DB 0DH,0AH,'$'
MSG_REV DB 0DH,0AH,'REVERSE OF EACH WORD OF THE LINE: $'
MSG_VOWEL DB 0DH,0AH,'NUMBER OF VOWEL IN INPUT STRING: $'

CNT1 DB ?
 

.CODE
MAIN PROC
    ; initialize DS
    MOV AX, @DATA
    MOV DS, AX 
    
    MOV AH, 9 
    LEA DX,MSG_INP;INPUT PROMT
    INT 21H        
    
    
    
    MOV CNT1,0;INITIALIZE
    
    TOP:
    MOV AL,' ';CHAR=8 BIT 
    MOV AH,0
    PUSH AX;STORE SPACE INITIALLY IN STACK
    
    LEA DX,NL;NEW LINE
    MOV AH,9
    INT 21H
    
    INP_LOOP:
        MOV AH, 1
        INT 21H ;READ CHAR IN AL
        CMP AL,0DH ;IF CARRIAGE RETURN END INPUT
        JE END_INP
        
        CMP AL,' '
        JE REV
                
        SUB AL,32;CONVERT TO CAPITAL
        MOV AH,0
        PUSH AX                          
     JMP INP_LOOP                
     
     REV:        
        POP AX
        MOV DX,AX
        MOV AH,2
        INT 21H 
         
        CMP AL,' '; AH=0 & AL=' '
        JNE REV
        JE TOP
     
    END_INP: ;END OF STRING 
    
    EXIT:
    MOV AH, 4CH
    INT 21H
    MAIN ENDP
END MAIN
;input a line: this is a test
;output: SIHT SI A TSET
;no of vowels: 4