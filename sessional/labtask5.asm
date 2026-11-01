.MODEL SMALL
.STACK 100H

.DATA
ARRAY DB 02H,04H,06H,04H,03H,01H
SUM   DW ?

.CODE
MAIN PROC

    MOV AX,@DATA
    MOV DS,AX

    LEA SI,ARRAY
    MOV CX,6
    MOV BX,0000H

NEXT:
    MOV AL,[SI]

    TEST AL,01H
    JNZ ODD

    XOR AH,AH
    ADD BX,AX

ODD:
    INC SI
    LOOP NEXT

    MOV SUM,BX

    ;-------------------------
    ; Print "SUM = "
    ;-------------------------
    MOV DL,'S'
    MOV AH,02H
    INT 21H

    MOV DL,'U'
    MOV AH,02H
    INT 21H

    MOV DL,'M'
    MOV AH,02H
    INT 21H

    MOV DL,' '
    MOV AH,02H
    INT 21H

    MOV DL,'='
    MOV AH,02H
    INT 21H

    MOV DL,' '
    MOV AH,02H
    INT 21H

    ;-------------------------
    ; Print hexadecimal result
    ;-------------------------
    MOV AX,SUM

    MOV CL,4
    SHR AL,CL
    CALL PRINT_HEX

    MOV AX,SUM
    AND AL,0FH
    CALL PRINT_HEX

    ;-------------------------
    ; Exit
    ;-------------------------
    MOV AH,4CH
    INT 21H

MAIN ENDP


;-------------------------
; Print one hexadecimal digit
; AL = 0 to F
;-------------------------
PRINT_HEX PROC

    CMP AL,09H
    JBE DIGIT

    ADD AL,07H

DIGIT:
    ADD AL,30H

    MOV DL,AL
    MOV AH,02H
    INT 21H

    RET

PRINT_HEX ENDP

END MAIN