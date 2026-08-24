.data

matrizA: .word 2,3,7,1
matrizB: .word 0,0,0,0

orden: .word 2
escalar: .word 3

.text
main:
	la $a0, matrizA
    lw $a1, orden
    lw $a2, escalar
    la $a3, matrizB

	
	jal dotMat
	
	li $v0, 10
    syscall
dotMat:
	# Abrimos espacio para RA
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	li   $t9, 0

loop_mat:
	beq $t9, $a1, end_mat
	
	# Guardamos contexto (Punteros y contador)
	addi $sp, $sp, -12
	sw $a0,0($sp)
	sw $a3,4($sp)
	sw $t9,8($sp)
	
	# Llamamos a dotVec
	jal dotVec
	
	
	# Recuperamos lo guardado
	lw   $a0, 0($sp)
    lw   $a3, 4($sp)
    lw   $t9, 8($sp)

	addi $sp, $sp, 12 
	
	# Calculamos salto a la SIGUIENTE fila
	mul $t8, $a1, 4
	add  $a0, $a0, $t8  # Puntero A salta a la siguiente fila
    add  $a3, $a3, $t8  # Puntero B salta a la siguiente fila
    
    addi $t9, $t9, 1    # j++
    j    loop_mat
    
end_mat:
    lw   $ra, 0($sp)    # Recuperamos el boleto de vuelta a main
    addi $sp, $sp, 4    # Devolvemos el espacio de la pila
    
    jr   $ra            # Volvemos a main
    
    
dotVec:
	li $t0, 0
	
loop_vec:
	beq $t0, $a1, end_vec
	lw  $t1, 0($a0)
	mul $t1, $t1, $a2
	sw  $t1, 0($a3)
	
	# Avanzo
	addi $a0, $a0, 4
	addi $a3, $a3, 4
	addi $t0, $t0, 1
	j loop_vec

end_vec:
	jr $ra	
	
