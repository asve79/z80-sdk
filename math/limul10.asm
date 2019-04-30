;multiplies unsigned long int to 10
limul10		; умножение 32-битного беззнакового числа на 10.
; in/out: de = high word of long
; 	  	  hl = low word of long

; x2
		push	af
		push	bc
		add		hl,hl
		ld		b,h
		ld		c,l
		push	de
		exx
		pop		hl
		adc		hl,hl
		ld		b,h
		ld		c,l
		exx
; x4
		add		hl,hl
		exx
		adc		hl,hl
		exx
; x8
		add		hl,hl
		exx
		adc		hl,hl
		exx
; x10
		add		hl,bc
		exx
		adc		hl,bc
		push	hl
		exx
		pop 	de
		pop		bc
		pop		af
		ret
