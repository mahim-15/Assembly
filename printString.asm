.MODEL SMALL
.STACK 100H

.DATA
    MSG1 DB 'Enter a string: $'
    BUFFER DB 50          ; Maximum number of characters
           DB ?           ; Actual number of characters entered
           DB 50 DUP(?)   ; Storage for characters

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Display message
    LEA DX, MSG1
    MOV AH, 09H
    INT 21H

    ; Read string from keyboard
    LEA DX, BUFFER
    MOV AH, 0AH
    INT 21H

    ; Move to next line
    MOV DL, 0DH
    MOV AH, 02H
    INT 21H

    MOV DL, 0AH
    MOV AH, 02H
    INT 21H

    ; Print the entered string
    LEA SI, BUFFER+2
    MOV CL, [BUFFER+1]
    MOV CH, 00H

PRINT:
    MOV DL, [SI]
    MOV AH, 02H
    INT 21H

    INC SI
    LOOP PRINT

    ; Exit
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN