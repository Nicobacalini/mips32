.data

N: .asciiz "Ingresar N:"
K: .asciiz "Ingresar M:"
R: .asciiz "El resultado es:"
.text
main:
	li $v0, 4
	la $a0, N
	syscall 
	li $v0, 5
	syscall
	
	blez $v0, fin
	
	move $t0, $v0
	
	li $v0, 4
	la $a0, K
	syscall
	li $v0, 5
	syscall
	blez $v0, fin
	
	move $a0, $t0
	move $a1, $v0
	
	jal summult
	
	move $t9, $v0
	
	li $v0, 4
	la $a0, R
	syscall
	li $v0, 1
	move $a0, $t9
	syscall
	
	j main

summult:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	li $t0, 1 #	M
	li $v0, 0
loop_summ:
	bgt $t0 , $a0, fin_loop
	
	div $t0, $a1
	mfhi $t2
	beqz $t2, es
	j no_es
es:
    add $v0, $v0, $t0
no_es:
    addi $t0, $t0, 1
    j loop_summ
    
fin_loop:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
fin:
	li $v0, 10
	syscall
	