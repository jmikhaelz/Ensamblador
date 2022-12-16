;------------------------| MACROS 

                         ;POSICIONAR UN TEXTO
POSICION MACRO X,Y
    MOV BH, 0
    MOV DH, X            ;RENGLON
    MOV DL, Y            ;COLUMNA
    MOV AH, 02H
    INT 10H    
POSICION ENDM
                         ;IMPRIMIR CARACTERES
                         
IMPR_CHAR MACRO TEXT, COLOR, VECES
    MOV AH, 09H          ;INDICAMOS QUE IMPRIMIR UN CARACTER
    MOV AL, TEXT         ; AL = 'CARACTER'
    MOV BH, 0            ; BH = COLOR DE FONDO
    MOV BL, COLOR        ; BL = COLOR DE LA LETRA
    MOV CX, VECES        ; CX = VECES QUE SE REPITE
    INT 10H
IMPR_CHAR ENDM 

;------------------------| INICIO DEL PROGRAMA

;+++TITULO
    POSICION 01,50       ;POSICIONAMOS EL TEXTO
    
    IMPR_CHAR 32,0EH,20  ;PINTAMOS EL AREA
    
    POSICION 01,50       ;POSICIONAMOS EL STRING
             
    MOV AH, 09H          ;LLAMAMOS A IMPRIMIR UN STRING 
    MOV DX, OFFSET TT     
    INT 21H
          
;+++DIBUJAR EL CUADRADO
;------------------------| PARTE SUPERIOR
    
                         ;>ESQUINA SUP. IZQ
                         
    POSICION 00,05       ;POSICIONAMOS EL TEXTO

    IMPR_CHAR 218,CI,01  ;INDICAMOS QUE IMPRIMIR UN CARACTER
    
                         ;>LINEA SUPERIR 
                         
    POSICION 00,06       ;POSICIONAMOS EL TEXTO
    
    IMPR_CHAR 196,CI,68  ;INDICAMOS QUE IMPRIMIR UN CARACTER                   
    
                         ;>ESQUINA SUP. DER 
                         
    POSICION 00,74       ;POSICIONAMOS EL TEXTO
    
    IMPR_CHAR 191,CI,01  ;INDICAMOS QUE IMPRIMIR UN CARACTER

;------------------------| PARTE INFERIOR

                         ;>ESQUINA INF. DER
    POSICION  24,05         ;POSICIONAMOS EL TEXTO
    
    IMPR_CHAR 192,CI,01     ;INDICAMOS QUE IMPRIMIR UN CARACTER
  
                         ;>LINEA INFERIOR
                         
    POSICION  24,06         ;POSICIONAMOS EL TEXTO
    
    IMPR_CHAR 196,CI,68     ;INDICAMOS QUE IMPRIMIR UN CARACTER  

                         ;>ESQUINA INF. IZQ
    POSICION  24,74         ;POSICIONAMOS EL TEXTO
    
    IMPR_CHAR 217,CI,01     ;INDICAMOS QUE IMPRIMIR UN CARACTER

                         ;>LINEA LATERAL IZQUIERDA
IZQ:
    INC LIZQ
    POSICION  LIZQ,05       ;POSICIONAMOS EL TEXTO
    
    IMPR_CHAR 179,CI,01     ;INDICAMOS QUE IMPRIMIR UN CARACTER
    
    MOV  DL, LIZQ           ;COMPARAMOS EL LIMITE DE LA LINEA
    CMP  DL, 23
    JNE  IZQ
    JE   DER
                         ;>LINEA LATERAL DERECHA
DER:
    INC LDER
    POSICION  LDER,74       ;POSICIONAMOS EL TEXTO
    
    IMPR_CHAR 179,CI,01     ;INDICAMOS QUE IMPRIMIR UN CARACTER
    
    MOV  DL, LDER           ;COMPARAMOS EL LIMITE DE LA LINEA
    CMP  DL, 23
    JNE  DER
    JE   LINEA             
    
