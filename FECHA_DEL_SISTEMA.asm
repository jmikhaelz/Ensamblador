; PROGRAMA QUE IMPRIME LA HORA DEL SISTEMA
                    ; MACRO QUE COLOCA EL CURSOR
POSXY MACRO X, Y
    MOV DH, X ;REN
    MOV DL, Y ;COL
    MOV AH, 02H
    INT 10H
POSXY ENDM
                    ;MACRO PARA IMPRIR UN MSG
IMP_CAD MACRO CAD
    MOV AH, 09H
    LEA DX, CAD
    INT 21H
IMP_CAD ENDM

INICIO:
                    ; COLOCAR EL CURSOR
    POSXY 12,30     ; LLAMADO AL PROCEDIMIENTO CURSORXY
    
    IMP_CAD MSG
    
    POSXY 15, 25    ;LLAMADO AL PROCEDIMIENTO CURSOXY
    IMP_CAD MSG1    ;PARA HEX
    
    POSXY 17, 25    ;LLAMADO AL PROCEDIMIENTO CURSOXY
    IMP_CAD MSG1    ;PARA DEC
    
    MOV AH,02AH      ;SERVICO PARA OBTENER LA HORA DEL SISTEMA
    INT 21H
                    ; CX - ANO
                    ; DH - MES
                    ; DL - DIA
                    ; AL - DIA DE LA SEMANA
    MOV AO, CX
    MOV MM, DH
    MOV DA, DL
;---------------------------NOMBRE DE DIA    
    CMP AL, 1
    JGE  LUN          ;SI >= 1
    POSXY 15, 31      ;PARA HEX
    IMP_CAD D
    POSXY 17, 31      ;PARA DEC
    IMP_CAD D
    JMP NOD
LUN:
    CMP AL, 2
    JGE  MAR          ;SI >= 2
    POSXY 15, 31      ;PARA HEX
    IMP_CAD L
    POSXY 17, 31      ;PARA DEC
    IMP_CAD D
    JMP NOD    
MAR:
    CMP AL, 3
    JGE  MIE          ;SI >= 3
    POSXY 15, 31      ;PARA HEX
    IMP_CAD M
    POSXY 17, 31      ;PARA DEC
    IMP_CAD M
    JMP NOD
MIE:
    CMP AL, 4
    JGE  JUE          ;SI >= 4
    POSXY 15, 31      ;PARA HEX
    IMP_CAD X
    POSXY 17, 31      ;PARA DEC
    IMP_CAD X
    JMP NOD
JUE:
    CMP AL, 5
    JGE  VIE          ;SI >= 5
    POSXY 15, 31      ;PARA HEX
    IMP_CAD J
    POSXY 17, 31      ;PARA DEC
    IMP_CAD J
    JMP NOD    
VIE:
    CMP AL, 6
    JGE  SAB          ;SI >= 6
    POSXY 15, 31      ;PARA HEX
    IMP_CAD V
    POSXY 17, 31      ;PARA DEC
    IMP_CAD V
    JMP NOD
SAB:
    POSXY 15, 31      ;PARA HEX
    IMP_CAD S
    POSXY 17, 31      ;PARA DEC
    IMP_CAD S
    JMP NOD
;---------------------------NO. DEL DIA
NOD:
    POSXY 15, 42      ;PARA HEX
    MOV  DL, DA
    PUSH DX
    SHR  DL, 04H
    CALL HEX_ASC
    
    POP  DX
    AND  DL, 0FH
    CALL HEX_ASC
    
    POSXY 17, 42      ;PARA DEC
    MOV  AL, DA
    CALL DEC_ASC
                  ;IMPRIMIR "DE"
    POSXY 15, 44      ;PARA HEX
    IMP_CAD DE
    POSXY 17, 44      ;PARA DEC
    IMP_CAD DE
;------------------------NOMB. DEL MES
MESM:
    MOV AL,MM
    CMP AL, 1
    JGE  M2          ;SI >= 1
    POSXY 15, 47      ;PARA HEX
    IMP_CAD ENE
    POSXY 17, 47      ;PARA DEC
    IMP_CAD ENE
    JMP A_N
M2: 
    CMP AL, 2
    JGE  M3          ;SI >= 2
    POSXY 15, 47      ;PARA HEX
    IMP_CAD FEB
    POSXY 17, 47      ;PARA DEC
    IMP_CAD FEB
    JMP A_N
M3:
    CMP AL, 3
    JGE  M4          ;SI >= 3
    POSXY 15, 47      ;PARA HEX
    IMP_CAD MAZ
    POSXY 17, 47      ;PARA DEC
    IMP_CAD MAZ
    JMP A_N
M4:
    CMP AL, 4
    JGE  M5          ;SI >= 4
    POSXY 15, 47      ;PARA HEX
    IMP_CAD ABR
    POSXY 17, 47      ;PARA DEC
    IMP_CAD ABR
    JMP A_N
