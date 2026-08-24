.data
vector: .word 3, 5, 2, 4, 6
R_produc: .asciiz "El producto interno es: "
R_min: .asciiz "\nEl minimo es: "

.text

main:
	la $a0, vector
	li $a1, 5
	
	jal prodvec
	
	move $t8, $v0
	
	jal minvec
	
	move $t9, $v0
	
	li $v0, 4
	la $a0, R_produc
	syscall 
	li $v0, 1
	move $a0, $t8
	syscall
	
	li $v0, 4
	la $a0, R_min
	syscall 
	li $v0, 1
	move $a0, $t9
	syscall
	
	
	li $v0, 10     # fin del programa
    syscall
	
prodvec:
	li $t0, 0 #contador i
	li $t1, 1 #contador mul
	move $t2, $a0 # puntero
loop_mul:
	bge $t0, $a1, fin_loop
	
	# Cargamos el elemento a sumar en t3
	lw $t3, 0($t2)
	# Sumamos
	mul $t1, $t1, $t3
	
	
	addi $t2, $t2, 4
	addi $t0, $t0, 1
	
	j loop_mul

minvec:
	li $t0, 0
	lw $t1, 0($a0) # min
	move $t2, $a0
loop_min:
	bge $t0, $a1, fin_loop
	lw $t3, 0($t2)
	
	blt $t3 ,$t1, es_menor
	
	addi $t2, $t2, 4
	addi $t0, $t0, 1
	j loop_min
	
	
es_menor:
	move $t1, $t3
	addi $t2, $t2, 4
	addi $t0, $t0, 1
	j loop_min
	
	
fin_loop:
	move $v0, $t1
	jr $ra
	
	
	
	
	
	
	
	