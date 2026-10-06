mov al,25h
mov bl,30h
cmp al,bl
jb less
mov cl,00h
jmp done
less:
mov cl,01h
done: