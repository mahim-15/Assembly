.model small
.stack 100h

.code
main proc

    mov ax, -25       ; AX = -25

    cmp ax, 0         ; Compare AX with 0
    jge done          ; If AX >= 0, no change needed

    neg ax            ; If AX < 0, AX = -AX

done:
    mov ah, 4ch
    int 21h

main endp
end main