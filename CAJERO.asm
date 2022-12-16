
    MOV AH, 00H         ;SERVICIO DE TAMAÑO DE PANTALLA
    MOV AL, 02H
    INT 10H
     
;DIBUJAR EL CUADRADO
                        ;LINEA SUPERIOR
    
                            ;ESQUINA SUP. IZQ
    MOV AH, 02H         ;SERVICIO DE POSICION DEL CARACTER
    MOV BH, 0           ;BH = PAGINA
    MOV DH, 01          ;DH = FILA
    MOV DL, 05          ;DL = COLUMNA
    INT 10H

    MOV AH, 09H         ;INDICAMOS QUE IMPRIMIR UN CARACTER
    MOV AL, 218         ; AL = 'CARACTER'
    MOV BH, 0           ; BH = COLOR DE FONDO
    MOV BL, CI          ; BL = COLOR DE LA LETRA
    MOV CX, 1           ; CX = VECES QUE SE REPITE
    INT 10H
    
    MOV AH, 02H         ;SERVICIO DE POSICION DEL CARACTER
    MOV BH, 0           ;BH = PAGINA
    MOV DH, 01          ;DH = FILA
    MOV DL, 06          ;DL = COLUMNA
    INT 10H

                        ; LINEA
    MOV AH, 09H         ;INDICAMOS QUE IMPRIMIR UN CARACTER
    MOV AL, 196         ; AL = 'CARACTER'
    MOV BH, 0           ; BH = COLOR DE FONDO
    MOV BL, CI          ; BL = COLOR DE LA LETRA
    MOV CX, 68          ; CX = VECES QUE SE REPITE
    INT 10H             
    
                            ;ESQUINA SUP. DER
    MOV AH, 02H         ;SERVICIO DE POSICION DEL CARACTER
    MOV BH, 0           ;BH = PAGINA
    MOV DH, 01          ;DH = FILA
    MOV DL, 74          ;DL = COLUMNA
    INT 10H

    MOV AH, 09H         ;INDICAMOS QUE IMPRIMIR UN CARACTER
    MOV AL, 191         ; AL = 'CARACTER'
    MOV BH, 0           ; BH = COLOR DE FONDO
    MOV BL, CI          ; BL = COLOR DE LA LETRA
    MOV CX, 1           ; CX = VECES QUE SE REPITE
    INT 10H
    
    
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 02
    MOV DL, 06
    INT 10H
    
    MOV AH, 09H         ; ADORNO
    MOV AL, 04
    MOV BH, 0
    MOV BL, CI
    MOV CX, 68
    INT 10H   
                        ;LINEA INFERIOR
    
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 22
    MOV DL, 06
    INT 10H
    
    MOV AH, 09H
    MOV AL, 04
    MOV BH, 0
    MOV BL, CI
    MOV CX, 68
    INT 10H
    
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 23
    MOV DL, 05
    INT 10H
    
    MOV AH, 09H
    MOV AL, 196
    MOV BH, 0
    MOV BL, CI
    MOV CX, 70
    INT 10H
                        ;ESQUINA INF. DER
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 23
    MOV DL, 05
    INT 10H
    
    MOV AH, 09H
    MOV AL, 192
    MOV BH, 0
    MOV BL, CI
    MOV CX, 01
    INT 10H
                        ;ESQUINA INF. IZQ
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 23
    MOV DL, 74
    INT 10H
    
    MOV AH, 09H
    MOV AL, 217
    MOV BH, 0
    MOV BL, CI
    MOV CX, 01
    INT 10H
     
                        ;LINEA LATERAL IZQUIERDA
IZQ:
    INC LIZQ
    MOV AH, 02H
    MOV BH, 0
    MOV DH, LIZQ
    MOV DL, 05
    INT 10H
    
    MOV AH, 09H
    MOV AL, 179
    MOV BH, 0
    MOV BL, CI
    MOV CX, 1
    INT 10H
    
    MOV AH, 02H
    MOV BH, 0
    MOV DH, LIZQ
    MOV DL, 06
    INT 10H
    
    MOV AH, 09H
    MOV AL, 04
    INT 10H
    
    MOV  DL, LIZQ
    CMP  DL, 22
    JNE  IZQ
    JE   DER
                        ;LINEA LATERAL DERECHA
DER:
    INC LDER
    MOV AH, 02H
    MOV BH, 0
    MOV DH, LDER
    MOV DL, 74
    INT 10H
    
    MOV AH, 09H
    MOV AL, 179
    MOV BH, 0
    MOV BL, CI
    MOV CX, 1
    INT 10H
    
    MOV AH, 02H
    MOV BH, 0
    MOV DH, LDER
    MOV DL, 73
    INT 10H
    
    MOV AH, 09H
    MOV AL, 04
    MOV BL, CI
    INT 10H
    
    MOV  DL, LDER
    CMP  DL, 22
    JNE  DER
    JE   LETRERO
                          ;MANDAMOS MENSAJE
