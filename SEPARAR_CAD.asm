.MODEL SMALL
.STACK
.DATA

;-------------------------------------STRING'S
    MSG  DB "INGRESE UNA CADENA: ", '$'
    MSG1 DB "NO LETRAS: ", '$'
    MSG2 DB "MAYUSCULAS: ", '$'
    MSG3 DB "MINUSCULAS: ", '$'
;-------------------------------------VARIABLES
    CAD DB 30,00,30 DUP ('$')
;ARREGLO (MAX.DE CAR),(CAR. LEIDOS),(TAM. DE ESPACIO DE CAR.) DUP ('$')
    NO  EQU 0
    COLN DB 14
    COLMAY DB 14
    COLMIN DB 14
.CODE

    POSXY MACRO X, Y
        MOV DH, X ;REN
        MOV DL, Y ;COL
        MOV AH, 02H
        INT 10H
    POSXY ENDM

    MAIN PROC
    MOV AX, @data
    MOV DS, AX
    
    MOV AH, 00H         ;SERVICIO DE TAM. DE PANTALLA
    MOV AL, 02H
    INT 10H
    
    POSXY 03, 02
    
    MOV AH, 09H         ;IMPRIMIR STRING
    LEA DX, MSG
    INT 21H
    
    MOV AH, 0AH
    LEA DX, CAD
    INT 21H
    
    MOV AL, CAD+1       ;CAD+1 SE POSICIONA AL VALOR DEL SEGUNDO VALOR DEL ARREGLO (TAM. DE ESPACIO DE CAR.)
    MOV AH, 00
    MOV NO, AX
    
    MOV SI, 02H         ;CONTADOR DEL ARREGLO
    
    REV_ENTER:
        MOV AL, CAD[SI]     ;ARREGLO[POSICION DEL ARREGLO] = VALOR MOV A AL
        
        CMP AL,13           ;COMPARAMOS QUE LLEGUE AL ENTER
        JE FIN
        
        REV_CARACTER:
            
            CMP AL, 65      ;COMPARAMOS SI ES MAYOR DE A
            JGE MAYUSCULA   ; SI ES MAYOR ES MAYUSCULA
            JB NOLETRA      ; SI ES MENOR SIMBOLO O NUMERO
            
            CMP AL, 97      ;COMPARAMOS SI ES MAYOR DE a
            JGE MINUSCULA   ;SI ES MAYOR ES MINUSCULA
            
                        
            MAYUSCULA:
                CMP AL,90      ;COMPARAMOS SI ES MAYOR DE Z      
                JG MINUSCULA
                 
                POSXY 07, 02
                MOV AH, 09H         ;IMPRIMIR STRING
                MOV DX, OFFSET MSG2
                INT 21H
            
                POSXY 07, COLMAY
            
                MOV AH, 09H         ;INDICAMOS QUE IMPRIMIR UN CARACTER
                MOV AL, CAD[SI]
                MOV BH, 0           ; BH = COLOR DE FONDO
                MOV BL, 0EH          ; BL = COLOR DE LA LETRA
                MOV CX, 1           ; CX = VECES QUE SE REPITE
                INT 10H   
                INC COLMAY   
                 
                JMP SIGUIENTE
            
            MINUSCULA:
                
                CMP AL,122      ;COMPARAMOS SI ES MAYOR DE z      
                JG NOLETRA
                
                POSXY 09, 02
                MOV AH, 09H         ;IMPRIMIR STRING
                MOV DX, OFFSET MSG3
                INT 21H
            
                POSXY 09, COLMIN
            
                MOV AH, 09H         ;INDICAMOS QUE IMPRIMIR UN CARACTER
                MOV AL, CAD[SI]
                MOV BH, 0           ; BH = COLOR DE FONDO
                MOV BL, 0EH          ; BL = COLOR DE LA LETRA
                MOV CX, 1           ; CX = VECES QUE SE REPITE
                INT 10H   
                INC COLMIN  
                
                JMP SIGUIENTE
            
            NOLETRA:
            
                POSXY 05, 02
                MOV AH, 09H         ;IMPRIMIR STRING
                MOV DX, OFFSET MSG1
                INT 21H
            
                POSXY 05, COLN
            
                MOV AH, 09H         ;INDICAMOS QUE IMPRIMIR UN CARACTER
                MOV AL, CAD[SI]
                MOV BH, 0           ; BH = COLOR DE FONDO
                MOV BL, 0EH          ; BL = COLOR DE LA LETRA
                MOV CX, 1           ; CX = VECES QUE SE REPITE
                INT 10H   
                INC COLN    
            
            SIGUIENTE:
                INC SI
                JMP REV_ENTER
        
    FIN:
    MOV AH, 4CH
    INT 21H
    
.EXIT
    MAIN ENDP