.data
mensajeN: .asciiz "Introduzca N:"
mensajeR: .asciiz "La suma es:"

salto: .asciiz "\n"
.text

main:

	li $v0, 4
	la $a0, mensajeN
	syscall
	li $v0, 5
	syscall
	
	blez $v0, fin
	
	move $a0, $v0
	
	jal sumanat
	# 4. Imprimir el resultado S devuelto en $v0
    move $t9, $v0       # Guardar resultado temporalmente
    
    li $v0, 4
    la $a0, mensajeR
    syscall
    
    li $v0, 1           # Imprimir entero resultante
    move $a0, $t9
    syscall
    
    
    li $v0, 4
    la $a0, salto
    syscall
    # 5. Repetir ejecución
    j main              
	
sumanat:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal gauss
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
gauss:
	addi $t0, $a0, 1 # (N+1)
	
	mul $t1, $a0, $t0 # N*(N+1)
	
	li $t2, 2
	
	div $t1, $t2
	
	mflo $v0
	
	jr $ra
	
	
fin:
    li $v0, 10          
    syscall 
	