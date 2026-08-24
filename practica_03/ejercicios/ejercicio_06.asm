.data
vector: .word 10, -4, 50, 20, 5
res: .word 0

.text
main:
	la $t0, vector
	li $t1, 5 #contador (vector 5 elementos)
	
	lw $s0, 0($t0) # El primero es el rey
	
	addi $t0, $t0, 4 # Avanzamos el puntero al segundo elemento del vector
	addi $t1, $t1, -1 # Restamos uno al contador
	
bucle:
	lw $t3, 0($t0) # Cargamos el desafiante
	
	ble $t3, $s0, siguente # Si desafiante <= Rey, saltamos (El Rey se queda)
	move $s0, $t3 # Copia los que esta en $t3 en $s0 numero REY
	
	
siguente:
	addi $t0, $t0, 4 # Avanzamos al proximo del vector
	addi $t1, $t1, -1 # Restamos contador
	bnez $t1, bucle # Repetimos el bucle
	
	sw $s0, res # Guardamos al Rey final en memoria