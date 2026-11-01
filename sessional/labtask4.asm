MOV CX,0005H
MOV AX,0000H

L1:
    ADD AX,CX
    LOOP L1

; Stop here and check AX