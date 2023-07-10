.MODEL SMALL
.STACK 100H 
.DATA
    MSG_ENTER DW 10,13,"ENTER A HEX DIGIT: $" 
    MSG_DEC DW 10,13,"IN DECIMAL IT IS: $"
    MSG_WRONG_INPUT DW 10,13,"ILLEGAL CHARACTER - ENTER 0 .. 9 OR A .. F:$"
    ONE DW '1$'
    AGAIN DW 10,13,10,13,'DO YOU WANT TO DO IT AGAIN(YES:y/Y,NO:OTHER) ? $'
    
    T DW 10,13,10,13,'EXIT PROGRAM$'

.CODE
MAIN PROC  
    MOV AX,@DATA
    MOV DS,AX
            
    MOV BH,0
            
    ENTER_HEX:    
    ;ENTER HEX DIGIT    
    LEA DX,MSG_ENTER
    MOV AH,9
    INT 21H    
    
    ;INPUT A CHARACTER  
    MOV AH,1
    INT 21H
    MOV BL,AL 
     
    ;IF BL>=A && BL <=F 
    CMP BL,'A'
    JNGE ELSE_IF
    CMP BL,'F'
    JNLE ELSE_IF 
          
    ;PRINT DEC MSG
    LEA DX,MSG_DEC
    MOV AH,9
    INT 21H
          
    ;PRINT 1
    LEA DX,ONE
    MOV AH,9
    INT 21H 
    
    SUB BL,17 
    MOV AH,2  
    MOV DL,BL
    INT 21H
    
    JMP END_IF
    
    ELSE_IF:  
    ;BL>=0 , BL<=9
    CMP BL,'0'
    JNGE ELSE
    CMP BL,'9'
    JNLE ELSE 
     
    ;PRINT DEC MSG
    LEA DX,MSG_DEC
    MOV AH,9
    INT 21H
    
    MOV AH,2
    MOV DL,BL
    INT 21H
    
    JMP END_IF
    
    ELSE:
    ;WRONG INPUT
    LEA DX,MSG_WRONG_INPUT
    MOV AH,9
    INT 21H 
    
    INC BH
    CMP BH,3
    JNGE ENTER_HEX
    JGE EXIT
    
    
    END_IF:
    LEA DX,AGAIN  
    MOV AH,9
    INT 21H
    
    MOV AH,1
    INT 21H 
    MOV BL,AL
    
    CMP BL,'Y'
    JE ENTER_HEX
    
    CMP BL,'y'
    JE ENTER_HEX
     
    
    EXIT: 
    LEA DX,T
    MOV AH,9
    INT 21H
    
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP
END MAIN