.model small
.stack
.DATA

  NUM DB ?
  MSG2 DB 10,13,'NOT PRIME $'
  MSG3 DB 10,13,'PRIME $'
.code
main proc 
    mov ax,@DATA
    mov ds,ax
    ;input a number
    call indec  ;number in AX
    push ax     ;save number
    ;move cursor to a newline
    mov ah,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    ;output the number
    pop ax      ;retrieve number
    call outdec
    ;dos exit
    mov ah,4ch
    int 21h
main endp

;outdec     
outdec proc
    ;prints ax as a signed decimal integer
    ;input: AX
    ;output: none
    push ax     ;save registers
    push bx
    push cx
    push dx
    ;if ax<0
    or ax,ax    ;ax<0?
    jge @end_if1;no, >0
    ;then
    push ax     ;save number
    mov dl,'-'  ;get '-'
    mov ah,2    ;print char function
    int 21h     ;print '-'
    pop ax      ;get ax back
    neg ax      ;ax = -ax
@end_if1:
;get decimal digits
    xor cx,cx   ;cx counts digits
    mov bx,10d  ;bx has divisor
@repeat1:
    xor dx,dx   ;prepare high word of dividend
    div bx      ;ax=quotient, dx=remainder
    push dx     ;save remainder on stack
    inc cx      ;count=count+1
;until
    or ax,ax    ;quotient=0?
    jne @repeat1;no, keep going
;convert digits to characters and print
    mov ah,2    ;print char function
;for count times do
@print_loop:
    pop dx      ;digit in DL
    or dl,30h   ;convert to character
    int 21h     ;print digit
    loop @print_loop;loop until done
;end_for
    pop dx      ;restore registers
    pop cx
    pop bx
    pop ax
    ret
outdec endp




;indec  

indec proc
    ;reads a number in range 032768 to 32767
    ;input: none
    ;output: ax=binary equivalent of number
    push bx     ;save registers used
    push cx
    push dx
;print prompt
@begin:
    mov ah,2
    mov dl,'?'
    int 21h     ;print '?'
;total=0
    xor bx,bx   ;bx holds total
    ;negative=false
    xor cx,cx   ;cx holds sign
;read a character
    mov ah,1
    int 21h     ;character in al
    ;case character of
    cmp al,'-'  ;minus sign?
    je @minus   ;yes, set sign
    cmp al,'+'  ;plus sign
    je  @plus   ;ues, get another character
    jmp @repeat2;start processing characters 
@minus:
    mov cx,1    ;negative=true
@plus:
    int 21h     ;read a character
;end_case
@repeat2:
;if character is between '0' and '9'
    cmp al,'0'  ;character>='0'?
    jnge @not_digit ;no, illegal character
;then convert character to a digit
    and ax,000fh ;convert to digit
    push ax     ;save on stack
;total = total*10+digit
    mov ax,10   ;get 10
    mul bx      ;ax=total*10
    pop bx      ;retrieve digit
    add bx,ax   ;total=total*10+digit
;read a character
    mov ah,1
    int 21h
    cmp al,0dh  ;carriage return?
    jne @repeat2;no, keep going
;until cr
    mov ax,bx   ;store number in ax 
                          
    ;our number is now in AX
    ;checking prime number    
     
   push ax  
    
   mov num,al
   
   cmp al,1
   jle lbl2
   mov ah,00
   cmp al,3
   jle lbl3
   mov ah,00
   
   mov cl,2
   div cl
   mov cl,al ;now quotient is in cl
   
lbl1:

    mov ah,00
    mov al,num
    div cl
    
    cmp ah,00;checking if remainder is 0
    jz lbl2
    dec cl
    cmp cl,1
    jne lbl1
    jmp lbl3
    
lbl2:
    mov ah,9
    lea dx,msg2
    int 21h
    jmp after
    
lbl3:
    mov ah,9
    lea dx,msg3
    int 21h 

  
    
after:  
    
;if negative
    or cx,cx    ;negative number
    je @exit    ;no, exit
;then
    neg ax      ;yes, negate
;end_if
@exit:
    pop ax
    pop dx      ;restore registers
    pop cx
    pop bx
    ret         ;and return
;here if illegal character entered
@not_digit:
    mov ah,2    ;move cursor to a new line
    mov al,0dh
    int 21h
    mov dl,0ah
    int 21h
    jmp @begin  ;go to beginning
indec endp
 
end main