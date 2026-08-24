.data
N: .word 47
vector: .space 200

.text
main:
	la $t0, vector
	lw $t1, N # contador
	
	li $t2, 0
	li $t3, 1
	
	#si es menor a 0
	blez $t1, fin
	
	sw $t2, 0($t0)
	addi $t0, $t0, 4
	subi $t1, $t1, 1 # restamos 1 a N
	
bucle: 
	blez $t1, fin # si no queda mas elemento terminar
	sw $t3, 0($t0)
	
	add $t4, $t2, $t3
	move $t2, $t3 # el anterior se combierte en penultimo
	move $t3, $t4 # el nuevo resultado se comvierte en ultimo
	
	addi $t0 ,$t0, 4
	subi $t1, $t1, 1 # restamos uno en contador
	j bucle

fin:
	
	
	