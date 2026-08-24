.data
matrizA:    .word 1, 2, 3
            .word 4, 5, 6
            .word 7, 8, 9
matrizB:    .word 0, 0, 0, 0, 0, 0, 0, 0, 0
orden:      .word 3



msg_intro:  .asciiz "La transpuesta resultante es:\n"
espacio:    .asciiz " "
nueva_linea:.asciiz "\n"


.text
main:
	la $a0, matrizA
	lw $a1, orden
	la $a2 matrizB
	
	jal transMat
	
	# Imprimir mensaje
    li   $v0, 4
    la   $a0, msg_intro
    syscall
    
    # Llamar a outMat para mostrar el resultado
    la   $a0, matrizB
    lw   $a1, orden
    jal  outMat
    
    # Fin
    li   $v0, 10
    syscall
    
    
    
transMat:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $t0, 0			# Contador i
	
loop_transMat:
	
	beq $t0, $a1, fin_transMat
	
	addi $sp, $sp, -16
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	sw $t0, 12($sp)
	
	mul $a3, $a1, 4
	
	move $t1, $a1
	move $a1, $a2
	move $a2, $t1
	
	
	jal  copyRow
    
    # Recuperar Contexto
    lw   $a0, 0($sp)
    lw   $a1, 4($sp)
    lw   $a2, 8($sp)
    lw   $t0, 12($sp)
    addi $sp, $sp, 16
    
    add $a0, $a0, $a3
    
    addi $a2, $a2, 4
    
    addi $t0, $t0, 1
    
    j    loop_transMat
    
fin_transMat:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra


copyRow:
	li $t1, 0

loop_copyRow:
	beq $t1, $a2, fin_copyRow
	
	lw $t3, 0($a0)
	
	sw $t3, 0($a1)
	
	addi $a0, $a0, 4
	add $a1, $a1, $a3
	
	addi $t1, $t1, 1
    j loop_copyRow
    
fin_copyRow:
    jr $ra
    
outMat:
    move $t0, $a0           
    move $t1, $a1           
    li   $t2, 0             
    
loop_filas_out:
    beq  $t2, $t1, fin_out
    li   $t3, 0
loop_cols_out:
    beq  $t3, $t1, fin_fila_out
    
    lw   $a0, 0($t0)        
    li   $v0, 1             
    syscall
    
    la   $a0, espacio       
    li   $v0, 4
    syscall
    
    addi $t0, $t0, 4        
    addi $t3, $t3, 1
    j    loop_cols_out

fin_fila_out:
    la   $a0, nueva_linea   
    li   $v0, 4
    syscall
    
    addi $t2, $t2, 1
    j    loop_filas_out

fin_out:
    jr   $ra
