.data
X1:.asciiz "Introduzca X1:"
Y1:.asciiz "Introduzca Y1:"
X2:.asciiz "Introduzca X2:"
Y2:.asciiz "Introduzca Y2:"
R: .asciiz "La distancia cuadrada es:"


.text
main:
	li $v0, 4
	la $a0, X1
	syscall
	li $v0, 5
	syscall
	beqz $v0, fin
	move $t0, $v0
	
	li $v0,4
	la $a0, Y1
	syscall
	li $v0, 5
	syscall
	beqz $v0, fin
	move $t1, $v0
	
	
	li $v0, 4
	la $a0, X2
	syscall
	li $v0, 5
	syscall
	beqz $v0, fin
	move $t2, $v0
	
	li $v0, 4
	la $a0, Y2
	syscall
	li $v0, 5
	syscall
	beqz $v0, fin
	move $t3, $v0
	
	
	move $s0, $t0	#x1
	move $s1, $t1	#y1
	move $s2, $t2	#x2
	move $s3, $t3	#y2
	
	jal distcuadq
	
	move $t9, $v0
	
	li $v0, 4
	la $a0, R
	syscall
	li $v0, 1
	move $a0, $t9
	syscall
	j main


distcuadq:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal sumcuad
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
	
# DX*DX + DY*DY
sumcuad:

	sub $t0, $s2, $s0    # $t0 = DX
    sub $t1, $s3, $s1    # $t1 = DY
    
	mul $t0, $t0, $t0
	mul $t1, $t1, $t1
	
	add $v0, $t0, $t1
	
	jr $ra
			
fin:
	li $v0, 10
	syscall