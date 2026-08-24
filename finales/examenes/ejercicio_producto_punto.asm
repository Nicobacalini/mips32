.data
vector1: .word 3,2,5,1
vector2: .word 2,4,1,3
vec_temp:   .word 0, 0, 0, 0
dimencion: .word 4


.text
main: 
	la $a0, vector1
	la $a1, vector2
	lw $a2, dimencion
	
	jal dotProduct
	
	move $a0, $v0      
	li   $v0, 1          # Syscall para imprimir entero
	syscall
	

	li   $v0, 10
	syscall

dotProduct:
    addi $sp, $sp, -20
    sw   $ra, 0($sp)
    sw   $a0, 4($sp)        # Guardamos vecU
    sw   $a1, 8($sp)        # Guardamos vecV
    sw   $a2, 12($sp)       # Guardamos la Dimension
    
    # Llamar multPairs
    la   $a3, vec_temp      # $a3 = Direccion del vector donde guardar
    jal  multPairs
    
    # Preparar argumentos para sumVec
    lw   $a1, 12($sp)       # $a1 = Recuperamos la dimension
    
    la   $a0, vec_temp      # $a0 = Cargamos la DIRECCION del vector temporal
    
    jal  sumVec
    
    # Ya tenemos el resultado en $v0 gracias a sumVec
    lw   $ra, 0($sp)
    addi $sp, $sp, 20
    jr   $ra
    
multPairs:
	li $t0, 0 	#contador i
	
loop_mult:
	beq $t0, $a2, fin_mult
	
	lw $t1, 0($a0)
	lw $t2, 0($a1)
	
	mul $t3, $t1, $t2
	
	sw $t3, 0($a3)
	
	addi $a0, $a0,4
	addi $a1, $a1,4
	addi $a3, $a3,4
	add $t0, $t0, 1
	
	j loop_mult
	
fin_mult: 
	jr $ra
	

sumVec:
	li $t0, 0 #contador
	li $v0, 0
loop_sumVec:
	beq $t0, $a1, fin_mult
	
	lw $t1, 0($a0)
	
	add $v0, $v0, $t1
	
	addi $a0, $a0,4
	addi $t0, $t0, 1
	j    loop_sumVec
fin_sumVec: 
	jr $ra
	
	