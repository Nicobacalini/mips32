.data
ing: .asciiz "ingrese escalar: "
matriz: .word 1, 3, 5, 2
res: 	.word 0, 0, 0, 0
espacio:  .asciiz " "
nueva_l:  .asciiz "\n"
.text
main:
	li $v0, 4
	la $a0, ing
	syscall
	li $v0, 5
	syscall
	move $a2, $v0
	
	
	la $a0, matriz
	li $a1, 2
	la $a3, res
	
	jal addmat
	
	la $a0, res
	
	jal autmat
	
	
	li $v0, 10
    syscall
	

	
addmat:
	li $t0, 0 # contador filas
loop_mat:
	bge $t0, $a1, fin_loop
	
	addi $sp, $sp, -20
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)	
	
	
	mul $t3, $t0, $a1
	sll $t3,$t3, 2
	
	add $t4, $a0, $t3
	add $t5, $a3, $t3
	
	move $a0, $t4
	move $a3, $t5
	
	jal addvec
	
	
	
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	addi $sp, $sp, 20
	
	addi $t0, $t0, 1
	j loop_mat
	
addvec:
	li $t1, 0 # contador cols
	
loop_vec:
	bge $t1, $a1, fin_vec
	
	lw $t6, 0($a0)
	
	add $t7, $t6, $a2
	sw $t7, 0($a3)
	addi $a0, $a0, 4
	addi $a3, $a3, 4
	addi $t1, $t1, 1
	j loop_vec
	
fin_loop: 
	jr $ra
fin_vec:
	jr $ra
	
	
	
autmat:
	move $t0, $a0
	li $t1, 0

loop_autmat:
	bge $t1, $a1, fin_out
	li $t2, 0
 
	
loop_autmatJ:
	bge $t2, $a1, fin_fila
	
	lw $t4, 0($t0)
	li $v0, 1
	move $a0, $t4
	syscall
	li $v0, 4
	la $a0, espacio
	syscall
	addi $t2, $t2, 1
	addi $t0, $t0, 4
	
	j loop_autmatJ
	
fin_fila:
 	li $v0, 4
 	la $a0, nueva_l
 	syscall
 	addi $t1, $t1, 1
 	j loop_autmat
 	
fin_out:
	jr $ra
	
fin:
	li $v0, 10
	syscall
