; PROGRAMA QUE IMPRIME LA HORA DEL SISTEMA
                    ; MACRO QUE COLOCA EL CURSOR
POSXY MACRO X, Y
    MOV DH, X ;REN
    MOV DL, Y ;COL
    MOV AH, 02H
    INT 10H
POSXY ENDM


INICIO:
                    ;COLOCAR EL CURSOR
    POSXY 12,30     ; LLAMADO AL PROCEDIMIENTO CURSORXY
    
    MOV AH, 09H         ; SERV PARA IMPRI CADENA
    MOV DX, OFFSET MSG  ; DIRECCION DE LA CADENA A IMPRIMIR
    INT 21H
 
    MOV AH,2CH      ;SERVICO PARA OBTENER LA HORA DEL SISTEMA
    INT 21H
                    ; CH - HORA
                    ; CL - MIN
    MOV HOR, CH
    MOV MIN, CL   
;----------------------------------------------------------
    CMP HOR,12
    JLE NCH
    JGE DIA

NCH:
    POSXY 15,40     ; LLAMADO AL PROCEDIMIENTO CURSORXY
    
    MOV AH, 09H     ; SERV PARA IMPRI CADENA
    MOV DX, OFFSET AM     ; DIRECCION DE LA CADENA A IMPRIMIR
    INT 21H
    POSXY 17,40     ; LLAMADO AL PROCEDIMIENTO CURSORXY
    
    MOV AH, 09H     ; SERV PARA IMPRI CADENA
    MOV DX, OFFSET AM     ; DIRECCION DE LA CADENA A IMPRIMIR
    INT 21H
    JMP NEXTHR
DIA:
    POSXY 15,40     ; LLAMADO AL PROCEDIMIENTO CURSORXY
    
    MOV AH, 09H     ; SERV PARA IMPRI CADENA
    MOV DX, OFFSET PM     ; DIRECCION DE LA CADENA A IMPRIMIR
    INT 21H
    POSXY 17,40     ; LLAMADO AL PROCEDIMIENTO CURSORXY
    
    MOV AH, 09H           ; SERV PARA IMPRI CADENA
    MOV DX, OFFSET PM     ; DIRECCION DE LA CADENA A IMPRIMIR
    INT 21H
    
;-------------------------------------------------------------     
NEXTHR:
    POSXY 15, 32    ;LLAMADO AL PROCEDIMIENTO CURSOXY
    CMP HOR,12
    JG  RESTA12
    JMP CONT
RESTA12:
    SUB HOR,12
CONT:
     
    MOV DH,HOR
    PUSH DX         ; GUARDO TEMPORALMENTE HORA-MIN
                    ; IMPRIMO LA HORA
    SHR DH, 04H     ; OBTENGO EL NIBLE MAS ALTO
                    ;LLAMDO A CONVERSI�N A ASCII
    CALL CONVHEX_ASC
    
    POP DX
    AND DH, 0FH     ; OBTENGO EL NIBLE BAJO
                    ;LLAMDO A CONVERSION A ASCII
    CALL CONVHEX_ASC

    
    POSXY 15,35
                    ; IMPRIMIR 2 PUNTOS
    MOV AH, 02H
    MOV DL, ':'
    INT 21H
    
    POSXY 15,37
                    ; IMPRIMO LA MIN
    MOV DH, MIN      ; MUEVO LOS MIN EN CH
    PUSH DX         ; GUARDO TEMPORALMENTE HORA-MIN
    SHR DH, 04      ; OBTENGO EL NIBLE MAS ALTO
                    ;CONVERSION A ASCII
                    ;LLAMDO A CONVERSION A ASCII
    CALL CONVHEX_ASC
    
   
    POP DX
    AND DH, 0FH     ; OBTENGO EL NIBLE BAJO
                    ;CONVERSION A ASCII
                    ;LLAMDO A CONVERSION A ASCII
    CALL CONVHEX_ASC
    
    
    POSXY 15,43     ; LLAMADO AL PROCEDIMIENTO CURSORXY
    
    MOV AH, 09H     ; SERV PARA IMPRI CADENA
    MOV DX, OFFSET HEX     ; DIRECCION DE LA CADENA A IMPRIMIR
    INT 21H
;--------------------------------------------------------------------
    POSXY 17,32
    
    MOV AL,HOR
    CALL CONVDEC_ASC
    
    POSXY 17,35
                    ; IMPRIMIR 2 PUNTOS
    MOV AH, 02H
    MOV DL, ':'
    INT 21H
    POSXY 17,37
    
    MOV AL,MIN
    CALL CONVDEC_ASC
   
    POSXY 17,43     ; LLAMADO AL PROCEDIMIENTO CURSORXY
    
    MOV AH, 09H     ; SERV PARA IMPRI CADENA
    MOV DX, OFFSET DECI     ; DIRECCION DE LA CADENA A IMPRIMIR
    INT 21H
FIN:    
    INT 20H         ; FIN DEL PROGRAMA

CONVHEX_ASC PROC
                    ;CONVERSION A ASCII
    CMP DH, 09H
    JG SUMAR37
    ADD DH, 30H
    JMP IMPREDIG
SUMAR37:
    ADD DH, 37H
IMPREDIG:
    MOV AH, 02H     ; SERV PARA IMPRI 1 CARACTER
    MOV DL, DH      ; DIGITO A IMPRIMIR
    INT 21H
    RET             ; REGRESO DEL PROCEDIMIENTO
CONVHEX_ASC ENDP

CONVDEC_ASC PROC
    AAM             ;AMM AJUSTE ASCII PARA MULTIPLICAR
                    ;BH = NUMERO EN DECENA
                    ;BL = NUMERO EN UNIDAD 
    MOV BX,AX       ;MOVEMOS EL VALOR A BX
    MOV AH,02H      ;IMPRIMIR DECENA
    MOV DL,BH
    ADD DL,30H
    INT 21H
    
    MOV AH,02H       ;IMPRIMIR UNIDAD
    MOV DL,BL
    ADD DL,30H
    INT 21H
                    ;IMPRIMAMOS REGISTROS UTILIZADOS
    MOV AH,00H
    MOV BX,00H
    MOV BL,00H
    MOV DL,00H
    RET             ; REGRESO DEL PROCEDIMIENTO
CONVDEC_ASC ENDP

    HOR  DB 00H
    MIN  DB 00H
    MSG  DB "| HORA DEL SISTEMA |$"
    HEX  DB "HEX$"
    DECI DB "DEC$"
    AM   DB "AM $"
    PM   DB "PM $"