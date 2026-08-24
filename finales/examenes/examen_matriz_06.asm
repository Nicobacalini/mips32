.data

matriz: .word 2,4,5,7,10,10,3,1,1,3,5,7

resultado: .word 0,0,0

filas: .word 3
cols: .word 4


.text
main:
	la $a0, matriz
	la $a1, resultado
	lw $a2, filas
	lw $a3, cols
	
	jal procesarMatriz
	
	li $v0, 10
	syscall
	
procesarMatriz:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $t0, 0  #contador i (filas)

loop_matriz:
	beq $t0, $a2, fin_jefe # Comparar con FILAS ($a2), no con $a3
	
	addi $sp, $sp, -16
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	sw $a3, 12($sp)
	
	move $a1, $a3	# Pasar el número de COLUMNAS como limite para el obrero
	
	jal sumarPares
	
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	lw $a3, 12($sp)
	addi $sp, $sp, 16
	
	sw $v0, 0($a1)
	
	mul $t9, $a3, 4
	add $a0, $a0, $t9
	
	addi $a1, $a1, 4
	addi $t0, $t0, 1
	
	j loop_matriz

fin_jefe:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
sumarPares:
    li   $v0, 0             # Acumulador de Suma
    li   $t1, 0             # Contador de columnas (j)

loop_obrero:
    # Condicion de corte del obrero
    beq $t1, $a1, fin_obrero
    
    # Cargar el numero actual
    lw   $t2, 0($a0)
    

    # Aplicar mascara 'andi' al numero ($t2) con 1 y guardarlo en un temporal (ej: $t3)
    andi $t3, $t2, 1
    
    # Si el resultado es distinto de cero (bnez), es IMPAR -> saltar a "siguiente_numero"
    bnez $t3, siguiente_numero
    
    # Si no salto, es PAR -> Lo sumamos al acumulador ($v0)
    add  $v0, $v0, $t2

siguiente_numero:
    # Avanzar el puntero de la matriz ($a0) un casillero y el contador
    addi $a0, $a0,4
    addi $t1, $t1, 1
    j    loop_obrero

fin_obrero:
    jr   $ra
	
	
