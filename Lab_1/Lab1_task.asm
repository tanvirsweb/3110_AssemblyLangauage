.MODEL SMALL
.STACK 100H
.DATA
    A DW ?
    B DW ?
    SUM DW ?
.CODE
MAIN PROC
    ;OUTPUT ?
    MOV AH,2
    MOV DL,'?'
    INT 21H
    
    ;INPUT A CHARACTER  
    MOV AH,1
    INT 21H
    MOV BL,AL
    
    ;GOTO NEW LINE
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H  
    
    ;-----------------
    ;OUTPUT ?
    MOV AH,2
    MOV DL,'?'
    INT 21H
    
    ;INPUT A CHARACTER  
    MOV AH,1
    INT 21H
    ADD BL,AL
    SUB BL,48 
    
    ;GOTO NEW LINE
    MOV AH,2 ;PRINT MODE
    MOV DL,0DH  
    INT 21H
    MOV DL,0AH
    INT 21H
    
    
    ;DISPLAY CHARACTER
    MOV DL,BL
    INT 21H   
    
    ;RETURN TO 
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP
END MAIN