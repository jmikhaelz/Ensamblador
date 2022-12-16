MOV AL, 13H
MOV AH, 00
INT 10H

MOV AL, 0FH
MOV BH, 00
MOV AH, 0CH ;pixel AL = Color, BH = Página, CX = X, DX = Y
INT 10H

INT 20H