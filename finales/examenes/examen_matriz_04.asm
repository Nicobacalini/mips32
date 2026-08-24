.data
matriz: .word 10, 15, 20, 10, 5, 2, 8, 10, 20, 20, 10, 0
filas: .word 3
cols: .word 4
max: .word 50
resultado: .word 0,0,0

.text
main:
	la $a0, matriz
	la $a1, resultado
	lw $a2, filas
	lw $a3, cols
	lw $s0, max
	
	jal evaluarRendimiento
	
	li $v0, 10
    syscall
    
evaluarRendimiento:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $t0, 0 			#contador filas
	
loop_Rendimiento:
	beq $t0, $a2, end_filas
	
	addi $sp, $sp, -24
	
	sw	$a0, 0($sp)
	sw	$a1, 4($sp)
	sw	$a2, 8($sp)
	sw	$a3, 12($sp)
	sw	$t0, 16($sp)
	
	# Preparamos argumentos
	
	move $a1, $a3
	jal sumarKills
	
	lw	$a0, 0($sp)
	lw	$a1, 4($sp)
	lw	$a2, 8($sp)
	lw	$a3, 12($sp)
	lw	$t0, 16($sp)
	addi $sp, $sp, 24
	
	
	## mayor que max
	bge  $v0, $s0, clasifica
	
	
	li   $t9, 0
    sw   $t9, 0($a1)
    j    avanzar
    
clasifica:
    li   $t9, 1
    sw   $t9, 0($a1)
avanzar:
    mul  $t9, $a3, 4
    add  $a0, $a0, $t9
    
    # Avanzamos vector de resultados al siguiente espacio
    addi $a1, $a1, 4
    
    # Avanzamos contador y repetimos
    addi $t0, $t0, 1
    j    loop_Rendimiento   
    
end_filas:
    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra
    
sumarKills:
	li $v0, 0	# Acomulador
	li   $t1, 0	# contador colums

loop_kills:
	beq $a1, $t1, fin_obrero
	
	lw $t2, 0($a0)
	
	# sumamos kill actual
	add $v0,$v0, $t2
	
	#siguente
	addi $a0, $a0, 4
	addi $t1, $t1, 1
	j loop_kills

fin_obrero:
    jr   $ra