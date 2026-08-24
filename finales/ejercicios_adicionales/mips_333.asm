.data

matriz: .word 8,6,10,4
R: .word 0,0,0,0
N: .asciiz "Ingrese N:"
espacio:  .asciiz " "
nueva_l:  .asciiz "\n"

.text
main:
	li $v0, 4
	la $a0, N
	syscall
	li $v0, 5
	syscall 
	
	move $t0, $v0
	
	
	la $a0, matriz
	li $a1, 2
	move $a2, $t0
	la $a3, R
	
	jal divMat
	
	move $a0, $a3
	
	jal autmat
	
	li $v0, 10
	syscall
	
	
	
	
divMat:
	li $t0, 0
	
divMat_loop:
	bge $t0, $a1, fin_divMat_loop
	

	
	
	sw $ra, -20($sp)
	sw $a0, -16($sp)
	sw $a1, -12($sp)
	sw $a2, -8($sp)
	sw $a3, -4($sp)
	addi $sp, $sp, -20
	
	mul $t3, $a1, $t0
	sll $t3, $t3, 2
	
	add $t4, $t3, $a0
	add $t5, $t3, $a3
	
	move $a0, $t4
	move $a3, $t5
	jal divVec
	
	
	addi $sp, $sp, 20
	lw $ra, -20($sp)
	lw $a0, -16($sp)
	lw $a1, -12($sp)
	lw $a2, -8($sp)
	lw $a3, -4($sp)
	
	addi $t0, $t0, 1
	
	j divMat_loop
	
divVec:
	li $t1, 0
loop_divVec:
	bge $t1, $a1, fin_loop_divVec
	lw $t6, 0($a0)
	div $t6, $a2
	mflo $t7
	sw $t7, 0($a3)
	
	addi $t1, $t1, 1
	addi $a3, $a3, 4
	addi $a0, $a0, 4
	j	loop_divVec
	
fin_divMat_loop:
	jr $ra
	
fin_loop_divVec:
	jr $ra
	
	
autmat:
	li $t0, 0
	move $t6, $a0
loop_autmat_i:
	bge $t0, $a1, fin_loop_autmat_i
	li $t1, 0

loop_autmat_j:
	bge $t1, $a1,fin_loop_autmat_j
	lw $t3, 0($t6)
	li $v0, 1
	move $a0, $t3
	syscall
	li $v0, 4
	la $a0, espacio
	syscall
	
	addi $t1, $t1, 1
	addi $t6, $t6, 4
	j loop_autmat_j
fin_loop_autmat_j:
	li $v0, 4
	la $a0, nueva_l
	syscall
	addi $t0, $t0,1
	j loop_autmat_i

fin_loop_autmat_i:
	jr $ra