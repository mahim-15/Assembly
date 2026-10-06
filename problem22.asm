.model small
.stack 100h

.data
msg db 13,10,'Product = $'

.code
main proc
    mov ax, @data
    mov ds, ax

    ; First number
    mov ah, 01h
    int 21h
    sub al, '0'
    mov bl, al

    ; Space
    mov dl, ' '
    mov ah, 02h
    int 21h

    ; Second number
    mov ah, 01h
    int 21h
    sub al, '0'

    ; AL x BL -> AX
    mul bl

    push ax

    lea dx, msg
    mov ah, 09h
    int 21h

    pop ax
    call print_num

    mov ah, 4ch
    int 21h
main endp


print_num proc
    xor cx, cx
    mov bx, 10

L1:
    xor dx, dx
    div bx
    push dx
    inc cx

    cmp ax, 0
    jne L1

L2:
    pop dx
    add dl, '0'

    mov ah, 02h
    int 21h

    loop L2
    ret
print_num endp

end main