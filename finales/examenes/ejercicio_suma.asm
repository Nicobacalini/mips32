.data

matrizA: .word 2,3
		 .word 5,1

matrizB: .word 1,4
		 .word 2,3
		 
matrizR: .word 0,0,0,0

orden: .word 2


espacio:     .asciiz " "
nueva_linea: .asciiz "\n"


.text

main:
	la $a0, matrizA
	la $a1, matrizB
	la $a3, matrizR
	lw $a2, orden
	
	jal sumMat
	
	la   $a0, matrizR       # a0 pide el puntero a la matriz a imprimir
	lw   $a1, orden         # a1 pide el orden
	jal  outMat
	
	li   $v0, 10
	syscall

	
sumMat:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	li $t0, 0 #contador i
	
loop_sumMat:
	beq $t0, $a2, fin_sumMat
	
	addi $sp, $sp, -20
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	sw $a3, 12($sp)
	sw $t0, 16($sp)
	
	
	
	jal sumVec
	
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
    lw $a3, 12($sp)
    lw $t0, 16($sp)
    addi $sp, $sp, 20
    
    mul $t2, $a2, 4
    add $a0, $a0, $t2
    add $a1, $a1, $t2
    add $a3, $a3, $t2
    
    addi $t0, $t0, 1
    j loop_sumMat


fin_sumMat:
    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra
    
sumVec:
	li $t4, 0

loop_sumVec:
	beq $t4, $a2, fin_sumVec
	
	lw $t5, 0($a0)
	lw $t6, 0($a1)
	
	add $t7, $t5, $t6
	sw $t7, 0($a3)
	
	addi $a0, $a0, 4
	addi $a1, $a1, 4
	addi $a3, $a3, 4
	
	addi $t4, $t4, 1
	j loop_sumVec
	
fin_sumVec:
	jr $ra
	

outMat:
    move $t0, $a0           # $t0 = Puntero caminante de la matriz
    move $t1, $a1           # $t1 = Orden de la matriz
    
    li   $t2, 0             # Contador de FILAS (i)
    
loop_filas_out:
    beq  $t2, $t1, fin_out
    
    li   $t3, 0             # Contador de COLUMNAS (j) (Se reinicia por cada fila)
    
loop_cols_out:
    beq  $t3, $t1, fin_fila_out
    
    # Imprimir el número
    lw   $a0, 0($t0)        # Cargamos el número actual en $a0
    li   $v0, 1             # Codigo syscall para imprimir entero
    syscall
    
    # Imprimir un espacio separador
    la   $a0, espacio       # Cargamos la dirección del string " " en $a0
    li   $v0, 4             # Codigo syscall para imprimir texto
    syscall
    
    # Avanzar al siguiente numero y repetir
    addi $t0, $t0, 4
    addi $t3, $t3, 1
    j    loop_cols_out

fin_fila_out:
    # Imprimir un salto de línea (Enter) al final de la fila
    la   $a0, nueva_linea
    li   $v0, 4
    syscall
    
    addi $t2, $t2, 1        # Sumamos 1 al contador de filas
    j    loop_filas_out

fin_out:
    jr   $ra