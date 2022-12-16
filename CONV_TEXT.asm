;---------------MACRO---------------------
    POSXY MACRO X, Y ;MACRO PARA POSICION DEL CURSOR
        MOV DH, X    ;RENGLON
        MOV DL, Y    ;COLUMNA
        MOV AH, 02H
        INT 10H
    POSXY ENDM
;-----------------------------------------

.MODEL SMALL
.STACK
.DATA

;-------------------------------------STRING'S
    MSG  DB "INGRESE UNA CADENA: ", '$'
    MSG2 DB "CAD. EN MAY: ", '$'
    MSG3 DB "CAD. EN MIN: ", '$'
;-------------------------------------VARIABLES
    CAD DB 30,00,30 DUP ('$')  ;ARREGLO
;ARREGLO (MAX.DE CAR),(CAR. LEIDOS),(TAM. DE ESPACIO DE CAR.) DUP ('$')

    COL DB 15  ;VARIABLE POSICION DE COLUMNA INICIAL DE LA CADENA DE CONVERSION
    AUX DB 00  ;VARIABLE AXULIAR PARA GUARDAR CARACTER 
    NO EQU 00  ;VARIABLE PARA GUARDA CUANTOS CARACTERES UTILIADOS

.CODE
    MAIN PROC           ;INICIO DEL PROGRAMA
    MOV AX, @data       ;LLAMAMOS LAS VARIABLES DE DATA
    MOV DS, AX          ;SE GUARDA LA INF. DE DATA EN SEGMENTO DATOS
    
    MOV AH, 00H         ;SERVICIO DE TAM. DE PANTALLA
    MOV AL, 02H         ;TAM.80x25
    INT 10H
    
    POSXY 03, 02        ;MACRO DE POSICION DE CURSOR PARA EL MENSAJE
    
    MOV AH, 09H         ;IMPRIMIR MENSAJE
    LEA DX, MSG
    INT 21H
    
    MOV AH, 0AH         ;LEEMOS LA CADENA
    LEA DX, CAD
    INT 21H
                        ;OBTENEMOS LA CANTIDAD DE CARACTERES UTILIZADOS
    MOV AL, CAD+1       ;CAD+1 SE POSICIONA AL VALOR DEL SEGUNDO VALOR DEL ARREGLO (TAM. DE ESPACIO DE CAR.)
    MOV NO, AL
    
    POSXY 05, 02        ;MACRO DE POSICION DE CURSOR PARA EL MENSAJE
    
    MOV AH, 09H         ;IMPRIMIR MENSAJE
    MOV DX, OFFSET MSG2
    INT 21H    
    
    POSXY 07, 02        ;MACRO DE POSICION DE CURSOR PARA EL MENSAJE
    
    MOV AH, 09H         ;IMPRIMIR MENSAJE
    MOV DX, OFFSET MSG3
    INT 21H
    
    MOV SI, 02H         ;CONTADOR DEL ARREGLO
                        ;FUNCION PARA REVISAR CADA POSICION DE LA CADENA
    REV_ENTER:          ;REVISAMOS LA CADENA HASTA ENCONTRAR EL ENTER EN LA CADENA
        MOV AL, CAD[SI]     ;ARREGLO[POSICION DEL ARREGLO] = VALOR MOV A AL
        
        CMP AL,13           ;COMPARAMOS QUE LLEGUE AL ENTER
        JE FIN              ;SI ES IGUAL TERMINA EL PROGRAMA
        
        REV_CARACTER:       ;FUNCION PARA REVISAR EL CARACTER
            
            CMP AL, 65      ;COMPARAMOS SI ES MAYOR DE A
            JGE MAYUSCULA   ;SI ES MAYOR ES MAYUSCULA
            JB NOLETRA      ;SI ES MENOR SIMBOLO O NUMERO
            
            CMP AL, 97      ;COMPARAMOS SI ES MAYOR DE a
            JGE MINUSCULA   ;SI ES MAYOR ES MINUSCULA
            
                        
            MAYUSCULA:          ;FUNCION DE LETRAS MAYUSCULAS
                CMP AL,90           ;COMPARAMOS SI ES MAYOR DE Z      
                JG MINUSCULA        ;SI MAYOR DE 90 ES MINUSCULA
                 
           
                POSXY 05, COL       ;MACRO DE POSICION DE CURSOR PARA EL MENSAJE
            
                MOV AH, 09H         ;INDICAMOS QUE IMPRIMIR UN CARACTER
                MOV AL, CAD[SI]     ; AL = CARACTER
                MOV BH, 0           ; BH = COLOR DE FONDO
                MOV BL, 0EH         ; BL = COLOR DE LA LETRA
                MOV CX, 1           ; CX = VECES QUE SE REPITE
                INT 10H      
                                    ;CONVERTIR DE MAYUSCULA A MINUSCULA
                MOV AL, CAD[SI]     ;PONEMOS EL CARACTER EN AL
                ADD AL, 32          ;SUMAMOS 32 PARA RECORRE A LA LETRA EN MINUSCULA
                MOV AUX,AL          ;EL VALOR DE LA SUMA EN LA VIARIABLE AUX
                MOV AL,0            ;LIMPIAMOS EL REGISTRO AL
                
                POSXY 07, COL       ;MACRO DE POSICION DE CURSOR PARA EL MENSAJE
                
                MOV AH, 09H         ;INDICAMOS QUE IMPRIMIR UN CARACTER
                MOV AL, AUX         ; AL = CARACTER
                MOV BH, 0           ; BH = COLOR DE FONDO
                MOV BL, 0EH         ; BL = COLOR DE LA LETRA
                MOV CX, 1           ; CX = VECES QUE SE REPITE
                INT 10H
                
                INC COL             ;INCREMENTAMOS LA POSICION EN COLUMNA
                 
                JMP SIGUIENTE       ;SALTAMOS A LA FUNCION SIGUIENTE
            
            MINUSCULA:          ;FUNCION DE LETRAS MINUSCULAS
                
                CMP AL,122          ;COMPARAMOS SI ES MAYOR DE z      
                JG NOLETRA          ;SI ES MAYOR DE 122, NO ES LETRA MINUSCULA
                            
                POSXY 07, COL       ;MACRO DE POSICION DE CURSOR PARA EL MENSAJE
            
                MOV AH, 09H         ;INDICAMOS QUE IMPRIMIR UN CARACTER
                MOV AL, CAD[SI]     ; AL = CARACTER
                MOV BH, 0           ; BH = COLOR DE FONDO
                MOV BL, 0EH         ; BL = COLOR DE LA LETRA
                MOV CX, 1           ; CX = VECES QUE SE REPITE
                INT 10H             
                                    ;CONVERTIR DE MINUSCULA A MAYUSCULA
                MOV AL, CAD[SI]     ;PONEMOS EL CARACTER EN AL
                SUB AL, 32          ;RESTA 32 PARA RECORRE A LA LETRA EN MAYUSCULA
                MOV AUX,AL          ;EL VALOR DE LA RESTA EN LA VIARIABLE AUX
                MOV AL,0            ;LIMPIAMOS EL REGISTRO AL
                
                
                POSXY 05, COL       ;MACRO DE POSICION DE CURSOR PARA EL MENSAJE
                
                MOV AH, 09H         ;INDICAMOS QUE IMPRIMIR UN CARACTER
                MOV AL, AUX         ; AL = CARACTER
                MOV BH, 0           ; BH = COLOR DE FONDO
                MOV BL, 0EH         ; BL = COLOR DE LA LETRA
                MOV CX, 1           ; CX = VECES QUE SE REPITE
                INT 10H
                
                INC COL             ;INCREMENTAMOS LA POSICION EN COLUMNA
                
                JMP SIGUIENTE       ;SALTAMOS A LA FUNCION SIGUIENTE
            
            NOLETRA:            ;FUNCION DE NO LETRAS
            
                POSXY 05, COL       ;MACRO DE POSICION DE CURSOR PARA EL MENSAJE
            
                MOV AH, 09H         ;INDICAMOS QUE IMPRIMIR UN CARACTER
                MOV AL, CAD[SI]     ; AL = CARACTER
                MOV BH, 0           ; BH = COLOR DE FONDO
                MOV BL, 0EH         ; BL = COLOR DE LA LETRA
                MOV CX, 1           ; CX = VECES QUE SE REPITE
                INT 10H
                
                POSXY 07, COL       ;MACRO DE POSICION DE CURSOR PARA EL MENSAJE
            
                MOV AH, 09H         ;INDICAMOS QUE IMPRIMIR UN CARACTER
                MOV AL, CAD[SI]     ; AL = CARCATER
                MOV BH, 0           ; BH = COLOR DE FONDO
                MOV BL, 0EH         ; BL = COLOR DE LA LETRA
                MOV CX, 1           ; CX = VECES QUE SE REPITE
                INT 10H
                   
                INC COL             ;INCREMENTAMOS LA POSICION EN COLUMNA
            
            SIGUIENTE:          ;FUNCION PARA VOLVER AL INICIO
                INC SI              ;INCREMENTA SI PARA RECORRER EL ARREGLO 
                JMP REV_ENTER       ;SALTA AL INICIO DE REVISION DEL ENTER
           
    FIN:        ;FUNCION PARA TERMINAR EL PROGRAMA
    MOV AH, 4CH ;SERVICIO DE TERMINA EL PROGRAMA
    INT 21H
    
.EXIT
    MAIN ENDP
END