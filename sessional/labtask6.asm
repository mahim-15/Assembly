.MODEL SMALL
.STACK 100H

.DATA
NUM  DB 4
FACT DW ?

.CODE
MAIN PROC

    MOV AX,@DATA
    MOV DS,AX

    MOV AL,NUM
    XOR AH,AH

    CALL FACTORIAL

    MOV FACT,AX

    ; Print result
    CALL PRINT_DECIMAL

    MOV AH,4CH
    INT 21H

MAIN ENDP


;-------------------------
; Factorial Procedure
;-------------------------
FACTORIAL PROC

    PUSH BX
    PUSH CX

    MOV BX,AX
    MOV CX,AX

    DEC CX

    CMP CX,0
    JE DONE

L1:
    MUL CX
    LOOP L1

DONE:
    POP CX
    POP BX

    RET

FACTORIAL ENDP


;-------------------------
; Print AX as decimal
;-------------------------
PRINT_DECIMAL PROC

    XOR CX,CX
    MOV BX,10

CONVERT:
    XOR DX,DX
    DIV BX

    PUSH DX
    INC CX

    CMP AX,0
    JNE CONVERT

DISPLAY:
    POP DX

    ADD DL,30H

    MOV AH,02H
    INT 21H

    LOOP DISPLAY

    RET

PRINT_DECIMAL ENDP

END MAIN