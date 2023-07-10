.MODEL SMALL
.STACK 100H

.DATA
MSG DW 10,13,"Enter A STRING:$" 
NL DW 10,13,"$"
A   db   64, 0, 64 dup (0)


.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX     
     
    ;PROMT USER TO INPUT 
    LEA DX,MSG
    MOV AH,9
    INT 21H
                
            
    MOV AH,0AH
    LEA DX,A
    INT 21H 
    
    LEA DX,A
    MOV AH,9H
    INT 21H
    
    EXIT:
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN