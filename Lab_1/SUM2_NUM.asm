.MODEL SMALL
.STACK 100H
.DATA

    A DW 2  
    B DW 5
    SUM DW ?

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX  
    
    MOV AX,A
    ADD AX,B
    MOV SUM,AX 
    
    
    MOV AX,4CH  
    INT 21H 
    
      
    
    MAIN ENDP
END MAIN