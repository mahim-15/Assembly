.model small
.stack 100h
.code
main proc
    mov ah, 01h
    int 21h          ; input lowercase letter

    and al, 11011111b

    mov dl, al
    mov ah, 02h
    int 21h

    mov ah, 4ch
    int 21h
main endp
end main