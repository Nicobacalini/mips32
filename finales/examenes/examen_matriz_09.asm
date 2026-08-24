.data
vectorA: .word 45, 120, 80, 150, 95, 105
umbral: .word 100
long: .word 6
.text
main:
	la $a0, vectorA
	lw $a1, long
	lw $a3,  umbral
	
	
	jal processStats
	




processStats:
    # 1. Armar la mochila (Prologo)
    # [COMPLETAR] Guardar $ra y $a2 (el vector destino, porque sumArray lo va a necesitar)
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $a2, 4($sp)
    
    # 2. Llamar al Obrero 1
    jal extractAbove
    
    # 3. Preparar bandejas para el Obrero 2 (sumArray)
    # extractAbove te dejo la CANTIDAD de elementos en $v0
    # sumArray pide: el vector a sumar en $a0, y la cantidad en $a1
    
    # [COMPLETAR] Pasar la cantidad de elementos ($v0) a la bandeja $a1
    move $a1, $v0
    
    # [COMPLETAR] Recuperar de la mochila el puntero al vector destino y ponerlo directamente en $a0
    lw $a0, 4($sp)
    
    # 4. Llamar al Obrero 2
    jal sumArray
    
    # 5. Desarmar mochila y volver (Epilogo)
    # [COMPLETAR] Recuperar $ra, restaurar la pila y volver al main
    # (El resultado de sumArray ya quedo en $v0, asi que no hay que tocar nada mas)	
    lw $ra, 0($sp)
    addi $sp, $sp, 8
    jr $ra
    
    
    
   
extractAbove:
	li $t0, 0 # contador
	li   $v0, 0
loop_extract:
	beq $t0, $a1, fin_extract
	
	lw $t1, 0($a0)
	
	bgt $t1, $a3, mayor
	
	addi $t0, $t0, 1
	addi $a0, $a0, 4

	j    loop_extract
mayor:
	sw   $t1, 0($a2)	# Guardamos el numero en el vector destino
	addi $a2, $a2, 4	# Avanzamos puntero destino
	addi $v0, $v0, 1	# Contamos que guardamos uno exitosamente
	
	addi $t0, $t0, 1	# Avanzamos puntero origen
	addi $a0, $a0, 4	# Avanzamos contador
	
	j loop_extract

fin_extract:
    jr   $ra


sumaArray:
	li $t0, 0
	li $v0, 0
	
loop_sum:
	beq $t0, $a1, fin_sum
	lw $t1, 0($a0)
	add $v0, $v0, $t1
	
	addi $a0, $a0, 4
	addi $t0, $t0, 1
	j loop_sum
	
fin_sum:
	jr $ra
	

    		
    				
	