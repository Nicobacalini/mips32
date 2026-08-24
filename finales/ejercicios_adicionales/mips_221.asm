.data
D: .asciiz "Ingrese D:"
T: .asciiz "Ingrese T:"
R: .asciiz "El resultado es:"
.text
main:
	li $v0, 4
	la $a0, D
	syscall
	li $v0, 5
	syscall 
	blez $v0, fin
	move $t0, $v0
	
	li $v0, 4
	la $a0, T
	syscall
	li $v0, 5
	syscall
	blez $v0, fin
	
	move $a0, $t0
	move $a1, $v0
	
	jal velcuadq
	
	move $t9, $v0
	
	li $v0, 4
	la $a0, R
	syscall
	li $v0, 1
	move $a0, $t9
	syscall
	j main
	
	
velcuadq:
	
	sw $ra, -4($sp)
	addi $sp, $sp, -4
	
	jal dcuad
	
	move $t0, $v0
	
	mul $t1, $a1, $a1
	
	div $t0, $t1
	
	mflo $v0
	
	addi $sp ,$sp, 4
	lw $ra, -4($sp)
	
	jr $ra
dcuad:
	mul $v0, $a0, $a0
	jr $ra 
fin: 
	li $v0, 10
	syscall