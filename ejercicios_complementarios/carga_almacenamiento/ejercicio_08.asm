.data
array_bytes: .byte 1,0,1,1,0,1,1,0,0,0,1,0,1,1,0,1,1,0,0,0,1,0,1,1,0,1,1,0,0,0,1,0
resultado: .word 0

.text 

main: 
	la $s0, array_bytes
	li $t0, 0	#ACUMULADOR (armamos la palabra)
	li $t1, 0	#CONTADOR (0-32)
	
loop:
	beq $t1,32, fin # si t1 es 32 fin
	
	lb $t2, 0($t1)
	sllv $t3, $t2, $t1 # movemos el byte $t2 la cantidad de veces del contador
	
	#lo pegamos en el acumulador
	or $t0, $t0, $t3
	
	#avanzamos
	addi $s0, $s0, 1 # avanzamos puntero de memoria array_bytes
	addi $t1, $t1,1 # sumamos 1 al contador
	
	j loop
	
fin:
	sw $t0, resultado