.data
matrizA: .word 1, 2, 3, 4
matrizB: .word 5, 6, 7, 8
matrizC: .word 0, 0, 0, 0   # Resultado esperado: 19, 22, 43, 50

.text 
main:
    la $s0, matrizA
    la $s1, matrizB
    la $s2, matrizC
    
    # Matriz A (Filas)
    lw $t0, 0($s0) 
    lw $t1, 4($s0) 
    lw $t2, 8($s0)
    lw $t3, 12($s0)
    
    # Matriz B (Columnas)
    lw $t4, 0($s1)   
    lw $t5, 4($s1)   
    lw $t6, 8($s1)   
    lw $t7, 12($s1)  
    
    # (1 * 5) + (2 * 7)
    mul $t8, $t0, $t4
    mul $t9, $t1, $t6
    add $s3, $t8, $t9
    sw  $s3, 0($s2)
    
    # (1 * 6) + (2 * 8)
    mul $t8, $t0, $t5
    mul $t9, $t1, $t7
    add $s3, $t8, $t9
    sw  $s3, 4($s2)
    
    # (3 * 5) + (4 * 7)
    mul $t8, $t2, $t4
    mul $t9, $t3, $t6
    add $s3, $t8, $t9
    sw  $s3, 8($s2)
    
    # (3 * 6) + (4 * 8)
    mul $t8, $t2, $t5
    mul $t9, $t3, $t7
    add $s3, $t8, $t9
    sw  $s3, 12($s2)
