.MODEL SMALL
.STACK 100H 
.DATA
    MSG1 DW "ENTER 3 INITIALS:$" 

.CODE
MAIN PROC  
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,MSG1
    MOV AH,9
    INT 21H
    
    ;INPUT 1ST CHARACTER  
    MOV AH,1
    INT 21H
    MOV BL,AL 
    ADD BL,32         
  
    
    ;INPUT 2ND CHARACTER  
    MOV AH,1
    INT 21H
    MOV BH,AL 
    ADD BH,32 
    
    ;INPUT 3RD CHARACTER  
    MOV AH,1
    INT 21H  
    MOV CL,AL
    ADD CL,32 
    
    ;GOTO NEW LINE
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
     
    ;-----------------
    ;OUTPUT LOWERCASE 1ST
    MOV AH,2
    MOV DL,BL
    INT 21H  
    ;GOTO NEW LINE
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H 
    
    ;-----------------
    ;OUTPUT LOWERCASE 2ND
    MOV AH,2
    MOV DL,BH
    INT 21H  
    ;GOTO NEW LINE
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H 
    
    ;-----------------
    ;OUTPUT LOWERCASE 3RD
    MOV AH,2
    MOV DL,CL
    INT 21H   
    
    ;RETURN TO 
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP
END MAIN