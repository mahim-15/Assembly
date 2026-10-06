.MODEL SMALL
.STACK 100H

.data

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Read a character from keyboard
    MOV AH, 01H
    INT 21H

    ; Move to the beginning of the next line
    MOV DL, 0DH       ; Carriage Return
    MOV AH, 02H
    INT 21H

    MOV DL, 0AH       ; Line Feed
    MOV AH, 02H
    INT 21H

    ; Display the character
    ; The character read by AH=01H is stored in AL
    MOV DL, AL
    MOV AH, 02H
    INT 21H

    ; Exit program
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN