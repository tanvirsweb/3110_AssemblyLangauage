.MODEL SMALL
.STACK 100H
.DATA  
ARR DB 40 DUP('$')

MSG_INP DB 'ENTER A STRING(like:abc def gh):', 0DH, 0AH, '$' 
NL DB 0DH,0AH,'$'
MSG_REV DB 0DH,0AH,'REVERSE OF EACH WORD OF THE LINE: $'
MSG_VOWEL DB 0DH,0AH,'NUMBER OF VOWEL IN INPUT STRING: $'

CNT_V DB ?
 

.CODE
MAIN PROC
    ; initialize DS
    MOV AX, @DATA
    MOV DS, AX 
    
    MOV AH, 9 
    LEA DX,MSG_INP;INPUT PROMT
    INT 21H 
    
    LEA DX,ARR
    MOV AH,10 
    MOV ARR,100
    INT 21H;INPUT STRING UNTIL CARRIAGE RETURN 0DH
        
    
    LEA DX,MSG_REV
    MOV AH,9
    INT 21H
    
    LEA SI,ARR;ADDRESS 1ST ELEMENT OF ARRAY
    ADD SI,2;IN Arr[0]=ARRAY SIZE,Arr[1]=COUNT OF CHAR.
    MOV CNT_V,0;NO OF VOWEL=0
    
    
    CMP_LOOP:
        MOV AL,[SI]                                      
        CMP AL,0DH ;IF CARRIAGE RETURN END INPUT 0DH/13
        JE END_CMP
                
        PUSH SI                          
        MOV CX,0
     
     REV_WORD:
        MOV AL,[SI]                          
        CMP AL,' '; AH=0 & AL=' '
        JE END_REVW        
                   
        MOV AL,[SI]
        CMP AL,0DH
        JE END_REVW
        
        ;PUSH A WORD IN STACK                   
        MOV AL,[SI]
        PUSH AX
        INC SI
        INC CX
        JMP REV_WORD 
     END_REVW:
     
     CNT_VOWEL:
     
     POP AX
     CMP AL,'a'
     JE INC_VOWEL
     CMP AL,'e'
     JE INC_VOWEL
     CMP AL,'i'
     JE INC_VOWEL
     CMP AL,'o'
     JE INC_VOWEL
     CMP AL,'u'
     JE INC_VOWEL
     
     PRINT:
        JMP CONTINUE_LOOP
     
     INC_VOWEL:
        INC CNT_V
                      
     CONTINUE_LOOP:    
     MOV DL,AL     
     CMP DL,'a'
     JL L1
     CMP DL,'z'
     JG L1
     SUB DL,32
     L1:
     MOV AH,2
     INT 21H
     
     LOOP CNT_VOWEL
      
     ;PRINT SPACE
     MOV DL,' '
     MOV AH,2
     INT 21H 
     
     INC SI
     JMP CMP_LOOP                           
        
    END_CMP: ;END OF STRING 
    
     
    LEA DX,MSG_VOWEL
    MOV AH,9
    INT 21H
    
    MOV AL,CNT_V
    ADD AL,30H;CONVERT NUMBER TO ASCII VALUE
    MOV DL,AL
    MOV AH,2
    INT 21H
    
    EXIT:
    MOV AH, 4CH
    INT 21H
    MAIN ENDP
END MAIN
;input a line: this is a test (END WITH SPACE,enter)
;output: SIHT SI A TSET
;no of vowels: 4