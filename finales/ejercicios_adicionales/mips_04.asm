.data

A: .asciiz "Introduzca A:"
B: .asciiz "Introduzca B:"
H: .asciiz "Introduzca H:"
R: .asciiz "El area cuadrada es:"

.text


main:
	li $v0, 4
	la $a0, A
	syscall
	li $v0, 5
	syscall
	
	beqz $v0, fin
	move $t0, $v0
	
	li $v0, 4
	la $a0, B
	syscall
	li $v0, 5
	syscall
	
	beqz $v0, fin
	
	move $t1, $v0
	
	li $v0,4
	la $a0, H
	syscall
	li $v0, 5
	syscall
	beqz $v0, fin
	
	move $t2, $v0
	
	
	move $a0, $t0
	move $a1, $t1
	move $a2, $t2
	
	
	
	
	jal areacuadq
	
	move $t9, $v0
	
	li $v0, 4
	la $a0, R
	syscall
	li $v0, 1
	move $a0, $t9
	syscall
	
	j main
	


areacuadq:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal prodabh		
	
	li $t0, 4
	move $t1, $v0
	
	mul $t3, $t1, $t1
	div $t3, $t0
	mflo $v0 
	
	
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
prodabh:
	mul $v0, $a0, $a1
	mul $v0, $v0, $a2
	jr $ra		
fin:
	li $v0, 10
	syscall
