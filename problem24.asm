.model small
.stack 100h
.code
main proc

    mov ax, 48
    mov bx, 18

gcd_loop:
    xor dx, dx

    div bx          ; AX / BX
                    ; remainder -> DX

    mov ax, bx
    mov bx, dx

    cmp bx, 0
    jne gcd_loop

    ; AX contains GCD = 6

    mov ah, 4ch
    int 21h

main endp
end main