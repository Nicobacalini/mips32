.data
string: .asciiz "neuquen"

res: .word 0 # 1 = capicua 0 = no es

.text
main:
	la $t0, string      # Puntero IZQUIERDO (Inicio)
	move $t1, $t0       # Puntero DERECHO (Lo vamos a mover al final)
	
buscar_fin:
	lb $t2, 0($t1) # Cargar la palabra actual
	beqz $t2, retroceder # Es el 0 final? encontramos el fin
	addi $t1, $t1, 1 # Avanza el puntero derecho
	j buscar_fin
	
retroceder:
	addi $t1, $t1, -1 # Retroceder 1 paso (desde el \0 a la 'n')

bucle: 
	bge $t0, $t1, es_capicua # Condicion de salida (Exito)
	
	lb $t3, 0($t0) # Letra Izquierda
	lb $t4, 0($t1) # Letra Derecha
	
	bne $t4, $t3, no_es_capicua
	
	addi $t0, $t0, 1    # Izquierda avanza (+1)
	addi $t1, $t1, -1   # Derecha retrocede (-1)
	
	j bucle
	
es_capicua:
	li $t5, 1
	sw $t5, res
	j fin

no_es_capicua:
	li $t5, 0
	sw $t5, res

fin: 
	
	  
	
