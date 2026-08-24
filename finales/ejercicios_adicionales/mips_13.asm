.data
vector: .word 4, 9, 2, 7, 1
R_sum: .asciiz "La suma es: "
R_max: .asciiz "\nEl maximo es: "

.text
main:
    la $a0, vector
    li $a1, 5
    jal sumvec
    
    move $t9, $v0  # suma
    move $t8, $v1  # maximo
    
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
    
    li $v0, 10     # fin del programa
    syscall

sumvec:
    li $t0, 0        # i
    li $t1, 0        # suma
    lw $t2, 0($a0)   # max
    move $t3, $a0    # puntero
loop_sumvec:
    bge $t0, $a1, fin_loop
    lw $t4, 0($t3)
    ble $t4, $t2, no_es_mayor
    move $t2, $t4    # actualizar max
no_es_mayor:
    add $t1, $t1, $t4
    addi $t3, $t3, 4
    addi $t0, $t0, 1
    j loop_sumvec
fin_loop:
    move $v0, $t1
    move $v1, $t2
    jr $ra
