.data
vector: .word 1, 0, -5, 0, 2, 0
res: .word 0 # Almacenamos la cuenta

.text
main:
	la $t0, vector
	li $t1, 6 # Contador de vueltas (vector tiene 6 elementos)
	li $t2, 0 # Contador de ceros (acumulador)

bucle:
 	lw $t3, 0($t0)
 	bnez $t3, siguiente # Si t3 es distinto de cero, salta a 'siguiente'
 	addi $t2, $t2, 1 # Si no saltó, es cero. Sumamos.
 	
 	
siguiente: 
	addi $t0, $t0, 4 # Vamos al siguiente numero del vector
	addi $t1, $t1, -1 #restamos uno al contador
	bnez $t1, bucle # Si el contador aun no es 0 quedan vueltas y volvemos al bucle
	
	sw $t2, res # Sino guardamos el contador de ceros en res
	
	