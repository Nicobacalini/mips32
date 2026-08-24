.data

matriz: .word 1,2,3,4,5,6,7,8,9
cant: .word 3
R: .asciiz "La suma es: "
.text

main:
	la $a0, matriz
	li $a1, 3    # filas
	li $a2, 3    # columnas
	
	jal summat
	
	move $t9, $v0

	li $v0, 4
	la $a0, R
	syscall
	li $v0, 1
	move $a0, $t9
	syscall

li $v0, 10
syscall
summat:
    li $t0, 0        # i = 0
    li $t1, 0        # suma = 0
    move $t2, $a0    # puntero

loop_filas:
    bge $t0, $a1, fin_mat
    li $t3, 0        # j = 0

loop_cols:
    bge $t3, $a2, sig_fila
    # cargar elemento, sumar, avanzar puntero, j++
    lw $t4, 0($t2)
    add $t1, $t1, $t4
    addi $t3, $t3, 1
    addi $t2, $t2, 4
    j loop_cols

sig_fila:
    addi $t0, $t0, 1
    j loop_filas

fin_mat:
    move $v0, $t1
    jr $ra
	
	
	
	
	
	