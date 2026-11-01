.model small
.stack 100h

.code
main proc

    mov bx, 40      ; BX = 40

    shr bx, 3       ; Divide BX by 8
                    ; because 8 = 2^3

    mov ah, 4ch
    int 21h

main endp
end main