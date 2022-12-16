    MOV AH, 09H             
    MOV DX, OFFSET TITULO   ;IMPRIMIR EL TITULO
    INT 21H
    
;|---LEER NUMEROS---|    
LEER:                       
    MOV AH, 09H            ;LLAMAMOS A IMPRIMIR UN STRING 
    MOV DX, OFFSET ING1     
    INT 21H  
    
    MOV AH,01H             ;LLAMAMOS A LEER UN CARACTER A TRAVES DEL TECLADO 
    INT 21H                   
    
    CMP AL,30H             ;COMPRAMOS SI ESTA EN EL RANGO DE NUMEROS DECIMALES 
    JL  LEER               
    CMP AL,46H
    JG  LEER 

    SUB AL,30H             ;RESTAMOS 30H PARA QUE SEA DE ASCCI A HEXA
    MOV D,AL               ;AGUARAMOS LA DECEMA DEL NUMERO
    
    MOV AH,01H             ;LLAMAMOS A LEER UN CARACTER A TRAVES DEL TECLADO 
    INT 21H
    
    CMP AL,30H              
    JL  LEER 
                    
    CMP AL,46H
    JG  LEER                    
    
    SUB AL,30H             
    MOV U,AL
    
    MOV AL,D
    MOV BL,10
    MUL BL
    ADD AL,U
    MOV NUM1,AL             
    
LEER1:                      
    MOV AH, 09H             
    MOV DX, OFFSET ING2    
    INT 21H  
    
    MOV AH,01H              
    INT 21H                   
     
    CMP AL,30H              
    JL  LEER1 
                    
    CMP AL,46H
    JG  LEER1 
     
    SUB AL,30H             
    MOV D1,AL
    
    MOV AH,01H              
    INT 21H                   
    
    CMP AL,30H              
    JL  LEER1 
                    
    CMP AL,46H
    JG  LEER1 
    
    SUB AL,30H             
    MOV U1,AL
    
    MOV AL,D1
    MOV BL,10
    MUL BL
    ADD AL,U1
    MOV NUM2,AL 

;|---OPERACIONES ARITMETICAS---|
    
                ;SUMA ADD
    ADD AL,NUM1             ;NUM2+NUM1
    MOV SUMA,AL             ;MOVEMOS EL RESULTADO A LA VARIABLE SUMA  
    

                ;RESTA SUB
    MOV AL,NUM1             ;MOVEMOS NUM1 A AL (ACUMULADOR)
    
    SUB AL,NUM2             ;NUM1-NUM2
    MOV RESTA,AL            ;MOVEMOS EL RESULTADO A LA VARIABLE RESTA

    
                ;MULTIPLICACION MUL
    MOV AL,NUM1             ;MOVEMOS NUM1 A AL (ACUMULADOR)
    MOV BL,NUM2             ;MOVEMOS NUM2 A BL (BASE)
    
    MUL BL                  ;NUM1*NUM2
    MOV MULT,AL             ;MOVEMOS EL RESULTADO A LA VARIABLE MULT

    
                ;DIVISION DIV
    MOV AL,NUM1             ;MOVEMOS NUM1 A AL (ACUMULADOR)
    MOV BL,NUM2             ;MOVEMOS NUM2 A BL (BASE)
    
    DIV BL                  ;NUM1/NUM2
    MOV DIVISION,AL         ;MOVEMOS EL RESULTADO A LA VARIABLE DIVISION

    
                ;RESUIDO
    MOV RESIDUO,AH          ;TENIENDO LA OPERACION ANTERIOR EL RESIDUO
                            ;SE ALMACENO EN AH

