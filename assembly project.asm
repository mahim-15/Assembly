; ============================================================
; Hybrid Sort: Insertion Sort (blocks of 4) + Iterative Merge Sort
; 8086, .model small  (emu8086 / MASM / TASM)
; ============================================================
.model small
.stack 100h

.data
    arr   db 100 dup(0)
    temp  db 100 dup(0)

    n       dw ?
    run_w   dw 4            ; run width (was "width", a reserved word)

    left_idx   dw ?
    mid_idx    dw ?
    right_idx  dw ?

    i_idx  dw ?
    j_idx  dw ?
    k_idx  dw ?

    block_start dw ?
    block_end   dw ?

    key   db ?
    digit db ?

    msg1 db 13,10,'Enter array size (1-100): $'
    msg2 db 13,10,'Enter array elements (0-255), separated by space or Enter: $'
    msg3 db 13,10,'Original array: $'
    msg4 db 13,10,'Sorted array: $'
    msg5 db 13,10,'Value must be 0-255, re-enter: $'

.code

main proc
    mov ax, @data
    mov ds, ax

    ; ---------- INPUT ARRAY SIZE (re-ask if invalid) ----------
get_size:
    lea dx, msg1
    mov ah, 09h
    int 21h

    call read_number
    cmp ax, 1
    jb  get_size
    cmp ax, 100
    ja  get_size
    mov n, ax

    ; ---------- INPUT ARRAY ELEMENTS ----------
    lea dx, msg2
    mov ah, 09h
    int 21h

    mov si, 0
input_loop:
    cmp si, n
    jae input_done

    call read_number
    cmp ax, 255
    ja  bad_value
    mov arr[si], al
    inc si
    jmp input_loop

bad_value:
    lea dx, msg5
    mov ah, 09h
    int 21h
    jmp input_loop

input_done:
    ; ---------- DISPLAY ORIGINAL ----------
    lea dx, msg3
    mov ah, 09h
    int 21h
    call display_array

    ; ==========================================================
    ; STEP 1: INSERTION SORT ON BLOCKS OF 4
    ; ==========================================================
    mov block_start, 0

block_loop:
    mov ax, block_start
    cmp ax, n
    jb  block_go
    jmp insertion_done          ; far jump (was out of range)
block_go:
    add ax, 4
    cmp ax, n
    jbe save_block_end
    mov ax, n
save_block_end:
    mov block_end, ax           ; block_end = min(block_start+4, n)

    mov ax, block_start
    inc ax
    mov i_idx, ax               ; i = block_start + 1

insertion_outer:
    mov ax, i_idx
    cmp ax, block_end
    jae next_block

    mov si, i_idx
    mov al, arr[si]
    mov key, al                 ; key = arr[i]

    mov di, i_idx
    dec di                      ; j = i - 1

insertion_inner:
    cmp di, block_start         ; signed compare, j may be -1
    jl  insert_element

    mov al, arr[di]
    cmp al, key
    jbe insert_element

    mov arr[di+1], al           ; shift right
    dec di
    jmp insertion_inner

insert_element:
    mov al, key
    mov arr[di+1], al
    inc i_idx
    jmp insertion_outer

next_block:
    add block_start, 4
    jmp block_loop

insertion_done:

    ; ==========================================================
    ; STEP 2: ITERATIVE MERGE SORT
    ; ==========================================================
merge_pass:
    mov ax, run_w
    cmp ax, n
    jb  merge_go
    jmp sorting_done            ; far jump (was out of range)
merge_go:
    mov left_idx, 0

merge_segment:
    mov ax, left_idx
    cmp ax, n
    jb  seg_go
    jmp next_width              ; far jump (was out of range)
seg_go:
    ; mid = min(left + run_w, n)
    add ax, run_w
    cmp ax, n
    jbe save_mid
    mov ax, n
save_mid:
    mov mid_idx, ax

    ; right = min(left + 2*run_w, n)
    mov ax, run_w
    add ax, run_w
    add ax, left_idx
    cmp ax, n
    jbe save_right
    mov ax, n
