.data

M: .asciiz "Ingrese M:"
V: .asciiz "Ingrese V:"
R: .asciiz "Resultado:"

.text

main:
	li $v0, 4
	la $a0, M
	syscall
	li $v0, 5
	syscall 
	blez $v0, fin
	move $t0, $v0
	
	
	li $v0, 4
	la $a0, V
	syscall
	li $v0, 5
	syscall
	blez $v0, fin 
	move $t1, $v0
	
	move $a0, $t0
	move $a1, $t1
	
	jal eccuadq
	
	
	move $t9, $v0
	
	li $v0, 4
	la $a0, R
	syscall
	li $v0, 1
	move $a0, $t9
	syscall
	j main
	
	
eccuadq:
	addi $sp, $sp , -4
	sw $ra, 0($sp)
	
	jal pmv
	
	move $t0, $v0
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	mul $t1, $t0, $t0
	
	li $t2, 4
	
	div $t1, $t2
	
	mflo $v0	
	
	jr $ra
pmv:
	mul $t0, $a1, $a1
	mul $v0, $t0, $a0
	
	jr $ra
fin:
	li $v0, 10
	syscall