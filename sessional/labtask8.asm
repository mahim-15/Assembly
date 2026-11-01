.MODEL SMALL
.STACK 100H

.DATA
A DB 02H
B DB 03H
C DB 04H
D DB 02H
RESULT DB ?

.CODE

MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; -------------------------
    ; Calculate A × B
    ; -------------------------
    MOV AL, A
    MOV BL, B
    MUL BL              ; AX = A × B

    ; -------------------------
    ; Add C
    ; -------------------------
    MOV BL, C
    XOR BH, BH
    ADD AX, BX          ; AX = (A × B) + C

    ; -------------------------
    ; Divide by D
    ; -------------------------
    MOV BL, D
    XOR BH, BH
    XOR DX, DX

    DIV BX              ; AX = Result
                        ; DX = Remainder

    MOV RESULT, AL

    ; -------------------------
    ; Display result on
    ; 7-segment display
    ; -------------------------
    MOV AL, RESULT      ; AL = 05H

    ; 7-segment code for 5
    MOV AL, 6DH

    OUT 1CH, AL

    ; -------------------------
    ; Stop program
    ; -------------------------
    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN