.model small
.stack 100h

.data
msg db 'Factorial = $'

.code
main proc
    mov ax, @data
    mov ds, ax

    lea dx, msg
    mov ah, 09h
    int 21h

    mov ax, 5
    call factorial

    ; AX = 120
    call print_num

    mov ah, 4ch
    int 21h
main endp


; ----------------------
; Recursive factorial
; Input : AX
; Output: AX = factorial
; ----------------------

factorial proc

    cmp ax, 1
    jbe base_case

    push ax

    dec ax
    call factorial

    pop bx

    mul bx

    ret

base_case:
    mov ax, 1
    ret

factorial endp


; ----------------------
; Display AX in decimal
; ----------------------

print_num proc

    xor cx, cx
    mov bx, 10

convert:
    xor dx, dx
    div bx

    push dx
    inc cx

    cmp ax, 0
    jne convert

display_digit:
    pop dx
    add dl, '0'

    mov ah, 02h
    int 21h

    loop display_digit

    ret
print_num endp

end main