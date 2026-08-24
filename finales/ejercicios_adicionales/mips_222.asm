.data

matriz: .word 2,4,1,3
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
	
	jal mulMat
	
	la $a0, R
	
	
	jal autmat
	
	li $v0, 10
	syscall
	
	
mulMat:
	li $t0, 0
	
loop_mulMat:
	bge $t0, $a1, fin_loop_mulMat
	
	
	sw $ra, -20($sp)
	sw $a0, -16($sp)
	sw $a1, -12($sp)
	sw $a2, -8($sp)
	sw $a3, -4($sp)
	addi $sp, $sp, -20
	
	mul $t4, $t0, $a1
	sll $t4, $t4, 2
	
	add $t1, $a0, $t4
	add $t2, $a3, $t4
	
	move $a0, $t1
	move $a3, $t2
	
	jal mulVec
	
	
	addi $sp, $sp, 20
	lw $ra, -20($sp)
	lw $a0, -16($sp)
	lw $a1, -12($sp)
	lw $a2, -8($sp)
	lw $a3, -4($sp)
	
	
	addi $t0, $t0, 1
	
	j loop_mulMat
mulVec:
	li $t5, 0
	
loop_mulVec:
	bge $t5, $a1, fin_mulVec
	
	lw $t6, 0($a0)
	mul $t7, $t6, $a2
	
	sw $t7, 0($a3)
	addi $t5, $t5, 1
	addi $a0, $a0, 4
	addi $a3, $a3, 4
	
	j loop_mulVec

fin_mulVec:
	jr $ra
	
fin_loop_mulMat:
	jr $ra
	
	
autmat:
	li $t0, 0
	move $t1, $a0
loop_autmat:
	bge $t0, $a1, fin_loop_autmat
	li $t2, 0
loop_J:
	bge $t2, $a1, fin_loop_J
	lw $t3, 0($t1)
	li $v0, 1
	move $a0, $t3
	syscall
	li $v0, 4
	la $a0, espacio
	syscall
	addi $t2, $t2, 1
	addi $t1, $t1, 4
	j loop_J

fin_loop_J:
	li $v0, 4
	la $a0, nueva_l
	syscall
	addi $t0, $t0, 1
	j 	loop_autmat
fin_loop_autmat:
	jr $ra
	
	