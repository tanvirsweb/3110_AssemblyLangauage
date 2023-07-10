.model small
.stack 100h

.data
input_string DB 100 DUP('$') ; Define an array to store the input string
message DB 'Enter a string: $'
output_message DB 'You entered: $'

.code
main PROC
    mov ax, @data
    mov ds, ax

    mov ah, 09h
    lea dx, message
    int 21h  ; Print the message asking for input

    mov ah, 0Ah
    mov dx, OFFSET input_string
    int 21h  ; Read the string from the user

    ; Print the entered string
    mov ah, 09h
    lea dx, output_message
    int 21h  ; Print the output message

    ; Loop to print each character of the string
    mov si, OFFSET input_string
print_loop:
    mov al, [si]
    cmp al, '$'  ; Check if the end of string is reached
    je end_print
    mov ah, 02h
    int 21h  ; Print the character
    inc si
    jmp print_loop

end_print:
    mov ah, 4Ch
    int 21h  ; Exit the program
main ENDP

end main
