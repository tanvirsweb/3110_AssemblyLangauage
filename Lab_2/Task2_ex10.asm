.MODEL SMALL
.STACK 100H
.DATA
    A DB "ENTER A HEX DIGIT: $" 
    MSG DB 10,13,"1$"
    
.CODE
MAIN PROC
   
    MOV AX,@DATA
    MOV DS,AX 
    
    LEA DX,A
    MOV AH,9
    INT 21H
    
    
            
    ;INPUT A CHARACTER  
    MOV AH,1
    INT 21H
    MOV BL,AL  
    
    SUB BL,17
    
    ;PRINT 1  
    MOV AH,9
    LEA DX,MSG
    INT 21H
    
    MOV AH,2
    MOV Dl,BL
    INT 21H
    
    ;RETURN TO 
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP
END MAIN