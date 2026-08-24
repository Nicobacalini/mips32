.data

N: .asciiz "Ingrese numero:"
R: .asciiz "La suma es:"

.text

main:
	li $v0, 4
	la $a0, N
	syscall
	li $v0, 5
	syscall
	blez $v0, fin
	move $a0, $v0
	
	jal sumimpar
	
	move $t9, $v0
	
	li $v0, 4
	la $a0, R
	syscall
	li $v0, 1
	move $a0, $t9
	syscall
	
	j main
	
sumimpar:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $t0, 1 # contador 
	li $t1, 0 # resultado
	li $t2, 2
loopsum:
	bgt $t0, $a0, fin_loop
	
	
	mul $t3, $t0, $t2
	sub $t3, $t3, 1
	
	add $t1, $t1, $t3
	
	
	addi $t0, $t0, 1
	j loopsum
	
	
fin_loop:
	move $v0, $t1
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
		
fin:
	li $v0, 10
	syscall