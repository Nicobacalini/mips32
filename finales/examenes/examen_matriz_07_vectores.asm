.data
rutina: .word 30,50,60,20,45,90
dias: .word 6
meta_min: .word 45
resultado:.word 0

.text 
main:
	la $a0, rutina		#v vector a analizar
	lw $a1, dias		# Cantidad de num vector
	la $a2, resultado	# resultado
	lw $s0, meta_min	# min de minitos
	
	jal analizarSemana
	
	li $v0, 10
	syscall
	
analizarSemana:
	addi $sp, $sp, -4
	lw $ra, 0($sp)
	
	li $t0, 0		# contador de dias
	li $s1, 0 		# acumulador total de dias validos
	
loop_analizar:
	beq $t0, $a1, fin_analizar
	
	addi $sp, $sp, -16
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	sw $t0, 12($sp)
	
	jal evaluarDia
	
	lw   $a0, 0($sp)
    lw   $a1, 4($sp)
    lw   $a2, 8($sp)
    lw   $t0, 12($sp)
    addi $sp, $sp, 16
    
    
    # sumamos y avazamos el puntero
    add $s1, $s1, $v0
    addi $a0, $a0, 4
    
    # Avanzamos contador
    addi $t0, $t0, 1
    j    loop_analizar
    
fin_analizar:    
    sw $s1, 0($a2)
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra
evaluarDia:
    # Cargar los minutos del dia actual
    lw   $t1, 0($a0)
    
    blt $t1, $s0, no_cumplio
    # Si no salto, CUMPLIo. Devolvemos 1 en $v0.
    li   $v0, 1
    jr   $ra
    
no_cumplio:   
	li   $v0, 0
    jr   $ra