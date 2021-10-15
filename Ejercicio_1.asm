
	LIST p=16F876A
	INCLUDE "p16f876a.inc"
	__CONFIG _XT_OSC & _WDT_OFF & _LVP_OFF

;--------------variables

;--------------redireccionamiento
	ORG	0
	GOTO	INICIO
	ORG	4
	GOTO	ISR
	ORG	5
	
;--------------inicio e inicialización de variables
INICIO

;--------------main
MAIN
	CLRF	FSR
	CLRF	INDF

	;metemos algunos datos para verlos en la memoria
	;Banco 0	0x20 - 0x7F
	
	MOVLW	0X3A		 
	MOVWF	0x30	
	MOVLW	0X3C
	MOVWF	0X35
	MOVLW	0X2D
	MOVWF	0X7F	

	;Banco 1	0xA0-0xEF

	BSF		STATUS,RP0		;me meto en el banco 1
	
	MOVLW	0X3E		 
	MOVWF	0xA0	
	MOVLW	0X2F
	MOVWF	0XA7
	MOVLW	0X1A
	MOVWF	0XEF

	BCF		STATUS,RP0		;me salgo del banco 1
	

	MOVLW	0x2F			;inicio FSR en la posicion anterior a la 0x30
	MOVWF	FSR

BUCLE
	INCF	FSR,1
	CLRF	INDF

	MOVFW	FSR
	SUBLW	0X7F

	BTFSS	STATUS,Z
	GOTO	BUCLE	
	
	BSF		STATUS,RP0
	MOVLW	0X9F
	MOVWF	FSR
	
BUCLE2
	INCF	FSR,1
	CLRF	INDF

	MOVFW	FSR
	SUBLW	0XEF
	BTFSS	STATUS,Z
	GOTO	BUCLE2
	GOTO	MAIN

;--------------subrutinas
ISR
RETFIE

;--------------final
END