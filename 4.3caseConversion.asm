.model small
.stack 100H
.DATA
         cr EQU 0DH
         lf EQU 0AH
msg1 db 'Enter a lower case letter: $'
msg2 db  0DH, 0AH,'IN UPPER CASE IT IS:  '
char db  ?,'$'
.code
main proc
;initialize DS 
    mov ax, @data
    mov ds, ax
;print user prompt
    lea dx,msg1
    mov ah, 9
    int 21h
;intput a charactter and convert to upper case
    mov ah,1
    int 21h
    sub al,20H
    mov char,AL
;display on the next line
lea dx,msg2
mov ah,9
int 21h
;dos exit
  mov ah,4ch
  int 21h
main endp
end main