.model small
.stack 100h
.data
str db 'HELLO'
rev db 5 DUP(?)
.code
main proc
    mov ax, @data
    mov ds,ax
    mov es,ax
    lea si,str

    add si,4   
    
    lea di,rev
    mov cx,5
    reverse:
    std
    lodsb
    cld
    stosb
    loop reverse   
    lea si, rev
    mov cx,5
    print:
    lodsb
    mov dl,al
    mov ah,02h
    int 21h
    loop print
    
    mov ah,4ch
    int 21h
    main endp
end main
