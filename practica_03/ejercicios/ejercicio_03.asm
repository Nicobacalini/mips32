vector: .word 1 , -4, -5, 2
res: .byte 1

.text
main: 
	la $t0, vector
	li $t2, 4 #contador (el vector tiene 4 elementos)

bucle: 
	lw $t3, 0($t0)
	
	bgez $t3, encontre_positivo #si t3 >= 0 es positico y salta a la etiqueta encontre_positivo

	#sino avanzar
	addi $t0, $t0, 4 # voy al siguiente numero del vector (sumar 4 posiciones en memoria)
	addi $t2, $t2, -1 # le resto uno al contador
	bnez $t2 , bucle # vuelve al bucle
	j fin_programa #si llegamos aca significa que bgez salto y el resultado ya es 1
	
encontre_positivo:
	la $t1, res #cargamos la direccion de res en t1
	li $t4, 0 #mete 0 directamente en t4
	sb $t4, 0($t1) # pone lo que esta en t4 (0) en res (falso)
	
fin_programa:
	
	