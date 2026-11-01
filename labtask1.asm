.MODEL SMALL
.STACK 100H

.DATA
ARRAY DB 12H,45H,23H,67H,34H
MAX   DB ?

.CODE
MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    LEA SI, ARRAY
    MOV AL, [SI]
    INC SI

    MOV CX, 4

NEXT:
    CMP AL, [SI]
    JAE SKIP
    MOV AL, [SI]

SKIP:
    INC SI
    LOOP NEXT

    MOV MAX, AL

    ; ---- Display MAX in hexadecimal ----

    MOV AL, MAX
    MOV BL, AL

    ; Display high digit
    MOV CL, 4
    SHR AL, CL
    CALL HEX_DISPLAY

    ; Display low digit
    MOV AL, BL
    AND AL, 0FH
    CALL HEX_DISPLAY

    MOV AH, 4CH
    INT 21H

MAIN ENDP


;--------------------------------
; Display hexadecimal digit
; Input: AL = 0 to F
;--------------------------------
HEX_DISPLAY PROC

    CMP AL, 09H
    JBE NUMBER

    ADD AL, 07H

NUMBER:
    ADD AL, 30H

    MOV DL, AL
    MOV AH, 02H
    INT 21H

    RET

HEX_DISPLAY ENDP

END MAIN