;|---IMPRIMIR RESULTADOS---|
    
    MOV AH, 09H             ;MANDAMOS A IMPRIMIR EL TITULO
    MOV DX, OFFSET TITULO1  
    INT 21H
                ;|-----MANDAMOS A IMPRIMIR LA SUMA-------|    
    MOV AH, 09H
    MOV DX, OFFSET ESPACIO
    INT 21H
    
    MOV DL,D                ;MANDAMOS A IMPRIMIR NUM1
    ADD DL,30H
    MOV AH,02H
    INT 21H
    MOV DL,U                
    ADD DL,30H
    MOV AH,02H
    INT 21H     
    
    MOV AH, 09H
    MOV DX, OFFSET MAS      ;MANDAMOS A IMPRIMIR EL SIMBOLO +
    INT 21H
    
    MOV DL,D1                ;MANDAMOS A IMPRIMIR NUM2
    ADD DL,30H
    MOV AH,02H
    INT 21H
    MOV DL,U1                
    ADD DL,30H
    MOV AH,02H
    INT 21H     
    
    MOV AH, 09H
    MOV DX, OFFSET IGUAL    ;MANDAMOS A IMPRIMIR EL SIMBOLO =
    INT 21H
    
    
    MOV  DL,SUMA             ;MANDAMOS A IMPRIMIR EL RESULTADO DE LA SUMA
    PUSH DX                 ;AGUARDAR EN PILA NUMEROS TEMPORALES
    SHR  DL,04                ;SEPARAR EN BINARIO LAS DECENAS
    CMP  DL,09H              ;COMPARAMOS EL EL NUMERO ES > DE 9
    JG   SALTAR              ;SI ES >9 SE HACE LA FUNCION SALTAR
    ADD  DL,30H              ;SI NO SE SUMA MAS 37H PARA MAS DE DOS CARACTER
    JMP  CONTINUAR
SALTAR:
    ADD DL,37H
CONTINUAR:
    MOV AH,02H
    INT 21H
    
    POP DX
    AND DL,0FH
    CMP DL,09H              ;COMPARAMOS EL EL NUMERO ES > DE 9
    JG  SALTAR1             ;SI ES >9 SE HACE LA FUNCION SALTAR
    ADD DL,30H              ;SI NO SE SUMA MAS 37H PARA MAS DE DOS CARACTER
    JMP CONTINUAR1
SALTAR1:
    ADD DL,37H
CONTINUAR1:
    MOV AH,02H
    INT 21H
    
    MOV AH, 09H
    MOV DX, OFFSET HEXA
    INT 21H
    
                            ;|---MANDAMOS A IMPRIMIR LA RESTA---|
    MOV AH, 09H
    MOV DX, OFFSET ESPACIO
    INT 21H
    
    MOV DL,D                ;MANDAMOS A IMPRIMIR NUM1
    ADD DL,30H
    MOV AH,02H
    INT 21H
    MOV DL,U                
    ADD DL,30H
    MOV AH,02H
    INT 21H        
    
    MOV AH, 09H
    MOV DX, OFFSET MENOS    ;MANDAMOS A IMPRIMIR EL SIMBOLO -
    INT 21H
    
    MOV DL,D1                ;MANDAMOS A IMPRIMIR NUM2
    ADD DL,30H
    MOV AH,02H
    INT 21H
    MOV DL,U1                
    ADD DL,30H
    MOV AH,02H
    INT 21H   
    
    MOV AH, 09H
    MOV DX, OFFSET IGUAL    ;MANDAMOS A IMPRIMIR EL SIMBOLO =
    INT 21H    
    
    MOV  DL,RESTA             ;MANDAMOS A IMPRIMIR EL RESULTADO DE LA RESTA
    PUSH DX                 ;AGUARDAR EN PILA NUMEROS TEMPORALES
    SHR  DL,4                ;SEPARAR EN BINARIO LAS DECENAS
    CMP  DL,09H              ;COMPARAMOS EL EL NUMERO ES > DE 9
    JG   SALTAR2              ;SI ES >9 SE HACE LA FUNCION SALTAR
    ADD  DL,30H              ;SI NO SE SUMA MAS 37H PARA MAS DE DOS CARACTER
    JMP  CONTINUAR2
SALTAR2:
    ADD DL,37H
CONTINUAR2:
    MOV AH,02H
    INT 21H
    
    POP DX
    AND DL,0FH
    CMP DL,09H              ;COMPARAMOS EL EL NUMERO ES > DE 9
    JG  SALTAR3              ;SI ES >9 SE HACE LA FUNCION SALTAR
    ADD DL,30H              ;SI NO SE SUMA MAS 37H PARA MAS DE DOS CARACTER
    JMP CONTINUAR3
SALTAR3:
    ADD DL,37H
