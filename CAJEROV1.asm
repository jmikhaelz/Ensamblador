   
    MOV AH, 00H
    MOV AL, 02H
    INT 10H
    
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 09
    MOV DL, 28
    INT 10H
    
    MOV AH, 09H
    MOV DX, OFFSET MSGB
    INT 21H 
    
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 11
    MOV DL, 28
    INT 10H
    
    MOV AH, 09H
    MOV DX, OFFSET MSGNIP
    INT 21H
    
REV:
    
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 13
    MOV DL, 32
    INT 10H
    
    MOV AH,01H              
    INT 21H
    
    CMP AL,30H
    JL  REV
    CMP AL,39H
    JG  REV
    
    SUB AL,30H
    MOV N1,AL
    
REV1:
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 13
    MOV DL, 35
    INT 10H
    
    MOV AH,01H              
    INT 21H
    
    CMP AL,30H
    JL  REV1
    CMP AL,39H
    JG  REV1
    
    SUB AL,30H
    MOV N2,AL

REV2:
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 13
    MOV DL, 38
    INT 10H
    
    MOV AH,01H              
    INT 21H
    
    CMP AL,30H
    JL  REV2
    CMP AL,39H
    JG  REV2
    
    SUB AL,30H
    MOV N3,AL
    
REV3:
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 13
    MOV DL, 41
    INT 10H
    
    MOV AH,01H              
    INT 21H
    
    CMP AL,30H
    JL  REV3
    CMP AL,39H
    JG  REV3    
    
    SUB AL,30H
    MOV N4,AL

;COMPARARMOS NIP
    MOV  DL, N1
    CMP  DL, PSW1
    JNE  SALTAR
    JE   CONTINUAR
SALTAR:
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 15
    MOV DL, 30
    INT 10H
    
    MOV AH, 09H
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
    MOV DL, 30
    INT 10H
    
    MOV AH, 09H
    MOV DX, OFFSET MSGF
    INT 21H 
    
    INT 20H
CONTINUAR1:

    MOV  DL, N3
    CMP  DL, PSW3              ;COMPARAMOS EL EL NUMERO ES > DE 1
    JNE  SALTAR2                ;SI ES >1 SE HACE LA FUNCION SALTAR
    JE   CONTINUAR2
SALTAR2:
    
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 15
    MOV DL, 30
    INT 10H
    
    MOV AH, 09H
    MOV DX, OFFSET MSGF
    INT 21H    
    
    INT 20H
CONTINUAR2:
    MOV  DL, N4
    CMP  DL, PSW4              ;COMPARAMOS EL EL NUMERO ES > DE 1
    JNE  SALTAR3                ;SI ES >1 SE HACE LA FUNCION SALTAR
    JE   CONTINUAR3
SALTAR3:
    
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 15
    MOV DL, 30
    INT 10H
    
    MOV AH, 09H
    MOV DX, OFFSET MSGF
    INT 21H
    
    INT 20H
CONTINUAR3: 
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 15
    MOV DL, 31
    INT 10H
    
    MOV AH, 09H
    MOV DX, OFFSET MSGV
    INT 21H
    
    MOV AH, 02H
    MOV BH, 0
    MOV DH, 17
    MOV DL, 31
    INT 10H    
    
    MOV AH, 09H
    MOV DX, OFFSET MSGH
    INT 21H
    
    INT 20H
    
    ;VARIABLES
    N1   DB 0
    N2   DB 0
    N3   DB 0
    N4   DB 0
    PSW1 DB 1
    PSW2 DB 2
    PSW3 DB 3
    PSW4 DB 4
    
    ;MENSAJES
    MSGB   DB "/---BIENVENIDO---/ $"
    MSGNIP DB "| INGRESE SU NIP | $"
    MSGV   DB "NIP CORRECTO $"
    MSGF   DB "NIP INCORRECTO $"
    MSGH   DB "HOLA USUARIO $"