.data
matriz:    .word 45, 80, 55, 30, 20
           .word 10, 15, 20, 25, 40
           .word 90, 85, 50, 60, 70

resultado: .word 0, 0, 0    # Anotamos los Aimstars por partida

filas:     .word 3
cols:      .word 5
meta_hs:   .word 50         # El minimo de HS% para ser Aimstar

.text

main:
	la $a0, matriz
	la $a1, resultado
	lw $a2, filas
	lw $a3, cols
	lw $s0, meta_hs
	
	jal analizarPartidas
	
	li $v0, 10
	syscall
	
analizarPartidas:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $t0, 0 # Contador de partidas (i)
	
loop_jefe:
	beq $t0, $a2, fin_jefe
	
	addi $sp, $sp, -24
	sw $a0 , 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	sw $a3, 12($sp)
	sw $t0, 16($sp)
	
	# Preparar var para contarAimstars, movemos a1, la cantidad de cols
	move $a1, $a3 
	jal contarAimstars
	
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	lw $a3, 12($sp)
	lw $t0, 16($sp)
	addi $sp, $sp, 24
	
	# Cargamos el resultado que nos dio contarAimstars en el vector resultado
	sw $v0, 0($a1)
	
	# Avanzar la matriz
	mul $t9, $a3, 4
	add $a0, $a0, $t9
	
	addi $a1, $a1, 4
	addi $t0, $t0, 1
	j loop_jefe
fin_jefe:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr   $ra	
contarAimstars:
	li $v0, 0		#acumulador de aimstars
	li $t1, 0 		# Contador de jugadores (j)
	
loop_obrero:
	beq $t1, $a1, fin_obrero
	
	# cargamos la cantidad de %hs
	lw $t2, 0($a0)
	
	blt $t2, $s0, siguente_jugador
	
	addi $v0, $v0, 1
	
siguente_jugador:
	addi $t1, $t1, 1
	addi $a0, $a0, 4
	j loop_obrero
	
fin_obrero:
    jr   $ra
	
	