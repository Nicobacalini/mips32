.data

matriz: .word 3,7,2,5,8,1,4,6,9
R_sum: .asciiz "La suma es: "
R_max: .asciiz "El max es: "
.text

main:
	la $a0, matriz
	li $a1, 3
	
	jal diagmat
	
	move $t9, $v0
	move $t8, $v1
	
	li $v0, 4
	la $a0, R_sum
	syscall
	li $v0, 1
	move $a0, $t9
	syscall
	
	
	li $v0, 4
	la $a0, R_max
	syscall
	li $v0, 1
	move $a0, $t8
	syscall
	
	
	li $v0, 10
	syscall
diagmat:
    li $t0, 0        # suma
    li $t1, 0        # i
    lw $t3, 0($a0)   # max = primer elemento
    
loop_dia:
    bge $t1, $a1, fin

    # calcular direccion de [i][i]
    mul $t4, $t1, $a1
    add $t4, $t4, $t1
    sll $t4, $t4, 2
    add $t4, $a0, $t4   # direccion = base + offset

    # cargar elemento
    lw $t5, 0($t4)
	

	
    # sumar y comparar maximo
    # ... completá vos estas dos cosas
	add $t0, $t0, $t5
	
	ble $t5, $t3, no_mayor    # si t5 <= t3, saltar
	move $t3, $t5             # actualizar maximo

	
    addi $t1, $t1, 1
    j loop_dia

no_mayor:
addi $t1, $t1, 1
j loop_dia
fin:
    move $v0, $t0
    move $v1, $t3
    jr $ra