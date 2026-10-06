.model small
.stack 100h
.code
main proc
    mov ah, 01h
    int 21h          ; input character -> AL

    cmp al, 'A'
    jb exit          ; AL < 'A'

    cmp al, 'Z'
    ja exit          ; AL > 'Z'

    mov dl, al
    mov ah, 02h
    int 21h          ; display character

exit:
    mov ah, 4ch
    int 21h
main endp
end main