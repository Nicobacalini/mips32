
.data
mansajeA: .asciiz "\nIntroduzca A:"
mensajeB: .asciiz "Introduzca B:"
mensajeR: .asciiz "El perimetro es: "


.text

main:

	# Ingresar A
	li $v0, 4
	la $a0, mansajeA
	syscall
	li $v0, 5
	syscall
	# Ver si es 0
	blez $v0, fin
	
	move $t0, $v0
	
	# Ingresar B
	li $v0, 4
	la $a0, mensajeB
	syscall
	li $v0, 5
	syscall
	# Ver si es 0
	blez $v0, fin
	
	
	move $a1, $v0 
	move $a0, $t0
	jal perimq
	
	
	move $t9, $v0
	li $v0, 4
	la $a0, mensajeR
	syscall 
	li $v0, 1
	move $a0, $t9
	syscall
	
	j main


perimq:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal sumados
	
	move $t0, $v0
	
	li $t1, 2
	mul $v0, $t0, $t1
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
sumados:
	add $v0, $a0, $a1
	jr $ra


fin:
    li $v0, 10
    syscall
	