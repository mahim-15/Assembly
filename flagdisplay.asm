.MODEL SMALL
.STACK 100H

.DATA
msg1 DB 'After 5 + 3:$'
msg2 DB 0DH,0AH,'CF = $'
msg3 DB 0DH,0AH,'ZF = $'
msg4 DB 0DH,0AH,'SF = $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Perform operation
    MOV AL, 5
    ADD AL, 3

    ; Display message
    LEA DX, msg1
    MOV AH, 9
    INT 21H

    ; Display CF
    LEA DX, msg2
    MOV AH, 9
    INT 21H

    JC CARRY
    MOV DL, '0'
    JMP PRINT_CF

CARRY:
    MOV DL, '1'

PRINT_CF:
    MOV AH, 2
    INT 21H

    ; Display ZF
    LEA DX, msg3
    MOV AH, 9
    INT 21H

    JZ ZERO
    MOV DL, '0'
    JMP PRINT_ZF

ZERO:
    MOV DL, '1'

PRINT_ZF:
    MOV AH, 2
    INT 21H

    ; Display SF
    LEA DX, msg4
    MOV AH, 9
    INT 21H

    JS SIGN
    MOV DL, '0'
    JMP PRINT_SF

SIGN:
    MOV DL, '1'

PRINT_SF:
    MOV AH, 2
    INT 21H

    ; Exit
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN