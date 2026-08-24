.data
matriz: .word 1,2,3,4,5,6,7,2,1
R_F: .asciiz "La fina con mayor suma es:"
R_S: .asciiz "\nCon suma:"

.text
main:
	la $a0, matriz
	li $a1, 3
	
	jal maxfila
	
	move $t8, $v0
	move $t9, $v1
	
	li $v0, 4
	la $a0, R_F
	syscall
	li $v0, 1
	move $a0, $t8
	syscall
	
	li $v0, 4
	la $a0, R_S
	syscall
	li $v0, 1
	move $a0, $t9
	syscall
	
	li $v0, 10 
	syscall
	
maxfila:
	li $t0, 0 # fila actual
	li $t1, 0 # max_fila
	li $t2, 0 # max_suma
	
	
loop_fila:
	bge $t0, $a1, terminar
	li $t3 , 0 # suma fila
	li $t4, 0  # columna

loop_cols:
	bge $t4, $a1, fin_fila
	lw $t6 ,0($a0)
	add $t3, $t3, $t6
	addi $a0, $a0, 4
	addi $t4, $t4, 1
	j loop_cols

fin_fila:
	ble $t3, $t2, es_menor
	move $t2, $t3
	move $t1, $t0
	
es_menor:
	addi $t0, $t0, 1
	j loop_fila
	
terminar:
	move $v0, $t1
	move $v1, $t2
	jr $ra