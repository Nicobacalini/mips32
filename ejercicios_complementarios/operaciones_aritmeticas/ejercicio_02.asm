.data
celsius: .word 5
fahrenheit: .word 0

.text
main: 
	lw $t0, celsius
	
	li  $t1, 9			# Constate para multiplicar
	mul $t0, $t0, $t1	# Multiplicamos x 9
	
	
	
	li  $t1, 5
	div $t0, $t1 		# Hacemos $t0 / 5
	mflo $t0			# El resultado de la division queda en LO. Lo traemos a $t0
	
	addi $t0, $t0, 32
	
	sw $t0, fahrenheit