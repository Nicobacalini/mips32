.data 
numero: .word 0x12345678
result: .word 0

.text
main:
	lw $t0, numero
	
	srl $t0, $t0, 12
	
	andi $t0,$t0, 0xFF
	
	sw $t0, result
	
	