CONTINUAR3:
    MOV AH,02H
    INT 21H
    
    MOV AH, 09H
    MOV DX, OFFSET HEXA
    INT 21H
    
                            ;|---MANDAMOS A IMPRIMIR LA MULTIPLICACION---|
    MOV AH, 09H
    MOV DX, OFFSET ESPACIO
    INT 21H
    
    MOV DL,D                ;MANDAMOS A IMPRIMIR NUM1
    ADD DL,30H
    MOV AH,02H
    INT 21H
    MOV DL,U                
    ADD DL,30H
    MOV AH,02H
    INT 21H        
    
    MOV AH, 09H
    MOV DX, OFFSET POR      ;MANDAMOS A IMPRIMIR EL SIMBOLO *
    INT 21H
    
    MOV DL,D1                ;MANDAMOS A IMPRIMIR NUM2
    ADD DL,30H
    MOV AH,02H
    INT 21H
    MOV DL,U1                
    ADD DL,30H
    MOV AH,02H
    INT 21H    
    
    MOV AH, 09H
    MOV DX, OFFSET IGUAL    ;MANDAMOS A IMPRIMIR EL SIMBOLO =
    INT 21H   
    
    
    MOV  DL,MULT             ;MANDAMOS A IMPRIMIR EL RESULTADO DE LA MULTIPLICACION 
    PUSH DX                 ;AGUARDAR EN PILA NUMEROS TEMPORALES
    SHR  DL,4                ;SEPARAR EN BINARIO LAS DECENAS
    CMP  DL,09H              ;COMPARAMOS EL EL NUMERO ES > DE 9
    JG   SALTAR4              ;SI ES >9 SE HACE LA FUNCION SALTAR
    ADD  DL,30H              ;SI NO SE SUMA MAS 37H PARA MAS DE DOS CARACTER
    JMP  CONTINUAR4
SALTAR4:
    ADD DL,37H
CONTINUAR4:
    MOV AH,02H
    INT 21H
    
    POP DX
    AND DL,0FH
    CMP DL,09H              ;COMPARAMOS EL EL NUMERO ES > DE 9
    JG  SALTAR5             ;SI ES >9 SE HACE LA FUNCION SALTAR
    ADD DL,30H              ;SI NO SE SUMA MAS 37H PARA MAS DE DOS CARACTER
    JMP CONTINUAR5
SALTAR5:
    ADD DL,37H
CONTINUAR5:
    MOV AH,02H
    INT 21H
    
    MOV AH, 09H
    MOV DX, OFFSET HEXA
    INT 21H
    
                            ;|---MANDAMOS A IMPRIMIR LA DIVISION---|
    MOV AH, 09H
    MOV DX, OFFSET ESPACIO
    INT 21H
    
    MOV DL,D                ;MANDAMOS A IMPRIMIR NUM1
    ADD DL,30H
    MOV AH,02H
    INT 21H
    MOV DL,U                
    ADD DL,30H
    MOV AH,02H
    INT 21H        
    
    MOV AH, 09H
    MOV DX, OFFSET ENTRE    ;MANDAMOS A IMPRIMIR EL SIMBOLO /
    INT 21H
    
    MOV DL,D1                ;MANDAMOS A IMPRIMIR NUM2
    ADD DL,30H
    MOV AH,02H
    INT 21H
    MOV DL,U1                
    ADD DL,30H
    MOV AH,02H
    INT 21H    
    
    MOV AH, 09H
    MOV DX, OFFSET IGUAL    ;MANDAMOS A IMPRIMIR EL SIMBOLO =
    INT 21H
    
    
    MOV  DL,DIVISION         ;MANDAMOS A IMPRIMIR EL RESULTADO DE LA DIVISION
    PUSH DX                 ;AGUARDAR EN PILA NUMEROS TEMPORALES
    SHR  DL,4                ;SEPARAR EN BINARIO LAS DECENAS
    CMP  DL,09H              ;COMPARAMOS EL EL NUMERO ES > DE 9
    JG   SALTAR6              ;SI ES >9 SE HACE LA FUNCION SALTAR
    ADD  DL,30H              ;SI NO SE SUMA MAS 37H PARA MAS DE DOS CARACTER
    JMP  CONTINUAR6
SALTAR6:
    ADD DL,37H