save_right:
    mov right_idx, ax

    mov ax, left_idx
    mov i_idx, ax
    mov k_idx, ax
    mov ax, mid_idx
    mov j_idx, ax

merge_compare:
    mov ax, i_idx
    cmp ax, mid_idx
    jae copy_right

    mov ax, j_idx
    cmp ax, right_idx
    jae copy_left

    mov si, i_idx
    mov di, j_idx
    mov al, arr[si]
    mov dl, arr[di]
    cmp al, dl
    jbe take_left

    mov bx, k_idx               ; take right
    mov temp[bx], dl
    inc j_idx
    inc k_idx
    jmp merge_compare

take_left:
    mov bx, k_idx
    mov temp[bx], al
    inc i_idx
    inc k_idx
    jmp merge_compare

copy_left:
    mov ax, i_idx
    cmp ax, mid_idx
    jae copy_done
    mov si, i_idx
    mov al, arr[si]
    mov bx, k_idx
    mov temp[bx], al
    inc i_idx
    inc k_idx
    jmp copy_left

copy_right:
    mov ax, j_idx
    cmp ax, right_idx
    jae copy_done
    mov si, j_idx
    mov al, arr[si]
    mov bx, k_idx
    mov temp[bx], al
    inc j_idx
    inc k_idx
    jmp copy_right

copy_done:
    mov ax, left_idx            ; copy temp back to arr
    mov i_idx, ax
copy_back:
    mov ax, i_idx
    cmp ax, right_idx
    jae segment_done
    mov si, i_idx
    mov al, temp[si]
    mov arr[si], al
    inc i_idx
    jmp copy_back

segment_done:
    mov ax, run_w
    add ax, run_w
    add left_idx, ax
    jmp merge_segment

next_width:
    mov ax, run_w
    add ax, run_w
    mov run_w, ax
    jmp merge_pass

sorting_done:
    lea dx, msg4
    mov ah, 09h
    int 21h
    call display_array

    mov ah, 4Ch
    int 21h
main endp


; ============================================================
; READ DECIMAL NUMBER -> AX
; Ends on Enter or Space. Ignores non-digit characters.
; ============================================================
read_number proc
    push bx
    push cx
    push dx
    push di

    xor bx, bx                  ; value
    xor di, di                  ; di = 1 once a digit was typed

read_digit:
    mov ah, 01h
    int 21h

    cmp al, 13
    je  got_enter
    cmp al, ' '
    jne check_digit
    cmp di, 0                   ; space ends number only after a digit
    je  read_digit
    jmp input_finished

check_digit:
    cmp al, '0'
    jb  read_digit
    cmp al, '9'
    ja  read_digit

    sub al, '0'
    mov digit, al
    mov ax, bx
    mov cx, 10
    mul cx
    xor dx, dx
    mov dl, digit
    add ax, dx
    mov bx, ax
    mov di, 1
    jmp read_digit

got_enter:
    mov dl, 10                  ; Enter echoes only CR, so add LF
    mov ah, 02h
    int 21h

input_finished:
    mov ax, bx
    pop di
    pop dx
    pop cx
    pop bx
    ret
read_number endp


; ============================================================
; DISPLAY ARRAY
; ============================================================
display_array proc
    push ax
    push dx
    push si

    mov si, 0
display_loop:
    cmp si, n
    jae display_done

    mov al, arr[si]
    call print_number

    mov dl, ' '
    mov ah, 02h
    int 21h

    inc si
    jmp display_loop

display_done:
    pop si
    pop dx
    pop ax
    ret
display_array endp


; ============================================================
; PRINT UNSIGNED BYTE (AL, 0-255), any number of digits
; ============================================================
print_number proc
    push ax
    push bx
    push cx
    push dx

    xor ah, ah                  ; ax = value
    mov bx, 10
    xor cx, cx
pn_div:
    xor dx, dx
    div bx
    push dx                     ; remainder = next digit
    inc cx
    cmp ax, 0
    jne pn_div

pn_out:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop pn_out

    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_number endp

end main