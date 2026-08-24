.data
A: .asciiz "Introduzca A:"
B: .asciiz "Introduzca B:"
C: .asciiz "Introduzca C:"
R: .asciiz "El volumen cuadrado es:"
.text

main:
	
	li $v0, 4
	la $a0, A
	syscall
	li $v0, 5
	syscall
	beqz $v0,fin
	move $t0, $v0
	
	li $v0, 4
	la $a0, B
	syscall
	li $v0, 5
	syscall
	beqz $v0,fin
	move $t1, $v0
	
	li $v0, 4
	la $a0, C
	syscall
	li $v0, 5
	syscall
	beqz $v0,fin
	move $t2, $v0
	
	
	move $a0, $t0
	move $a1, $t1
	move $a2, $t2
	
	jal vcuadq
	
	
	move $t9, $v0
	
	li $v0, 4
	la $a0, R
	syscall
	li $v0, 1
	move $a0, $t9
	syscall
	j main

vcuadq:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal prodtres

	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	move $t3, $v0
	mul $v0, $t3, $t3
	
	jr $ra 
prodtres:
	mul $t0, $a0, $a1
	mul $t0, $a2, $t0
	
	move $v0, $t0
	
		jr $ra	
fin:
	li $v0, 10
	syscall