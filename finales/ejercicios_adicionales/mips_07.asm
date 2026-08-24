.data
B: .asciiz "Introduzca B:"
H: .asciiz "Introduzca H:"
R: .asciiz "El ICuad es:"

.text
main:
	li $v0 , 4
	la $a0, B
	syscall
	li $v0, 5
	syscall
	blez $v0, fin
	move $t0, $v0
	
	
	li $v0, 4
	la $a0, H
	syscall
	li $v0, 5
	syscall 
	blez $v0, fin
	move $t1, $v0
	
	
	move $a0, $t0
	move $a1, $t1
	
	jal inercq
	
	move $t9, $v0
	
	li $v0, 4
    la $a0, R
    syscall
    li $v0, 1
    move $a0, $t9
    syscall
    j main
	
inercq:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal numiner
	move $t0, $v0
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	
	mul $t2, $t0, $t0
	
	li $t1, 144
	
	div $t2, $t1
	mflo $v0
	
	jr $ra
numiner:
	mul $t1, $a1, $a1
	mul $t1, $t1, $a1
	mul $t1, $t1, $a0
	
	move $v0, $t1

	jr $ra
fin:
	li $v0, 10
	syscall