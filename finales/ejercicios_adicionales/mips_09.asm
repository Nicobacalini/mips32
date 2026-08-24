.data

N1:	.asciiz "ingrese N1:"
N2:	.asciiz "ingrese N2:"
N3:	.asciiz "ingrese N3:"
R:	.asciiz "R::"


.text
main:
	li $v0, 4
	la $a0, N1
	syscall
	li $v0, 5
	syscall
	blez $v0, fin
	move $t0, $v0
	
	li $v0, 4
	la $a0, N2
	syscall
	li $v0, 5
	syscall
	blez $v0, fin
	move $t1, $v0
	
	li $v0, 4
	la $a0, N3
	syscall
	li $v0, 5
	syscall
	blez $v0, fin
	move $t2, $v0
	
	
	
	move $a0, $t0
	move $a1, $t1
	move $a2, $t2
	
	jal promcuadq
	
	move $t9, $v0
	
	li $v0, 4
	la $a0, R
	syscall
	li $v0, 1
	move $a0, $t9
	syscall
	
	j main
	
	

promcuadq:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal sumpond
	move $t0, $v0
	
	li $t1, 4
	div $t0, $t1
	mflo $t0
	
	mul $v0, $t0, $t0
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
sumpond:
	add $t0, $a0, $a1
	
	li $t6, 2
	
	mul $t1, $t6, $a2
	
	add $v0, $t0, $t1
	
	jr $ra
	
fin: 
	li $v0, 10
	syscall
	