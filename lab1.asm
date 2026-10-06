.model small
.stack 100h

.data
    num1 db 10
    num2 db 5

.code
main proc

    mov ax, @data
    mov ds, ax

    ; -------------------------
    ; MOV Operation
    ; -------------------------
    mov al, num1
    mov bl, al

    ; -------------------------
    ; XCHG Operation
    ; -------------------------
    xchg al, bl

    ; -------------------------
    ; ADD Operation
    ; -------------------------
    mov al, num1
    add al, num2

    ; -------------------------
    ; SUB Operation
    ; -------------------------
    mov al, num1
    sub al, num2

    ; -------------------------
    ; INC Operation
    ; -------------------------
    mov al, num1
    inc al

    ; -------------------------
    ; DEC Operation
    ; -------------------------
    mov al, num1
    dec al

    ; -------------------------
    ; NEG Operation
    ; -------------------------
    mov al, num1
    neg al

    ; Exit program
    mov ah, 4ch
    int 21h

main endp
end main