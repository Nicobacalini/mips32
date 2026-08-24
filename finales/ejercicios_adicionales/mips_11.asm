.data
N: .asciiz "ingrese N:"
R: .asciiz "El resultado es:"

.text
main:
	li $v0, 4
	la $a0, N
	syscall
	li $v0, 5
	syscall
	blez $v0, fin
	move $a0, $v0
	
	jal sumcuad
	
	move $t9, $v0
	
	li $v0, 4
	la $a0, R
	syscall
	li $v0, 1
	move $a0, $t9
	syscall
	j main
sumcuad:
	addi $sp ,$sp, -4
	sw $ra, 0($sp)
	li $t0, 1 #contador
	li $t2, 0 #acumulador
loop_sum:
	bgt $t0, $a0, fin_loop
	
	mul $t1, $t0, $t0
	
	add $t2, $t1, $t2
	
	addi $t0, $t0, 1
	j loop_sum
	
fin_loop:
	move $v0, $t2
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
fin:
	li $v0, 10
	syscall