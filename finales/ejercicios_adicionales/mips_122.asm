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
	
	jal subMat
	
	la $a0, res
	jal outMat
	
	li $v0, 10
    syscall

subMat:
	li $t0, 0
	
loop_subMat:
	bge $t0, $a1, fin_subMat
	
	addi $sp , $sp, -20
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	
	mul $t3, $t0, $a1
	sll $t3, $t3, 2
	
	add $t4, $a0, $t3
	add $t5, $a3, $t3
	
	move $a0, $t4
	move $a3, $t5
	
	jal subVec
	
	
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	addi $sp , $sp, 20
	addi $t0, $t0, 1
	j loop_subMat
	
subVec:
	li $t1, 0

loop_subVec:
	bge $t1, $a1, fin_subVec
	
	lw $t6, 0($a0)
	sub $t7, $t6, $a2
	sw $t7, 0($a3)
	
	addi $a0, $a0, 4
	addi $a3, $a3, 4
	addi $t1, $t1, 1
	j loop_subVec
 
fin_subMat: 
	jr $ra
fin_subVec:
	jr $ra 


outMat:
	li $t0, 0
	move $t6, $a0
loop_outMat:
	bge $t0, $a1, fin_outMat
  	li $t1, 0
loop_outMat_cols:
	bge $t1, $a1, fin_outMat_cols
	lw $t3, 0($t6)
	li $v0, 1
	move $a0, $t3
	syscall
	li $v0, 4
	la $a0, espacio
	syscall
	addi $t1, $t1, 1
	addi $t6, $t6, 4
	j loop_outMat_cols

fin_outMat_cols:
	li $v0, 4
 	la $a0, nueva_l
 	syscall
	addi $t0, $t0, 1
	j loop_outMat
	
fin_outMat:
	jr $ra

	