.data
V: .asciiz "\nIntroduzca V:"
R: .asciiz "\nIntroduzca R:"
Res: .asciiz "\nEl PCuad es:"

.text
main:
	li $v0, 4
	la $a0, V
	syscall
	li $v0,5
	syscall
	blez $v0, fin
	move $t0, $v0
	
	li $v0, 4
	la $a0, R
	syscall
	li $v0, 5
	syscall
	blez $v0, fin
	
	move $a0, $t0
	move $a1, $v0
	
	jal potcoadq
	
	move $t9, $v0
	
	li $v0, 4
	la $a0, Res
	syscall
	li $v0, 1
	move $a0, $t9
	syscall
	j main
	
	
potcoadq:
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal vcuad
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	move $t0, $v0
	
	mul $t1, $t0, $t0
	mul $t2, $a1, $a1
	div $t1, $t2
	mflo $v0
	jr $ra
vcuad:
	mul $v0, $a0, $a0
	jr $ra	
fin:
	li $v0, 10
	syscall