CONTINUAR6:
    MOV AH,02H
    INT 21H 
    
    POP DX
    AND DL,0FH
    CMP DL,09H              ;COMPARAMOS EL EL NUMERO ES > DE 9
    JG  SALTAR7              ;SI ES >9 SE HACE LA FUNCION SALTAR
    ADD DL,30H              ;SI NO SE SUMA MAS 37H PARA MAS DE DOS CARACTER
    JMP CONTINUAR7
SALTAR7:
    ADD DL,37H
CONTINUAR7:
    MOV AH,02H
    INT 21H
    
    MOV AH, 09H
    MOV DX, OFFSET HEXA
    INT 21H
    
                            ;|---MANDAMOS A IMPRIMIR EL RESIDUO---|
    MOV AH, 09H
    MOV DX, OFFSET ESPACIO
    INT 21H
    
    MOV DL,D                ;MANDAMOS A IMPRIMIR NUM1
    ADD DL,30H
    MOV AH,02H
    INT 21H
    MOV DL,U                
    ADD DL,30H
    MOV AH,02H
    INT 21H        
    
    MOV AH, 09H
    MOV DX, OFFSET MOD      ;MANDAMOS A IMPRIMIR EL SIMBOLO %
    INT 21H
    
    MOV DL,D1                ;MANDAMOS A IMPRIMIR NUM2
    ADD DL,30H
    MOV AH,02H
    INT 21H
    MOV DL,U1                
    ADD DL,30H
    MOV AH,02H
    INT 21H    
    
    MOV AH, 09H
    MOV DX, OFFSET IGUAL    ;MANDAMOS A IMPRIMIR EL SIMBOLO =
    INT 21H
        
    MOV  DL,RESIDUO          ;MANDAMOS A IMPRIMIR EL RESULTADO DEL RESIDUO
    PUSH DX                 ;AGUARDAR EN PILA NUMEROS TEMPORALES
    SHR  DL,4                ;SEPARAR EN BINARIO LAS DECENAS
    CMP  DL,09H              ;COMPARAMOS EL EL NUMERO ES > DE 9
    JG   SALTAR8              ;SI ES >9 SE HACE LA FUNCION SALTAR
    ADD  DL,30H              ;SI NO SE SUMA MAS 37H PARA MAS DE DOS CARACTER
    JMP  CONTINUAR8
SALTAR8:
    ADD DL,37H
CONTINUAR8:
    MOV AH,02H
    INT 21H
    POP DX
    AND DL,0FH
    CMP DL,09H              ;COMPARAMOS EL EL NUMERO ES > DE 9
    JG  SALTAR9              ;SI ES >9 SE HACE LA FUNCION SALTAR
    ADD DL,30H              ;SI NO SE SUMA MAS 37H PARA MAS DE DOS CARACTER
    JMP CONTINUAR9
SALTAR9:
    ADD DL,37H
CONTINUAR9:
    MOV AH,02H
    INT 21H
    
    MOV AH, 09H
    MOV DX, OFFSET HEXA
    INT 21H
    
    INT 20H                 ;LLAMAMOS EL SERVICIO PARA TERMINA EL PROGRAMA
    
;DECLARACION DE VARIABLES    
    D        DB 00H
    U        DB 00H
    D1       DB 00H
    U1       DB 00H
    NUM1     DB 00H
    NUM2     DB 00H
    SUMA     DB 00H
    RESTA    DB 00H  
    MULT     DB 00H
    DIVISION DB 00H
    RESIDUO  DB 00H

;DECLARACION DE MENSAJES        ;10,13 SALTO DE LINEA
    TITULO   DB 10,13, "/-------->CALCULADORA v5<--------/$"
    ING1     DB 10,13, "|--> INGRESE EL PRIMER  NUMERO : $"
    ING2     DB 10,13, "|--> INGRESE EL SEGUNDO NUMERO : $"
    TITULO1  DB 10,13, "|----> OPERACIONES BASICAS <----|$"
    ESPACIO  DB 10,13, "| ( $"
    IGUAL    DB        " )dec = ( $"
    MAS      DB        " + $"
    MENOS    DB        " - $"
    POR      DB        " * $"
    ENTRE    DB        " / $"
    MOD      DB        " % $"
    HEXA     DB        " )hex |$"