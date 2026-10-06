.model small
.stack 100h
.code
main proc

    mov al, 11010010b

    xor bl, bl
    mov cx, 8

reverse:
    shr al, 1
    rcl bl, 1
    loop reverse

    mov al, bl

    mov ah, 4ch
    int 21h

main endp
end main