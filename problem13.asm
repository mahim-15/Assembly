.model small
.stack 100h
.code
main proc
    mov ah, 01h
    int 21h

    cmp al, 'y'
    je display

    cmp al, 'Y'
    je display

    jmp exit

display:
    mov dl, al
    mov ah, 02h
    int 21h

exit:
    mov ah, 4ch
    int 21h
main endp
end main