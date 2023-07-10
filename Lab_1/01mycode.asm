.MODEL SMALL
.STACK 100H 
.DATA
    ;WHERE ALL THE VARIALBLES WILL BE DECALARED
.CODE
    ;CODE SEGMENT 
    MAIN PROC ;INT MAIN
        ;STATEMENT
        ;STATEMENT
        MOV AH,1
        INT 21H
        MOV BL,AL 
        
        MOV AH,1
        INT 21H  
        MOV BH,AL
        
        MOV AH,2 
        MOV DL,BL
        INT 21H
        
        MOV AH,2
        MOV DL,BH
        INT 21H
        
        
        EXIT:
        MOV AH,4CH ;CLEAR MEMORY
        INT 21H  ;EXECUTE STATEMENT (INTRACTABLE 21H)
    MAIN ENDP


END MAIN ;EXIT(0)