LETRERO:
    MOV AH, 02H           ;SERVICIO DE POSICION DEL CARACTER
    MOV BH, 0             ;BH = PAGINA
    MOV DH, 09            ;DH = FILA
    MOV DL, 30            ;DL = COLUMNA
    INT 10H
    
    MOV AH, 09H           ;SERVICIO PARA LLAMAR UNA CADENA
    MOV DX, OFFSET MSGB   ;DX = OFFSET MENSAJE
    INT 21H 
    
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 11
    MOV DL, 30
    INT 10H
    
    MOV AH, 09H
    MOV DX, OFFSET MSGNIP
    INT 21H
                          ;REVISION DEL PRIMER NUMERO
REV:                      

    MOV AH, 02H           ;SERVICIO DE POSICION DEL CARACTER
    MOV BH, 0             ;BH = PAGINA
    MOV DH, 13            ;DH = FILA
    MOV DL, 34            ;DL = COLUMNA
    INT 10H
    
    MOV AH, 09H           ;INDICAMOS QUE IMPRIMIR UN CARACTER
    MOV AL, '_'           ; AL = 'CARACTER'
    MOV BH, 00H           ; BH = COLOR DE FONDO
    MOV BL, 0FH           ; BL = COLOR DE CARACTER
    MOV CX, 1             ; CX = VECES QUE SE REPITE EL CARACTER
    INT 10H
    
    MOV AH,07H            ;SERVICO DE LEER UN CARACTER DEL TECLADO  
    INT 21H
    
    CMP AL,30H            ;COMPARAMOS SI ESTA EN EL RANGO DE NUMERO DECIMALES
    JL  REV               ;SI NO ES ASI REGREAMOS HASTA REV
    CMP AL,39H
    JG  REV               ;SI ESTA EN EL RANGO SEGUIMOS EN EL PROCESO
    
    SUB AL,30H            ;RESTAMOS PARA QUE EL CARACTER DE ASCII A HEXA
    MOV N1,AL             ;AGUARDAMOS VARIABLE
    
    MOV AH, 02H           ;SERVICIO DE POSICION DEL CARACTER
    MOV BH, 0
    MOV DH, 13
    MOV DL, 34
    INT 10H
    
    MOV AH, 09H           ;CAMBIAMOS EL DIGITO QUE PUSO EL USUARIO EN *
    MOV AL, '*'
    MOV BH, 00H
    MOV BL, 07H
    MOV CX, 1
    INT 10H
    
REV1:
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 13
    MOV DL, 37
    INT 10H
    
    MOV AH, 09H
    MOV AL, '_'
    MOV BH, 00H
    MOV BL, 0FH
    MOV CX, 1
    INT 10H
    
    MOV AH,07H              
    INT 21H
    
    CMP AL,30H
    JL  REV1
    CMP AL,39H
    JG  REV1
    
    SUB AL,30H
    MOV N2,AL
    
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 13
    MOV DL, 37
    INT 10H
    
    MOV AH, 09H
    MOV AL, '*'
    MOV BH, 00H
    MOV BL, 07H
    MOV CX, 1
    INT 10H

REV2:
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 13
    MOV DL, 40
    INT 10H
    
    MOV AH, 09H
    MOV AL, '_'
    MOV BH, 00H
    MOV BL, 0FH
    MOV CX, 1
    INT 10H
    
    MOV AH,07H              
    INT 21H
    
    CMP AL,30H
    JL  REV2
    CMP AL,39H
    JG  REV2
    
    SUB AL,30H
    MOV N3,AL
    
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 13
    MOV DL, 40
    INT 10H
    
    MOV AH, 09H
    MOV AL, '*'
    MOV BH, 00H
    MOV BL, 07H
    MOV CX, 1
    INT 10H
    
REV3:
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 13
    MOV DL, 43
    INT 10H
    
    MOV AH, 09H
    MOV AL, '_'
    MOV BH, 00H
    MOV BL, 0FH
    MOV CX, 1
    INT 10H
    
    MOV AH,07H              
    INT 21H
    
    CMP AL,30H
    JL  REV3
    CMP AL,39H
    JG  REV3    
    
    SUB AL,30H
    MOV N4,AL
    
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 13
    MOV DL, 43
    INT 10H
    
    MOV AH, 09H
    MOV AL, '*'
    MOV BH, 00H
    MOV BL, 07H
    MOV CX, 1
    INT 10H

;COMPARARMOS NIP
    MOV  DL, N1           ;MOVEMOS LO QUE TENEMOS EN LA VARIABLE N1
    CMP  DL, PSW1         ;COMPARAMOS CON LA CONTRASEÑA ESTABLECIDA
    JNE  SALTAR           ;SI NO ES IGUAL MANDAMOS QUE ESTA INCORRECTA LA CONTRASEÑA
    JE   CONTINUAR        ;SI ES CORRECTO EL PRIMER DIGITO LO CONTINUAMOS REVISANDO LA CONTRASEÑA
