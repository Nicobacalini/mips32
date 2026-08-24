.data
matrizA:    .word 1, 2, 3, 4
matrizB:    .word 2, 3, 4, 1
orden:      .word 2
matrizR:    .word 0, 0, 0, 0
vec_temp:   .word 0, 0

msg_intro:  .asciiz "El producto resultante es:\n"
espacio:    .asciiz " "
nueva_linea:.asciiz "\n"

.text
main:
    la   $a0, matrizA
    la   $a1, matrizB
    lw   $a2, orden
    la   $a3, matrizR
    jal  multMat
    
    la   $a0, msg_intro
    li   $v0, 4
    syscall
    
    la   $a0, matrizR
    lw   $a1, orden
    jal  outMat
    
    li   $v0, 10
    syscall

# multMat (No-Leaf)
# $a0: Matriz A, $a1: Matriz B, $a2: Orden, $a3: Matriz R
multMat:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)
    
    li   $t0, 0              # i (Filas)
    
loop_filas:
    beq  $t0, $a2, fin_Mat
    li   $t1, 0              # j (Columnas)
    
loop_cols:
    beq  $t1, $a2, fin_fila
    
    # Llamada getColumn
    addi $sp, $sp, -24
    sw   $a0, 0($sp)
    sw   $a1, 4($sp)
    sw   $a2, 8($sp)
    sw   $a3, 12($sp)
    sw   $t0, 16($sp)
    sw   $t1, 20($sp)
    
    move $a0, $a1            # Matriz B
    move $a1, $a2            # Orden
    move $a2, $t1            # Indice columna actual
    la   $a3, vec_temp       
    jal  getColumn
    
    lw   $a0, 0($sp)
    lw   $a1, 4($sp)
    lw   $a2, 8($sp)
    lw   $a3, 12($sp)
    lw   $t0, 16($sp)
    lw   $t1, 20($sp)
    addi $sp, $sp, 24
    
    # Llamada dotProduct
    addi $sp, $sp, -24
    sw   $a0, 0($sp)
    sw   $a1, 4($sp)
    sw   $a2, 8($sp)
    sw   $a3, 12($sp)
    sw   $t0, 16($sp)
    sw   $t1, 20($sp)
    
    mul  $t2, $a2, 4         
    mul  $t2, $t2, $t0       
    add  $a0, $a0, $t2       # Fila actual de Matriz A
    la   $a1, vec_temp       # Columna de Matriz B
    jal  dotProduct
    
    lw   $a0, 0($sp)
    lw   $a1, 4($sp)
    lw   $a2, 8($sp)
    lw   $a3, 12($sp)
    lw   $t0, 16($sp)
    lw   $t1, 20($sp)
    addi $sp, $sp, 24
    
    # Guardar y avanzar
    sw   $v0, 0($a3)         
    addi $a3, $a3, 4   
    
    addi $t1, $t1, 1         
    j    loop_cols

fin_fila:
    addi $t0, $t0, 1         
    j    loop_filas

fin_Mat:
    lw   $ra, 0($sp)         
    addi $sp, $sp, 4
    jr   $ra

# getColumn (Leaf)
# $a0: Matriz B, $a1: Orden, $a2: Indice, $a3: Destino
getColumn:
    mul  $t1, $a2, 4
    add  $a0, $a0, $t1       # Posicion inicial columna
    
    mul  $t2, $a1, 4         # Stride
    li   $t0, 0              # i
    
loop_Column:
    beq  $t0, $a1, fin_Column
    
    lw   $t4, 0($a0)         
    sw   $t4, 0($a3)         
    
    add  $a0, $a0, $t2       
    addi $a3, $a3, 4         
    
    addi $t0, $t0, 1
    j    loop_Column
    
fin_Column:
    jr   $ra

# dotProduct (Leaf)
# $a0: Vector 1, $a1: Vector 2, $a2: Dimension
dotProduct:
    li   $t0, 0              # i
    li   $v0, 0              # Acumulador
    
loop_dot:
    beq  $t0, $a2, fin_dot
    
    lw   $t3, 0($a0)         
    lw   $t4, 0($a1)         
    
    mul  $t5, $t3, $t4       
    add  $v0, $v0, $t5       
    
    addi $a0, $a0, 4         
    addi $a1, $a1, 4
    addi $t0, $t0, 1
    
    j    loop_dot
    
fin_dot:
    jr   $ra

# outMat (Leaf)
# $a0: Matriz, $a1: Orden
outMat:
    move $t0, $a0            
    move $t1, $a1            
    li   $t2, 0              # i
    
loop_filas_out:
    beq  $t2, $t1, fin_out
    li   $t3, 0              # j
    
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
