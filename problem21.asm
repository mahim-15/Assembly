.model small
.stack 100h

.data
arr db 5 dup(?)
msg1 db 13,10,'Original: $'
msg2 db 13,10,'Reverse : $'
msg3 db 13,10,'Sum = $'
msg4 db 13,10,'Average = $'

.code
main proc
    mov ax, @data
    mov ds, ax

    lea si, arr
    mov cx, 5
    xor bx, bx          ; BL = sum

input_loop:
    mov ah, 01h
    int 21h

    sub al, '0'
    mov [si], al
    inc si

    add bl, al

    xor ah, ah
    push ax

    loop input_loop

    ; Original order
    lea dx, msg1
    mov ah, 09h
    int 21h

    lea si, arr
    mov cx, 5

original:
    mov dl, [si]
    add dl, '0'

    mov ah, 02h
    int 21h

    mov dl, ' '
    int 21h

    inc si
    loop original

    ; Reverse using stack
    lea dx, msg2
    mov ah, 09h
    int 21h

    mov cx, 5

reverse:
    pop ax
    mov dl, al
    add dl, '0'

    mov ah, 02h
    int 21h

    mov dl, ' '
    int 21h

    loop reverse

    ; Sum
    lea dx, msg3
    mov ah, 09h
    int 21h

    xor ax, ax
    mov al, bl
    call print_num

    ; Average
    lea dx, msg4
    mov ah, 09h
    int 21h

    xor ax, ax
    mov al, bl

    mov dl, 5
    div dl              ; AL = sum / 5

    xor ah, ah
    call print_num

    mov ah, 4ch
    int 21h
main endp


print_num proc
    xor cx, cx
    mov bx, 10

again:
    xor dx, dx
    div bx
    push dx
    inc cx

    cmp ax, 0
    jne again

show:
    pop dx
    add dl, '0'

    mov ah, 02h
    int 21h

    loop show
    ret
print_num endp

end main