M5:
    CMP AL, 5
    JGE  M6          ;SI >= 5
    POSXY 15, 47      ;PARA HEX
    IMP_CAD MAY
    POSXY 17, 47      ;PARA DEC
    IMP_CAD MAY
    JMP A_N
M6:
    CMP AL, 6
    JGE  M7          ;SI >= 6
    POSXY 15, 47      ;PARA HEX
    IMP_CAD JUN
    POSXY 17, 47      ;PARA DEC
    IMP_CAD JUN
    JMP A_N
M7:
    CMP AL, 7
    JGE  M8          ;SI >= 7
    POSXY 15, 47      ;PARA HEX
    IMP_CAD JUL
    POSXY 17, 47      ;PARA DEC
    IMP_CAD JUL
    JMP A_N
M8:
    CMP AL, 8
    JGE  M9          ;SI >= 8
    POSXY 15, 47      ;PARA HEX
    IMP_CAD AGO
    POSXY 17, 47      ;PARA DEC
    IMP_CAD AGO
    JMP A_N
M9:
    CMP AL, 9
    JGE  M10          ;SI >= 9
    POSXY 15, 47      ;PARA HEX
    IMP_CAD SEP
    POSXY 17, 47      ;PARA DEC
    IMP_CAD SEP
    JMP A_N
M10:
    CMP AL, 10
    JGE  M3          ;SI >= 10
    POSXY 15, 47      ;PARA HEX
    IMP_CAD OCT
    POSXY 17, 47      ;PARA DEC
    IMP_CAD OCT
    JMP A_N
M11:
    CMP AL, 11
    JGE  M12          ;SI >= 11
    POSXY 15, 47      ;PARA HEX
    IMP_CAD NOV
    POSXY 17, 47      ;PARA DEC
    IMP_CAD NOV
    JMP A_N
M12:
    POSXY 15, 47      ;PARA HEX
    IMP_CAD DIC
    POSXY 17, 47      ;PARA DEC
    IMP_CAD DIC 
A_N:
                      ;IMPRIMIR "DE"
    POSXY 15, 53      ;PARA HEX
    IMP_CAD DE
    POSXY 17, 53      ;PARA DEC
    IMP_CAD DE
    
    POSXY 15, 57
    
    MOV  DL, CH
    CALL HEX_DOS
    
    MOV  DL, CL
    CALL HEX_DOS
    
    POSXY 17, 57
    
    SUB AX,AX
    SUB BX,BX
    SUB DX,DX
    SUB CX,CX
    
    MOV  AX,AO
    CALL DEC_DOS
                        
    INT 20H
;--------------PROCESOS
HEX_ASC PROC
    CMP  DL, 09H  ;SI DL ES MAYOR SE LE SUMA 37
    JG   LETRA
    ADD  DL, 30H  ;SINO SE SUMA 30
    JMP  IMP
LETRA:
    ADD DL, 37H
IMP:
    MOV AH, 02H   ;SERIVIO PARA IMPRIMRIUN CARACTER
    INT 21H       ;FIN
    RET
HEX_ASC ENDP

HEX_DOS PROC        ;PROCEDIMIENTO DE DOS DIGITOS EN DL
    PUSH DX
    SHR  DL, 04H    ;SE EXTRAE EL EL NIBLE MAS ALTO
    CALL HEX_ASC    
    
    POP  DX         ;SE GUSRDA TEMPORALMENTE
    AND  DL, 0FH    ;SE OBTIENE EL NIBLE MAS BAJO
    CALL HEX_ASC
    RET
HEX_DOS ENDP

DEC_ASC PROC
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
DEC_ASC ENDP

DEC_DOS PROC
    MOV BX,ML
    DIV BX
    MOV CL,DL
    CALL DEC_ASC
    MOV AL,CL
    CALL DEC_ASC
      
    RET             ; REGRESO DEL PROCEDIMIENTO
DEC_DOS ENDP
;----------------VARIABLES
    DA DB 00H
    MM DB 00H
    AO DW 00H
    ML DW 100D
;---------------STRING'S    
    MSG  DB "| FECHA DEL SISTEMA |$"
    MSG1 DB "HOY ES ",24H           ;24H ES $
    D    DB " DOMINGO $"
    L    DB " LUNES $"
    M    DB " MARTES $"
    X    DB " MIERCOLES $"
    J    DB " JUEVES $"
    V    DB " VIERNES $"
    S    DB " SABADO $"
    DE   DB " DE $"
    ENE  DB " ENERO $"
    FEB  DB " FEBRERO $"
    MAZ  DB " MARZO $"
    ABR  DB " ABRIL $"
    MAY  DB " MAYO $"
    JUN  DB " JUNIO $"
    JUL  DB " JULIO $"
    AGO  DB " AGOSTO $"
    SEP  DB " SEPTIEMBRE $"
    OCT  DB " OCTUBRE $"
    NOV  DB " NOVIEMBRE $"
    DIC  DB " DICIEMBRE $"
    HEX  DB "HEX$"
    DECI DB "DEC$"