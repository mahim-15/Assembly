.model small
.stack 100h
.data
array db 12H,45H,23H,67H,34H
max db ?
.code
main proc

    mov ax, @data
    mov ds, ax
    lea si,array
    mov al, [si]
    inc si 
    mov cx,4
    NEXT:
    cmp al,[si]
    jae skip
    mov al, [si]
    skip:
    inc si
    loop NEXT 
    mov max,al
    mov ah,4ch
    int 21h
main endp
end main




