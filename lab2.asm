.model small
.stack 100h

.data
    msg1 db 'Enter first number: $'
    msg2 db 13,10,'Enter second number: $'
    msg3 db 13,10,'First number: $'
    msg4 db 13,10,'Second number: $'

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Input first number
    lea dx, msg1
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    mov bl, al

    ; Input second number
    lea dx, msg2
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    mov bh, al

    ; Print first number
    lea dx, msg3
    mov ah, 09h
    int 21h

    mov dl, bl
    mov ah, 02h
    int 21h

    ; Print second number
    lea dx, msg4
    mov ah, 09h
    int 21h

    mov dl, bh
    mov ah, 02h
    int 21h

    ; Exit
    mov ah, 4Ch
    int 21h

main endp
end main