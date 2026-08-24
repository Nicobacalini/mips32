.data
numero: .word 0xF0000000
result: .word 0

.text
main: 
	lw $t0, numero
	
	# primero desplazamos 5 a la izquierda
	
	sll $t1, $t0, 5
	
	# segundo movemos 27 a la derecha
	srl $t2, $t0, 27
	
	or $t0, $t1, $t2
	
	sw $t0, result