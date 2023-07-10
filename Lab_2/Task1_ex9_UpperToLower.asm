.MODEL SMALL
.STACK 100H

.CODE
MAIN PROC 
          
    MOV CX,3; set the loop counter to 3
    start_loop:
    
    ;OUTPUT ?
    MOV AH,2
    MOV DL,'?'
    INT 21H
    
    ;INPUT A CHARACTER  
    MOV AH,1
    INT 21H
    MOV BL,AL 
    ADD BL,32 
    ;GOTO NEW LINE
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H  
    ;-----------------
    ;OUTPUT LOWERCASE
    MOV AH,2
    MOV DL,BL
    INT 21H  
    ;GOTO NEW LINE
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H  
    
    LOOP start_loop ; decrement CX and jump to start_loop if CX is not zero
    
    
    ;RETURN TO 
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP
END MAIN