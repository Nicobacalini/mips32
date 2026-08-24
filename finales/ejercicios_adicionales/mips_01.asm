.data

radio: .asciiz "Ingrese R:"
alt: .asciiz "Ingrese H:"
res: .asciiz "Resultado es:"
.text

main:
	
	li $v0, 4
	la $a0, radio
	syscall
	li $v0, 5
	syscall
	
	move $t0, $v0
	
	li $v0, 4
	la $a0, alt
	syscall 
	li $v0, 5
	syscall
	
	move $a0, $t0
	move $a1, $v0
	
	blez $a0, fin  #r
	blez $a1, fin  #h
	
	jal valcuadq
	
	move $t9, $v0
	
	li $v0, 4
	la $a0, res
	syscall
	li $v0, 1
	move $a0, $t9
	syscall
	j main
	
valcuadq:
	addi $sp, $sp, -4
	sw $ra , 0($sp)
	
	jal basecuad
	
	move $t1, $v0
	
	mul $v0 , $t1, $t1
	
	move $t1, $v0
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
basecuad:
	mul $t0, $a0, $a1
	mul $t0, $t0, $a0
	move $v0, $t0
	jr $ra
	
fin:
    li $v0, 10
    syscall
