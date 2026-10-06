
.model small
.stack 100h

.code
main proc

    ; Input first number
    mov ah, 1
    int 21h
    sub al, '0'
    mov bl, al

    ; Input second number
    mov ah, 1
    int 21h
    sub al, '0'

    ; Add the two numbers
    add al, bl

    ; Convert result to ASCII
    add al, '0'

    ; Display result
    mov dl, al
    mov ah, 2
    int 21h

    ; Exit
    mov ah, 4ch
    int 21h

main endp
end main