SALTAR:
    MOV AH, 02H           ;POSICIONAMOS EN EL ANTERIOR TEXTO
    MOV BH, 0
    MOV DH, 15
    MOV DL, 32
    INT 10H
    
    MOV AH, 09H           ;LIMPIAMOS EL TEXTO ANTERIOR Y PONEMOS DE COLOR ROJO
    MOV AL, ' '
    MOV BH, 0
    MOV BL, CF
    MOV CX, 40
    INT 10H
    
    MOV AH, 09H           ;LLAMAMOS EL MENSAJE DE NIP INCORRECTO
    MOV DX, OFFSET MSGF
    INT 21H  
    
    INT 20H
CONTINUAR:

    MOV  DL, N2
    CMP  DL, PSW2             
    JNE  SALTAR1               
    JE   CONTINUAR1
SALTAR1:
    
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 15
    MOV DL, 32
    INT 10H
    
    MOV AH, 09H
    MOV AL, ' '
    MOV BH, 0
    MOV BL, CF
    MOV CX, 40
    INT 10H
    
    MOV AH, 09H
    MOV DX, OFFSET MSGF
    INT 21H 
    
    INT 20H
CONTINUAR1:

    MOV  DL, N3
    CMP  DL, PSW3         
    JNE  SALTAR2 
    JE   CONTINUAR2
SALTAR2:
    
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 15
    MOV DL, 32
    INT 10H
    
    MOV AH, 09H
    MOV AL, ' '
    MOV BH, 0
    MOV BL, CF
    MOV CX, 40
    INT 10H
    
    MOV AH, 09H
    MOV BL, CF
    MOV DX, OFFSET MSGF
    INT 21H    
    
    INT 20H
CONTINUAR2:
    MOV  DL, N4
    CMP  DL, PSW4     
    JNE  SALTAR3           
    JE   CONTINUAR3
SALTAR3:
    
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 15
    MOV DL, 32
    INT 10H
    
    MOV AH, 09H
    MOV AL, ' '
    MOV BH, 0
    MOV BL, CF
    MOV CX, 40
    INT 10H
    
    MOV AH, 09H
    MOV DX, OFFSET MSGF
    INT 21H
    
    INT 20H
CONTINUAR3: 
        
    MOV AH, 02H           ;POSICIONAMOS EL CARACTER
    MOV BH, 0
    MOV DH, 09
    MOV DL, 30
    INT 10H
    
    MOV AH, 09H           ;LIMPIAMOS EL TEXTO ANTERIOR
    MOV AL, ' '           ; Y PONEMOS COLOR VERDE
    MOV BH, 0
    MOV BL, CV
    MOV CX, 40
    INT 10H
    
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 09
    MOV DL, 33
    INT 10H
    
    MOV AH, 09H
    MOV DX, OFFSET MSGV   ;MANDAMOS MENSAJE QUE ES NIP CORRECTO
    INT 21H 
    
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 11
    MOV DL, 30
    INT 10H
    
    MOV AH, 09H
    MOV AL, ' '
    MOV BH, 0
    MOV BL, CV
    MOV CX, 40
    INT 10H
    
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 11
    MOV DL, 33
    INT 10H
    
    MOV AH, 09H
    MOV DX, OFFSET MSGH   ;MENSAJE DE HOLA USUARIO
    INT 21H
    
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 13
    MOV DL, 30
    INT 10H
    
    MOV AH, 09H
    MOV AL, ' '
    MOV BH, 0
    MOV BL, CV
    MOV CX, 40
    INT 10H
    
    INT 20H               ;FIN DEL PROGRAMA
    
    ;VARIABLES
    N1   DB 00H
    N2   DB 00H
    N3   DB 00H
    N4   DB 00H
    PSW1 DB 01H
    PSW2 DB 02H
    PSW3 DB 03H
    PSW4 DB 04H
    LIZQ DB 01H           ;CONTADOR DE LINEA IZQUIERDA
    LDER DB 01H           ;CONTADOR DE LINEA DERECHA
    CI   DB 0EH           ;COLOR DEL RECUADRO
    CV   DB 0AH           ;COLOR DEL TEXTO DEL CORRECTO NIP
    CF   DB 0CH           ;COLOR DEL TEXTO DEL INCORRECTO NIP
    
    ;MENSAJES
    MSGB   DB "B I E N V E N I D O$"
    MSGNIP DB "| INGRESE SU NIP | $"
    MSGV   DB "NIP CORRECTO $"
    MSGF   DB "NIP INCORRECTO $"
    MSGH   DB "HOLA USUARIO$"