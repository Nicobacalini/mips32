.data

numero: .word -1

resultado: .word 0

.text
main:
	lw $t0, numero 
	bgez $t0, guardar
	
	#si es negativo:
	sub $t0, $zero, $t0		# 0 -(-x)
	
	
guardar: sw $t0, resultado