.model small
.stack 100h

.data
str1 db 'Hello ', 0
str2 db 'World', 0
result db 50 dup(0)

.code
main proc
    mov ax, @data
    mov ds, ax

    lea si, str1
    lea di, result

; Copy first string
copy1:
    mov al, [si]
    cmp al, 0
    je start_str2

    mov [di], al
    inc si
    inc di
    jmp copy1

; Copy second string
start_str2:
    lea si, str2

copy2:
    mov al, [si]
    cmp al, 0
    je finish

    mov [di], al
    inc si
    inc di
    jmp copy2

finish:
    mov byte ptr [di], 0

; Display combined string
    lea si, result

display:
    mov dl, [si]
    cmp dl, 0
    je exit

    mov ah, 02h
    int 21h

    inc si
    jmp display

exit:
    mov ah, 4ch
    int 21h

main endp
end main