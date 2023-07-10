.MODEL SMALL
.STACK 100H

.DATA
MSG_INP DW 0DH,0AH,"ENTER A STRING(A-Z): $" 
MSG_ERR DW 0DH,0AH,"WRONG INPUT.TRY AGAIN:$"
MSG_OUT DW 0DH,0AH,"LONGEST CONSECUTIVE STRING IS:$"

.CODE
MAIN PROC
    
     MOV AX, @DATA
     ; initialize DS                
     MOV DS, AX
     
     TRY_AGAIN:
     LEA DX, MSG_INP     
     MOV AH, 9
     INT 21H   
     
     MOV AH,1;INPUT 1ST CHAR
     INT 21H
             
     
     ;VALID INPUT?1ST CHAR                      
     CMP AL,0DH ;AL= CR?
     JE TRY_AGAIN                 
     CMP AL,41H ;AL<'A'
     JB TRY_AGAIN
     CMP AL,5AH ;AL>'Z' JA->JUMP IF ABOVE
     JA TRY_AGAIN 
     
     MOV BL,AL;BL=AL->1ST CHAR OF LONGEST CONSECUTIVE STRING
     MOV BH,AL;BH=AL->LAST CHAR OF ...
     MOV DH,AL;DL=AL
     MOV DL,1;
     MOV CL,1;    
     
     
     START_LOOP:
     INT 21H;INPUT ANOTHER CHAR
      
     ;VALID INPUT?I'TH CHAR                      
     CMP AL,0DH ;AL= CR?
     JE TRY_AGAIN                 
     CMP AL,41H ;AL<'A'
     JB TRY_AGAIN
     CMP AL,5AH ;AL>'Z' JA->JUMP IF ABOVE
     JA TRY_AGAIN         
              
              
     END_LOOP:
     
     MOV AH,2
     MOV DL,AL
     INT 21H
            
            
     EXIT:
     MOV AH,4CH
     INT 21H
    MAIN ENDP
END MAIN