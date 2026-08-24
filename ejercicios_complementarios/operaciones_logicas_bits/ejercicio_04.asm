.data

numero: .word 0
result: .word 0

.text
main:
	lw $t0, numero
	
	li $t1, 0 # Mascara

	li $t2, 0 # Poss par
	
	li $t6, 32 #Limite 
loop:
	
	li $t3, 1
	sllv $t3, $t3, $t2
	or $t1, $t1, $t3
	
	addi $t2, $t2, 2
	
	bne $t6, $t2, loop
	
fin: 
	xor $t0, $t0, $t1 # aplicamos la mascara creada en $t0
	sw $t0, result