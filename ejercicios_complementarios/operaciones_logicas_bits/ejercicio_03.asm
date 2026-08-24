.data
numero: .word 1
result: .word 0

.text
main:
	lw $t0, numero
	
	# Queremos un 1 en las posiciones 3, 7, 15, 20
	
	li $t1, 0 # t1 sera la MASCARA acumulada
	
	
	# POSS 3
	li $t2, 1
	sll $t2, $t2, 3 # Movemos a la poss 3
	or $t1, $t1, $t2 # ponemos el 1 en la poss 3 en la mascara
	
	
	# POSS 7
	
	li $t2, 1 
	sll $t2, $t2, 7
	or $t1, $t1, $t2
	
	# POSS 15
	li $t2, 1
	sll $t2, $t2, 15
	or $t1, $t1, $t2
	
	# POSS 20
	li $t2, 1
	sll $t2, $t2, 20
	or $t1, $t1, $t2
	
	
	or   $t0, $t0, $t1 # aplicamos la mascara creada en $t0
	sw $t0, result
	