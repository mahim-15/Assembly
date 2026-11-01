.model small
.stack 100h

.code
main proc

    mov ax, 5       ; AX = 5

    shl ax, 1       ; Shift left by 1
                    ; AX = AX × 2

    mov ah, 4ch
    int 21h

main endp
end main