;------------------------| PARTE DE IMPRIMIR EL CARACTER EN ASCII
LINEA:
                         ;>IMPRIMIR EL NUMERO
                         
    POSICION LN,COLN        ;POSICIONAMOS DEL NUMERO
    
    IMPR_CHAR 32,CN,02      ;PINTAMOS EL AREA
                            
                            ;SEPARAR EN DECENAS Y UNIDADES EL NUM
    MOV  DL,NUM             
    PUSH DX                 ;AGUARDAR EN PILA NUMEROS TEMPORALES
    SHR  DL,04              ;SEPARAR EN BINARIO LAS DECENAS
    CALL HEX_ASCII          ;CONVERSION DE HEXADECIMAL A ASCII
    
    MOV D,DL                ;AGUARDAR LA DECENA EN D
    
    POP DX                  ;RECUPERAMOS LA INFORMACION
    AND DL,0FH              ;REVISAR LO ULTIMO
    CALL HEX_ASCII          ;CONVERSION DE HEXADECIMAL A ASCII
    
    MOV U,DL                ;AGUARDAR LA UNIDAD EN U
    
                         ;>IMPRIMIR PUNTO ':'
    
    POSICION LN,COLP        ;POSICIONAMOS DEL NUMERO
    
    IMPR_CHAR ':',0EH,01    ;INDICAMOS QUE IMPRIMIR UN CARACTER
    
                         ;>IMPRIMIR EL CARACTER
    
    POSICION LN,COLC        ;POSICIONAMOS DEL NUMERO
    
    IMPR_CHAR CHAR,CC,01    ;INDICAMOS QUE IMPRIMIR UN CARACTER    
                         
;------------------------| PARTE DE COMPARACIONES
                         
    INC CHAR             ;>INCREMENTAR LAS VARIABLES DE POSICIONES
    INC NUM
    INC LN
                         ;>COMPARACION DE NUMERO
LIMD:
    MOV AL, D               ;COMPARAR LA DECENA
    SUB AL,37H
    CMP AL,0FH
    JE  LIMU
    JNE CMPLN
LIMU:
    MOV AL, U               ;COMPARAR LA UNIDAD
    SUB AL,37H
    CMP AL,0FH
    JE  FIN
    JNE CMPLN    
                         ;>COMPARAR LA POSICION DE LA LINEA
CMPLN:   
	MOV DL, LN
	CMP DL, 22
	JLE LINEA
	JE  COLUMNA
COLUMNA:                 ;>COMPARAR LA POSICION DE LA COLUMNA
    MOV DL, COLC
	CMP DL,  70
	JLE CMPCOL
	JG  FIN
CMPCOL:                  ;>INCREMENTO DE POSICIONES
    MOV LN, 03H             ;REINICIO DE POSICION DE LINEA
    ADD COLC, 05H
    ADD COLP, 05H
    ADD COLN, 05H
    JMP LINEA

;------------------------| FN DEL PROGRAMA

FIN:                   
	INT 20H

;------------------------|PROCECO  

HEX_ASCII PROC
    CMP  DL,09H             ;COMPARAMOS EL EL NUMERO ES > DE 9
    JG   SALTAR             ;SI ES >9 SE HACE LA FUNCION SALTAR
    ADD  DL,30H             ;SI NO SE SUMA MAS 37H PARA MAS DE DOS CARACTER
    JMP  CONTINUAR
SALTAR:
    ADD DL,37H
CONTINUAR:
    MOV AH,02H              ;MANDAMOS A IMPRIMIR
    INT 21H
    RET                     ;RETURN AL CODIGO PRINICPAL
HEX_ASCII ENDP


;------------------------| DECLARACION DE VARIABLES
	
	;CONSTANTES
	LN    DB 03H
	COLP  DB 0AH          ;CONT. DE LINEAS
	COLN  DB 08H          ;CONT. DE COLUMNA NUMERO
	CHAR  DB 00H          ;CONT. DEL CARACTER
	COLC  DB 0BH          ;CONT. DE COLUMNA CARACTER
	NUM   DB 00H          ;NUMERO INDICE DE LA TABLA
	U     DB 00H          ;UNIDADES
	D     DB 00H          ;DECENAS
	LIZQ  DB 00H          ;CONTADOR DE LINEA IZQUIERDA
    LDER  DB 00H          ;CONTADOR DE LINEA DERECHA
    
    ;>COLORES
    CI    DB 0DH          ;COLOR DEL RECUADRO
    CC    DB 0BH          ;COLOR DE LOS CARACTERES
    CN    DB 0FH          ;COLOR DE LOS NUMEROS
    
    ;STRING
    TT    DB "T A B L A  A S C I I$"