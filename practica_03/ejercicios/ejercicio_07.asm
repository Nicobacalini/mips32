.data 
vector: .word 2, 5, 1, 10, 4
n: .word 5

.text
main:
	lw $s1, n # Contador externo

bucle_externo: 
	la $t0, vector # Rastrea el puntero inicio
	li $t1, 0 # Contador de iteraciones internas
	addi $t2, $s1, -1 # t2 es el limine interno
	
bucle_interno:
	lw $t3, 0($t0) # Carga el actual
	lw $t4, 4($t0) # Carga el siguente
	
	bge $t3 , $t4, no_swap # Esta bien ordenados t3 es mayor que t4
	
	sw $t4, 0($t0) # Guarda el valor del vecino (el mayor entre los dos) en la pos actual
	sw $t3, 4($t0) # Guarda el valor del actual (el menor entre lo dos) en la pos del vecino
	
no_swap:
	addi $t0, $t0, 4 # Avanzamos a la siguente posicion 
	addi $t1, $t1, 1 # Sumamos 1 al contador interno i
	
	blt $t1, $t2, bucle_interno # (Seguimos en el bucle si i < N-1)
	
	addi $s1, $s1, -1 # Resta uno en el contador externo
	bgtz $s1, bucle_externo # Si quedan pasadas, repetir desde el inicio
	
	
	
 
	
	