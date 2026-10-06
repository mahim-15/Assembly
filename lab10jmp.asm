.model small
.stack 100h
.code
main proc
mov dl,20h
display:
mov ah,02h
int 21h 
inc dl
cmp dl,00h
je exit
jmp display
exit:
mov ah,4ch
int 21h
main endp
end main