;multiplies unsigned long int to 10
limul10		; умножение 32-битного беззнакового числа на 10.
; in/out: de = high word of long
; 	  	  hl = low word of long

; x2
		PUSH		AF
		PUSH		BC
		ADD		HL,HL
		LD		B,H
		LD		C,L
		PUSH		DE
		EXX
		POP		HL
		ADC		HL,HL
		LD		B,H
		LD		C,L
		EXX
; x4
		ADD		HL,HL
		EXX
		ADC		HL,HL
		EXX
; x8
		ADD		HL,HL
		EXX
		ADC		HL,HL
		EXX
; x10
		ADD		HL,BC
		EXX
		ADC		HL,BC
		PUSH		HL
		EXX
		POP 		DE
		POP		BC
		POP		AF
		RET
