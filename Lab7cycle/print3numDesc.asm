.MODEL SMALL
.STACK 100H

.DATA
MSG DW 10,13,"Enter 3 numbers:$" 
NL DW 10,13,"$"
T DB ?
D DB ?

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX     
     
    ;PROMT USER TO INPUT 
    LEA DX,MSG
    MOV AH,9
    INT 21H
    
    MOV AH,1   
    INT 21H
    MOV BL,AL
    
    MOV AH,1
    INT 21H 
    MOV CL,AL 
    
    MOV AH,1
    INT 21H
    MOV DH,AL 
        
    
    ;APPLY BUBBLE SORT TO BL,CL,DH
    CMP BL,CL
    JG BGC
    ;ECHG BL,CL;IF BL<CL SWAP
    MOV T,BL
    MOV BL,CL
    MOV CL,T 
    
    BGC:
    CMP CL,DH
    JG CGD
    ;ECHG CL,DH;IF CL<DH SWAP  
    MOV T,CL
    MOV CL,DH
    MOV DH,T
    
    CGD:
    CMP BL,CL
    JG BGC2
    ;ECHG BL,CL;IF BL<CL SWAP 
    MOV T,BL
    MOV BL,CL
    MOV CL,T
    
    BGC2:      
    MOV D,DH       
    ;STORE VALUE IN DX TO D AS IT WILL BE OVERWRITTEN
    ;PRINT NEW LINE
    LEA DX,NL
    MOV AH,9
    INT 21H
     
    MOV AH,2
    MOV DL,BL
    INT 21H
    MOV DL,CL
    INT 21H
    MOV DL,D
    INT 21H
    
    
    EXIT:
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN