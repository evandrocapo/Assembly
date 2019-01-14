TITLE CALCULADORA
.MODEL SMALL
.STACK 100H
.DATA
	MENU_ESCOLHEU DB 0
	ENTRADA_ESCOLHEU DB 0
	NUM1 DW 0
	NUM2 DW 0
	RESULTADO DW 0
	ENTRADA1 DB "0 - BINARIO$"
	ENTRADA2 DB "1 - HEXADECIMAL$"
	ENTRADA3 DB "2 - DECIMAL$"
	MENU1 DB "0 - AND$"
	MENU2 DB "1 - OR$"
	MENU3 DB "2 - XOR$"
	MENU4 DB "3 - NOT$"
	MENU5 DB "4 - SOMA$"
	MENU6 DB "5 - SUBTRACAO$"
	MENU7 DB "6 - MULTIPLICACAO$"
	MENU8 DB "7 - DIVISAO$"
	MENU9 DB "8 - MULTIPLICACAO POR 2$"
	MENU10 DB "9 - DIVISAO POR 2$"
	REPETIR DB "0 - SAIR OU 1 - REPETIR$"
	RESULTADO_DA_CONTA DB "RESULTADO $"
	REPETIR_CAL DB "DESEJA REPETIR A CALCULADORA$"
	DIGITARNUMENT DB "DIGITE O NUMERO DA OPCAO QUE DESEJA$"
	DIGITARNUM1 DB "DIGITE O PRIMEIRO NUMERO: $"
	DIGITARNUM2 DB "DIGITE O SEGUNDO NUMERO: $"
	ESPDACALCULADORA DB "CALCULADORA COM NUMEROS SINALIZADOS$"
	LIMITECALCULADORA DB "NUMERO MIN/MAX -32768/+32767$"
.CODE

MAIN PROC
INICIO_MAIN:

CALL SOBRE_A_CALCU
CALL PULA_LINHA
CALL ENTRADAS_NUMEROS
CALL ENTRADAS_ESCOLHE
CALL MENUS
CALL MENU_ESCOLHE
CALL DIGITAR_NUMEROS
CALL FAZER_CONTAS
CALL PRINTAR

CALL PULA_LINHA
CALL PULA_LINHA
MOV AX,@DATA
MOV DS,AX
MOV AH,9H
LEA DX,REPETIR_CAL
INT 21h
CALL PULA_LINHA
MOV AX,@DATA
MOV DS,AX
MOV AH,9H
LEA DX,REPETIR
INT 21h
CALL PULA_LINHA

MOV AH,1H
INT 21H

CMP AL, 49
JE INICIO_MAIN

MOV AH, 4CH
INT 21H


MAIN ENDP

;-----------------------------------------------------------------------ENTRADAS--------------------------------------------------------------


;------------------------------------------------TEXTO DAS ENTRADA
ENTRADAS_NUMEROS PROC
CALL PULA_LINHA
MOV AX,@DATA
MOV DS,AX
MOV AH,9H
LEA DX,DIGITARNUMENT
INT 21h
CALL PULA_LINHA

;ENTRADA0
CALL PULA_LINHA
MOV AX,@DATA
MOV DS,AX
MOV AH,9H
LEA DX,ENTRADA1
INT 21h
CALL PULA_LINHA
;ENTRADA1
CALL PULA_LINHA
MOV AX,@DATA
MOV DS,AX
MOV AH,9H
LEA DX,ENTRADA2
INT 21h
CALL PULA_LINHA
;ENTRADA2
CALL PULA_LINHA
MOV AX,@DATA
MOV DS,AX
MOV AH,9H
LEA DX,ENTRADA3
INT 21h
CALL PULA_LINHA
CALL PULA_LINHA
RET
ENTRADAS_NUMEROS ENDP
;------------------------------------------------FIM TEXTO ENTRADA


;------------------------------------------------ENTRA E COMPARA AS ENTRADAS
ENTRADAS_ESCOLHE PROC
REPETIR_ENTRADAS_ESCOLHE:
MOV AH,1H
INT 21H
MOV [ENTRADA_ESCOLHEU],AL

MOV BL, 48
CMP BL, AL
JE FIM_DA_ENTRADA
JMP PT1_HEXA
;--------------------
PT1_HEXA:
MOV BL,49
CMP BL, AL
JE FIM_DA_ENTRADA
JMP PT2_DECI
;--------------------
PT2_DECI:
MOV BL,50
CMP BL, AL
JE FIM_DA_ENTRADA
JMP NO_MATCH_ENTRADAS
;-----------------
NO_MATCH_ENTRADAS:
CALL ENTRADAS_NUMEROS
JMP REPETIR_ENTRADAS_ESCOLHE
;---------------------
FIM_DA_ENTRADA:
RET
ENTRADAS_ESCOLHE ENDP
;------------------------------------------------FIM DE COMPARAR

;---------------------------------------------------------------------------------FIM DAS ENTRADAS------------------------------------------------------

;--------------------------------------------------------------------------------MENUS-------------------------------------------------------------------

MENUS PROC
CALL PULA_LINHA
MOV AX,@DATA
MOV DS,AX
MOV AH,9H
LEA DX,DIGITARNUMENT
INT 21h
CALL PULA_LINHA

;MENUS0
CALL PULA_LINHA
MOV AX,@DATA
MOV DS,AX
MOV AH,9H
LEA DX,MENU1
INT 21h
CALL PULA_LINHA
;MENU1
MOV AX,@DATA
MOV AH,9H
LEA DX,MENU2
INT 21h
CALL PULA_LINHA
;MENU2
MOV AX,@DATA
MOV AH,9H
LEA DX,MENU3
INT 21h
CALL PULA_LINHA
;MENU3
MOV AX,@DATA
MOV AH,9H
LEA DX,MENU4
INT 21h
CALL PULA_LINHA
;MENU4
MOV AX,@DATA
MOV AH,9H
LEA DX,MENU5
INT 21h
CALL PULA_LINHA
;MENU5
MOV AX,@DATA
MOV AH,9H
LEA DX,MENU6
INT 21h
CALL PULA_LINHA
;MENU6
MOV AX,@DATA
MOV AH,9H
LEA DX,MENU7
INT 21h
CALL PULA_LINHA
;MENU7
MOV AX,@DATA
MOV AH,9H
LEA DX,MENU8
INT 21h
CALL PULA_LINHA
;MENU8
MOV AX,@DATA
MOV AH,9H
LEA DX,MENU9
INT 21h
CALL PULA_LINHA
;MENU9
MOV AX,@DATA
MOV AH,9H
LEA DX,MENU10
INT 21h
CALL PULA_LINHA
RET
MENUS ENDP






MENU_ESCOLHE PROC
REPETIR_MENU_ESCOLHE:
MOV AH,1H
INT 21H
MOV [MENU_ESCOLHEU],AL

MOV BL,48
CMP BL, AL
JE FIM_MENU ; SIM ?
JMP MENU_OR_JE1 ; NAO ?
;------------------------------
MENU_OR_JE1: ; CONTINUEMOS
MOV BL,49
CMP BL, AL
JE FIM_MENU
JMP MENU_XOR_JE1
;---------------------
MENU_XOR_JE1:
MOV BL,50
CMP BL, AL
JE FIM_MENU
JMP MENU_NOT_JE1
;---------------------
MENU_NOT_JE1:
MOV BL,51
CMP BL, AL
JE FIM_MENU
JMP MENU_SOMA_JE1
;---------------
MENU_SOMA_JE1:
MOV BL,52
CMP BL, AL
JE FIM_MENU
JMP MENU_SUB_JE1
;-------------------
MENU_SUB_JE1:
MOV BL,53
CMP BL, AL
JE FIM_MENU
JMP MENU_MULT_JE1
;------------------
MENU_MULT_JE1:
MOV BL,54
CMP BL, AL
JE FIM_MENU
JMP MENU_DIV_JE1
;-------------------
MENU_DIV_JE1:
MOV BL,55
CMP BL, AL
JE FIM_MENU
JMP MENU_MULT2_JE1
;-------------------
MENU_MULT2_JE1:
MOV BL,56
CMP BL, AL
JE FIM_MENU
JMP MENU_DIV2_JE1
;---------------------
MENU_DIV2_JE1:
MOV BL,57
CMP BL, AL
JE FIM_MENU
JMP REPETIR_ESCOLHE_MENU
;-----------------------
REPETIR_ESCOLHE_MENU:
CALL MENUS
JMP REPETIR_MENU_ESCOLHE
FIM_MENU:
RET
MENU_ESCOLHE ENDP


;----------------------------------------------------------------FIM DE MENUS-------------------------------------------------------------------

;----------------------------------------------------------------DIGITAR NUMEROS----------------------------------------------------------------


DIGITAR_NUMEROS PROC
MOV AL, [ENTRADA_ESCOLHEU]
MOV BL, 48
CMP BL, AL
JE ENT_BIN
JMP PT1_HEXA_NUM
;--------------------
ENT_BIN:

CALL ENTRADA_BINARIO
JMP FIM_DA_ENTRADA_NUM

;--------------------
PT1_HEXA_NUM:
MOV BL,49
CMP BL, AL
JE ENT_HEXA
JMP PT2_DECI_NUM
;--------------------
ENT_HEXA:

CALL ENTRADA_HEXADECIMAL
JMP FIM_DA_ENTRADA_NUM

;-------------------
PT2_DECI_NUM:
MOV BL,50
CMP BL, AL
JE ENT_DECI
JMP FIM_DA_ENTRADA_NUM
;--------------------
ENT_DECI:

CALL ENTRADA_DECIMAL
JMP FIM_DA_ENTRADA_NUM

;--------------------
FIM_DA_ENTRADA_NUM:
RET
DIGITAR_NUMEROS ENDP








ENTRADA_BINARIO PROC
MOV AX,@DATA
MOV DS,AX
MOV AH,9H
LEA DX,DIGITARNUM1
INT 21h



		; PRIMEIRO BINARIO
		
		MOV CX,16		;inicializa contador de dígitos
		MOV AH,1h		;função DOS para entrada pelo teclado
		XOR BX,BX		;zera BX -> terá o resultado
		INT   21h			;entra, caracter está no AL
;while
TOPO:	CMP AL,0Dh		;é CR?
		JZ  FIM			;se sim, termina o WHILE
		AND AL,0Fh		;se não, elimina 30h do caracter
					;(poderia ser SUB AL,30h)
		SHL	BX,1			;abre espaço para o novo dígito
		OR 	BL,AL		;insere o dígito no LSB de BL
		INT 21h			;entra novo caracter
		LOOP  TOPO		;controla o máximo de 16 dígitos
;end_while
FIM:

		MOV [NUM1],BX	; MOVER BX PARA A VARIAVEL DE 16BITS	
		XOR BX,BX
		
		; VER SE A CONTA PRECISA APENA DE 1 NUMERO - NOT,MULT2,DIV2
		MOV BL,[MENU_ESCOLHEU]
		CMP BL, 51
		JE APENAS_UM_NUMERO
		CMP BL, 56
		JE APENAS_UM_NUMERO
		CMP BL, 57
		JE APENAS_UM_NUMERO
		
		
		
CALL PULA_LINHA		
MOV AX,@DATA
MOV DS,AX
MOV AH,9H
LEA DX,DIGITARNUM2
INT 21h		
		
		; SEGUNDO BINARIO
				
		MOV CX,16		;inicializa contador de dígitos
		MOV AH,1h		;função DOS para entrada pelo teclado
		XOR BX,BX		;zera BX -> terá o resultado
		INT   21h			;entra, caracter está no AL
;while
TOPO2:	CMP AL,0Dh		;é CR?
		JZ  FIM2			;se sim, termina o WHILE
		AND AL,0Fh		;se não, elimina 30h do caracter
					;(poderia ser SUB AL,30h)
		SHL	BX,1			;abre espaço para o novo dígito
		OR 	BL,AL		;insere o dígito no LSB de BL
		INT 21h			;entra novo caracter
		LOOP  TOPO2		;controla o máximo de 16 dígitos
;end_while
FIM2:

		MOV [NUM2],BX	; MOVER BX PARA A VARIAVEL DE 16BITS
		XOR BX,BX ; LIMPA O BX
		
APENAS_UM_NUMERO:		
RET
ENTRADA_BINARIO ENDP






ENTRADA_HEXADECIMAL PROC

MOV AX,@DATA
MOV DS,AX
MOV AH,9H
LEA DX,DIGITARNUM1
INT 21h

		XOR BX,BX		;inicializa BX com zero
		MOV CL,4		;inicializa contador com 4
		MOV AH,1h		;prepara entrada pelo teclado
		INT 21h			;entra o primeiro caracter
;while
TOPO_HEXA1:	CMP AL,0Dh		;é o CR ?
		JE  FIM_HEXA1
		CMP AL, 39h		;caracter número ou letra?
		JG  LETRA_HEXA1		;caracter já está na faixa ASCII
		AND AL,0FH		;número: retira 30h do ASCII
		JMP  DESL_HEXA1
LETRA_HEXA1:	SUB AL,37h		;converte letra para binário
DESL_HEXA1:     SHL BX,CL		;desloca BX 4 casas à esquerda
		OR BL,AL		;insere valor nos bits 0 a 3 de BX
		INT 21h			;entra novo caracter
		JMP TOPO_HEXA1		;faz o laço até que haja CR
;end_while
FIM_HEXA1:

		MOV [NUM1],BX	; MOVER BX PARA A VARIAVEL DE 16BITS	
		XOR BX,BX
		
		; VER SE A CONTA PRECISA APENA DE 1 NUMERO - NOT,MULT2,DIV2
		MOV BL,[MENU_ESCOLHEU]
		CMP BL, 51
		JE APENAS_UM_NUMERO_HEXA
		CMP BL, 56
		JE APENAS_UM_NUMERO_HEXA
		CMP BL, 57
		JE APENAS_UM_NUMERO_HEXA
		
		
CALL PULA_LINHA		
MOV AX,@DATA
MOV DS,AX
MOV AH,9H
LEA DX,DIGITARNUM2
INT 21h	

	XOR BX,BX		;inicializa BX com zero
		MOV CL,4		;inicializa contador com 4
		MOV AH,1h		;prepara entrada pelo teclado
		INT 21h			;entra o primeiro caracter
;while
TOPO_HEXA2:	CMP AL,0Dh		;é o CR ?
		JE  FIM_HEXA2
		CMP AL, 39h		;caracter número ou letra?
		JG  LETRA_HEXA2		;caracter já está na faixa ASCII
		AND AL,0FH		;número: retira 30h do ASCII
		JMP  DESL_HEXA2
LETRA_HEXA2:	SUB AL,37h		;converte letra para binário
DESL_HEXA2:     SHL BX,CL		;desloca BX 4 casas à esquerda
		OR BL,AL		;insere valor nos bits 0 a 3 de BX
		INT 21h			;entra novo caracter
		JMP TOPO_HEXA2		;faz o laço até que haja CR
;end_while
FIM_HEXA2:

	MOV [NUM2],BX	; MOVER BX PARA A VARIAVEL DE 16BITS
	XOR BX,BX ; LIMPA O BX


APENAS_UM_NUMERO_HEXA:
RET
ENTRADA_HEXADECIMAL ENDP





ENTRADA_DECIMAL PROC

MOV AX,@DATA
MOV DS,AX
MOV AH,9H
LEA DX,DIGITARNUM1
INT 21h

;le um numero decimal da faixa de -32768 a +32767
;variaveis de entrada: nehuma (entrada de digitos pelo teclado)
;variaveis de saida: AX -> valor binario equivalente do numero decimal
				
		PUSH 	BX
		PUSH 	CX
		PUSH 	DX 			;salvando registradores que serão usados
		XOR 	BX,BX 		;BX acumula o total, valor inicial 0
		XOR 	CX,CX 		;CX indicador de sinal (negativo = 1), inicial = 0
		MOV 	AH,1h
		INT 	21h 		;le caracter no AL
		CMP 	AL,'-' 		;sinal negativo?
		JE 		MENOS
		CMP 	AL,'+' 		;sinal positivo?
		JE 		MAIS
		JMP 	NUM 		;se nao é sinal, então vá processar o caracter
MENOS: 	MOV 	CX,1 		;negativo = verdadeiro
MAIS: 	INT 	21h 		;le um outro caracter
NUM: 	AND 	AX,000Fh 	;junta AH a AL, converte caracter para binário
		PUSH 	AX 			;salva AX (valor binário) na pilha
		MOV 	AX,10 		;prepara constante 10
		MUL 	BX 			;AX = 10 x total, total está em BX
		POP 	BX 			;retira da pilha o valor salvo, vai para BX
		ADD 	BX,AX 		;total = total x 10 + valor binário
		MOV 	AH,1h
		INT 	21h 		;le um caracter
		CMP 	AL,0Dh 		;é o CR ?
		JNE 	NUM 		;se não, vai processar outro dígito em NUM
		MOV 	AX,BX 		;se é CR, então coloca o total calculado em AX
		CMP 	CX,1 		;o numero é negativo?
		JNE 	SAIDA 		;não
		NEG 	AX 			;sim, faz-se seu complemento de 2
SAIDA: 	POP 	DX
		POP 	CX
		POP 	BX 			;restaura os conteúdos originais
		
		MOV [NUM1],AX	; MOVER AX PARA A VARIAVEL DE 16BITS	
		XOR AX,AX
		
		; VER SE A CONTA PRECISA APENA DE 1 NUMERO - NOT,MULT2,DIV2
		MOV BL,[MENU_ESCOLHEU]
		CMP BL, 51
		JE APENAS_UM_NUMERO_DEC
		CMP BL, 56
		JE APENAS_UM_NUMERO_DEC
		CMP BL, 57
		JE APENAS_UM_NUMERO_DEC
		
CALL PULA_LINHA		
MOV AX,@DATA
MOV DS,AX
MOV AH,9H
LEA DX,DIGITARNUM2
INT 21h	

XOR AX,AX

PUSH 	BX
		PUSH 	CX
		PUSH 	DX 			;salvando registradores que serão usados
		XOR 	BX,BX 		;BX acumula o total, valor inicial 0
		XOR 	CX,CX 		;CX indicador de sinal (negativo = 1), inicial = 0
		MOV 	AH,1h
		INT 	21h 		;le caracter no AL
		CMP 	AL,'-' 		;sinal negativo?
		JE 		MENOS2
		CMP 	AL,'+' 		;sinal positivo?
		JE 		MAIS2
		JMP 	NUM_2 		;se nao é sinal, então vá processar o caracter
MENOS2: 	MOV 	CX,1 		;negativo = verdadeiro
MAIS2: 	INT 	21h 		;le um outro caracter
NUM_2: 	AND 	AX,000Fh 	;junta AH a AL, converte caracter para binário
		PUSH 	AX 			;salva AX (valor binário) na pilha
		MOV 	AX,10 		;prepara constante 10
		MUL 	BX 			;AX = 10 x total, total está em BX
		POP 	BX 			;retira da pilha o valor salvo, vai para BX
		ADD 	BX,AX 		;total = total x 10 + valor binário
		MOV 	AH,1h
		INT 	21h 		;le um caracter
		CMP 	AL,0Dh 		;é o CR ?
		JNE 	NUM_2 		;se não, vai processar outro dígito em NUM
		MOV 	AX,BX 		;se é CR, então coloca o total calculado em AX
		CMP 	CX,1 		;o numero é negativo?
		JNE 	SAIDA2 		;não
		NEG 	AX 			;sim, faz-se seu complemento de 2
SAIDA2: 	POP 	DX
		POP 	CX
		POP 	BX 			;restaura os conteúdos originais
		
		MOV [NUM2],AX	; MOVER BX PARA A VARIAVEL DE 16BITS	
		XOR AX,AX

APENAS_UM_NUMERO_DEC:
RET
ENTRADA_DECIMAL ENDP





;-----------------------------------------------------------------FIM DIGITAR NUMEROS-------------------------------------------------------------

;-----------------------------------------------------------------SAIDA DOS NUMEROS---------------------------------------------------------------

PRINTAR PROC
MOV AL,[ENTRADA_ESCOLHEU]
MOV BL, 48
CMP BL, AL
JE PRINT_BIN
JMP PT1_HEXA_PRINT
;-------------------
PRINT_BIN:
CALL SAIDA_BINARIO
JMP FIM_DA_ENTRADA_PRINT
;--------------------
PT1_HEXA_PRINT:
MOV BL,49
CMP BL, AL
JE PRINT_HEXA
JMP PT2_DECI_PRINT
;--------------------
PRINT_HEXA:
CALL SAIDA_HEXADECIMAL
JMP FIM_DA_ENTRADA_PRINT
;--------------
PT2_DECI_PRINT:
MOV BL,50
CMP BL, AL
JE PRINT_DEC
JMP FIM_DA_ENTRADA_PRINT
;-----------------
PRINT_DEC:
CALL SAIDA_DECIMAL
JMP FIM_DA_ENTRADA_PRINT
;---------------------
FIM_DA_ENTRADA_PRINT:
RET





RET
PRINTAR ENDP




SAIDA_BINARIO PROC
MOV AX,@DATA
MOV DS,AX
MOV AH,9H
LEA DX,RESULTADO_DA_CONTA
INT 21h

MOV BX,[RESULTADO]

		MOV CX,16		;inicializa contador de bits
		MOV AH,02h		;prepara para exibir no monitor
;for 16 vezes do
PT1:	ROL BX,1		;desloca BX 1 casa à esquerda
;if CF = 1
		JNC  PT2		;salta se CF = 0
;then
		MOV DL, 31h		;como CF = 1
		INT 21h			;exibe na tela "1" = 31h
;else
		JMP FIM_SAIDA_BINARIO
PT2:	MOV DL, 30h		;como CF = 0
		INT 21h			;exibe na tela "0" = 30h
;end_if
FIM_SAIDA_BINARIO:
		LOOP  PT1		;repete 16 vezes
;end_for

RET
SAIDA_BINARIO ENDP

SAIDA_HEXADECIMAL PROC
MOV AX,@DATA
MOV DS,AX
MOV AH,9H
LEA DX,RESULTADO_DA_CONTA
INT 21h


MOV BX, [RESULTADO]

;BX já contem número binário
		MOV CH,4	;CH contador de caracteres hexa
		MOV CL,4	;CL contador de delocamentos
		MOV AH,2h	;prepara exibição no monitor
;for 4 vezes do
TOPO2_HEXA_SAIDA:	MOV DL,BH	;captura em DL os oito bits mais significativos de BX
		SHR DL,CL	;resta em DL os 4 bits mais significativos de BX
;if DL , 10
		CMP DL, 0Ah	;testa se é letra ou número
		JAE LETRA2_HEXA_SAIDA
;then
		ADD DL,30h	;é número: soma-se 30h
		JMP PT5_HEXA_SAIDA
;else
LETRA2_HEXA_SAIDA:	ADD DL,37h	;ao valor soma-se 37h -> ASCII
;end_if
PT5_HEXA_SAIDA:	INT 21h		;exibe
		ROL BX,CL	;roda BX 4 casas para a direita
		DEC CH
		JNZ TOPO2_HEXA_SAIDA	;faz o FOR 4 vezes
;end_for
				;programa continua
				RET
SAIDA_HEXADECIMAL ENDP

SAIDA_DECIMAL PROC
MOV AX,@DATA
MOV DS,AX
MOV AH,9H
LEA DX,RESULTADO_DA_CONTA
INT 21h


		MOV CX,[RESULTADO]
;exibe o conteudo de AX como decimal inteiro com sinal
;variaveis de entrada: AX -> valor binario equivalente do número decimal
;variaveis de saida: nehuma (exibição de dígitos direto no monitor de video)

		MOV 	AX,CX
		
		PUSH 	AX
		PUSH 	BX
		PUSH 	CX
		PUSH 	DX 		;salva na pilha os registradores usados
		OR 		AX,AX 	;prepara comparação de sinal
		JGE 	PT1_SAIDA_DEC 	;se AX maior ou igual a 0, vai para PT1
		PUSH 	AX 		;como AX menor que 0, salva o número na pilha
		MOV 	DL,'-'	;prepara o caracter ' - ' para sair
		MOV 	AH,2h 	;prepara exibição
		INT 	21h 	;exibe ' - '
		POP 	AX 		;recupera o número
		NEG 	AX 		;troca o sinal de AX (AX = - AX)
		
		;obtendo dígitos decimais e salvando-os temporariamente na pilha
PT1_SAIDA_DEC: 	XOR 	CX,CX 	;inicializa CX como contador de dígitos
		MOV 	BX,10 	;BX possui o divisor
PT2_SAIDA_DEC: 	XOR 	DX,DX 	;inicializa o byte alto do dividendo em 0; restante é AX
		DIV 	BX 		;após a execução, AX = quociente; DX = resto
		PUSH 	DX 		;salva o primeiro dígito decimal na pilha (1o. resto)
		INC 	CX 		;contador = contador + 1
		OR 		AX,AX 	;quociente = 0 ? (teste de parada)
		JNE 	PT2_SAIDA_DEC 	;não, continuamos a repetir o laço
		
		;exibindo os dígitos decimais (restos) no monitor, na ordem inversa
		MOV 	AH,2h 	;sim, termina o processo, prepara exibição dos restos
PT3_SAIDA_DEC: 	POP 	DX 		;recupera dígito da pilha colocando-o em DL (DH = 0)
		ADD 	DL,30h 	;converte valor binário do dígito para caracter ASCII
		INT 	21h 	;exibe caracter
		LOOP 	PT3_SAIDA_DEC 	;realiza o loop ate que CX = 0
		POP 	DX 		;restaura o conteúdo dos registros
		POP 	CX
		POP 	BX
		POP 	AX 		;restaura os conteúdos dos registradores
		RET 			;retorna à rotina que chamou
SAIDA_DECIMAL ENDP


;-------------------------------------------------------------FIM DA SAIDA DOS NUMEROS------------------------------------------------------------




;-----------------------------------------------------------------FAZER CONTAS--------------------------------------------------------------------

FAZER_CONTAS PROC
MOV AL,[MENU_ESCOLHEU]
MOV BL,48
CMP BL, AL
JE MENU_AND_JE_CONTAS ; SIM ?
JMP MENU_OR_JE1_CONTAS ; NAO ?
;----------------------------
MENU_AND_JE_CONTAS: ; UHULL
CALL MENU_AND 
JMP FIM_MENU_CONTAS
;------------------------------
MENU_OR_JE1_CONTAS: ; CONTINUEMOS
MOV BL,49
CMP BL, AL
JE MENU_OR_JE2_CONTAS
JMP MENU_XOR_JE1_CONTAS
;-------------------
MENU_OR_JE2_CONTAS:
CALL MENU_OR
JMP FIM_MENU_CONTAS
;---------------------
MENU_XOR_JE1_CONTAS:
MOV BL,50
CMP BL, AL
JE MENU_XOR_JE2_CONTAS
JMP MENU_NOT_JE1_CONTAS
;---------------------
MENU_XOR_JE2_CONTAS:
CALL MENU_XOR
JMP FIM_MENU_CONTAS
;---------------------
MENU_NOT_JE1_CONTAS:
MOV BL,51
CMP BL, AL
JE MENU_NOT_JE2_CONTAS
JMP MENU_SOMA_JE1_CONTAS
;--------------
MENU_NOT_JE2_CONTAS:
CALL MENU_NOT
JMP FIM_MENU_CONTAS
;---------------
MENU_SOMA_JE1_CONTAS:
MOV BL,52
CMP BL, AL
JE MENU_SOMA_JE2_CONTAS
JMP MENU_SUB_JE1_CONTAS
;-----------------
MENU_SOMA_JE2_CONTAS:
CALL MENU_SOMA
JMP FIM_MENU_CONTAS
;-------------------
MENU_SUB_JE1_CONTAS:
MOV BL,53
CMP BL, AL
JE MENU_SUB_JE2_CONTAS
JMP MENU_MULT_JE1_CONTAS
;---------------------
MENU_SUB_JE2_CONTAS:
CALL MENU_SUB
JMP FIM_MENU_CONTAS
;------------------
MENU_MULT_JE1_CONTAS:
MOV BL,54
CMP BL, AL
JE MENU_MULT_JE2_CONTAS
JMP MENU_DIV_JE1_CONTAS
;-------------------
MENU_MULT_JE2_CONTAS:
CALL MENU_MULT
JMP FIM_MENU_CONTAS
;-------------------
MENU_DIV_JE1_CONTAS:
MOV BL,55
CMP BL, AL
JE MENU_DIV_JE2_CONTAS
JMP MENU_MULT2_JE1_CONTAS
;-------------------
MENU_DIV_JE2_CONTAS:
CALL MENU_DIV
JMP FIM_MENU_CONTAS
;-------------------
MENU_MULT2_JE1_CONTAS:
MOV BL,56
CMP BL, AL
JE MENU_MULT2_JE2_CONTAS
JMP MENU_DIV2_JE1_CONTAS
;------------------
MENU_MULT2_JE2_CONTAS:
CALL MENU_MULT2
JMP FIM_MENU_CONTAS
;---------------------
MENU_DIV2_JE1_CONTAS:
MOV BL,57
CMP BL, AL
JE MENU_DIV2_JE2_CONTAS
JMP FIM_MENU_CONTAS
;-----------------------
MENU_DIV2_JE2_CONTAS:
CALL MENU_DIV2
JMP FIM_MENU_CONTAS
;------------------
FIM_MENU_CONTAS:
RET
FAZER_CONTAS ENDP

;----------------------------------------------------------------FIM FAZER CONTAS-----------------------------------------------------------------




;---------------------------------------------------------------OPERAÇÕES-------------------------------------------------------------------------

MENU_AND PROC
PUSH AX ; AX PARA PILHA
PUSH BX ; BX PARA PILHA
MOV BX,[NUM1]
AND BX,[NUM2]
MOV [RESULTADO],BX
POP BX
POP AX
RET
MENU_AND ENDP

MENU_OR PROC
PUSH AX ; AX PARA PILHA
PUSH BX ; BX PARA PILHA
MOV BX,[NUM1]
OR BX,[NUM2]
MOV [RESULTADO],BX
POP BX
POP AX
RET
MENU_OR ENDP

MENU_XOR PROC
PUSH AX ; AX PARA PILHA
PUSH BX ; BX PARA PILHA
MOV BX,[NUM1]
XOR BX,[NUM2]
MOV [RESULTADO],BX
POP BX
POP AX
RET
MENU_XOR ENDP

MENU_NOT PROC
PUSH AX ; AX PARA PILHA
PUSH BX ; BX PARA PILHA
MOV BX,[NUM1]
NOT BX
MOV [RESULTADO],BX
POP BX
POP AX
RET
MENU_NOT ENDP

MENU_SOMA PROC
PUSH AX ; AX PARA PILHA
PUSH BX ; BX PARA PILHA
MOV BX,[NUM1]
ADD BX,[NUM2]
MOV [RESULTADO],BX
POP BX
POP AX
RET
MENU_SOMA ENDP

MENU_SUB PROC
PUSH AX ; AX PARA PILHA
PUSH BX ; BX PARA PILHA
MOV BX,[NUM1]
SUB BX,[NUM2]
MOV [RESULTADO],BX
POP BX
POP AX
RET
MENU_SUB ENDP

MENU_MULT PROC
PUSH AX ; AX PARA PILHA
PUSH BX ; BX PARA PILHA
MOV AX,[NUM1]
IMUL [NUM2]
MOV [RESULTADO],AX
POP BX
POP AX
RET
MENU_MULT ENDP

MENU_DIV PROC
PUSH AX ; AX PARA PILHA
PUSH BX ; BX PARA PILHA
PUSH DX ; DX PARA PILHA
XOR DX,DX
MOV AX,[NUM1]
MOV BX,[NUM2]
IDIV BX
MOV [RESULTADO],AX
POP DX
POP BX
POP AX
RET
MENU_DIV ENDP

MENU_MULT2 PROC
PUSH AX ; AX PARA PILHA
PUSH BX ; BX PARA PILHA
MOV AX,[NUM1]

REPETIR_MULT2:
MOV BX, 2
IMUL BX
MOV [RESULTADO],AX

CALL PULA_LINHA
CALL PRINTAR
CALL PULA_LINHA
MOV AX,@DATA
MOV DS,AX
MOV AH,9H
LEA DX,REPETIR
INT 21h
CALL PULA_LINHA

MOV AH,1H
INT 21H

CMP AL, 49
JE COMP_REPETIR_MULT2
JMP FIM_MULT2
;-----------------------
COMP_REPETIR_MULT2:
MOV AX,[RESULTADO]
JMP REPETIR_MULT2
;---------------------
FIM_MULT2:
CALL PULA_LINHA
POP BX
POP AX
RET

MENU_MULT2 ENDP

MENU_DIV2 PROC
PUSH AX ; AX PARA PILHA
PUSH BX ; BX PARA PILHA
PUSH DX ; DX PARA PILHA
XOR DX,DX
MOV AX,[NUM1]

REPETIR_DIV2:
MOV BX, 2
IDIV BX
MOV [RESULTADO],AX

CALL PULA_LINHA
CALL PRINTAR
CALL PULA_LINHA

MOV AX,@DATA
MOV DS,AX
MOV AH,9H
LEA DX,REPETIR
INT 21h
CALL PULA_LINHA

MOV AH,1H
INT 21H

CMP AL, 49
JE COMP_REPETIR_DIV2
JMP FIM_DIV2
;--------------
COMP_REPETIR_DIV2:
MOV AX,[RESULTADO]
XOR DX,DX
JMP REPETIR_DIV2
;--------------
FIM_DIV2:
CALL PULA_LINHA
POP DX
POP BX
POP AX
RET
MENU_DIV2 ENDP









;---------------------------------------------------------------FIM DAS OPERAÇÕES------------------------------------------------------------------

SOBRE_A_CALCU PROC
CALL PULA_LINHA
MOV AX,@DATA
MOV DS,AX
MOV AH,9H
LEA DX,ESPDACALCULADORA
INT 21h

CALL PULA_LINHA
MOV AX,@DATA
MOV DS,AX
MOV AH,9H
LEA DX,LIMITECALCULADORA
INT 21h

CALL PULA_LINHA
RET
SOBRE_A_CALCU ENDP


PULA_LINHA PROC
MOV AH,2H
MOV DL,0DH ;PULA LINHA
INT 21H
MOV DL,0AH ;VOLTA O CURSOR
INT 21H
RET
PULA_LINHA ENDP

END MAIN