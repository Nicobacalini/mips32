.data
vector:  .word 1, 2, 3, 4, 5, 6, 7, 8, 9
orden:   .word 3
vectorR: .word 0, 0, 0
espacio: .asciiz " "

.text
main:
    la   $a0, vector
    lw   $a1, orden
    la   $a2, vectorR
    
    jal  sumCols
    
    la   $a0, vectorR        # Pasamos el vector resultado a $a0
    lw   $a1, orden          # Pasamos la longitud
    jal  outVec
    

    li   $v0, 10
    syscall
    
sumCols:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)
    
    li   $t3, 0              # contador filas
    
loop_sumCols:
    beq  $t3, $a1, fin_sumCols
    
    addi $sp, $sp, -16       
    sw   $a0, 0($sp)
    sw   $a1, 4($sp)
    sw   $a2, 8($sp)
    sw   $t3, 12($sp)
    
    jal  sumSingleCol
    
    lw   $a0, 0($sp)
    lw   $a1, 4($sp)
    lw   $a2, 8($sp)
    lw   $t3, 12($sp)
    addi $sp, $sp, 16
    
    sw   $v0, 0($a2)
    
    # avanzamos 
    addi $a0, $a0, 4
    addi $a2, $a2, 4
    addi $t3, $t3, 1
    
    j    loop_sumCols

fin_sumCols:
    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra
    
sumSingleCol: 
    li   $t0, 0              # contador i 
    li   $v0, 0              # contador suma / retornar
    mul  $t2, $a1, 4         # t2 = $orden x 4
    
loop_Col:
    beq  $t0, $a1, fin_col
    
    lw   $t1, 0($a0)
    add  $v0, $v0, $t1
    
    # hacemos el salto vertical con el $t2 que calculamos antes
    add  $a0, $a0, $t2
    addi $t0, $t0, 1         # avanzamos 1 el contador
    
    j    loop_Col
    
fin_col:
    jr   $ra
    
outVec:
    move $t2, $a0            # Protegemos el puntero pasandolo a $t2
    li   $t0, 0              # Contador
    
loop_vec:
    beq  $t0, $a1, fin_vec
    
    # Imprimir el numero
    lw   $a0, 0($t2)         # Leemos el numero y lo ponemos DIRECTO en $a0
    li   $v0, 1              # Syscall 1 = Imprimir Entero
    syscall
    
    # Imprimir el espacio separador
    la   $a0, espacio        # Ponemos la direccion del texto " " en $a0
    li   $v0, 4              # Syscall 4 = Imprimir Texto (String)
    syscall
    
    # Avanzar para la proxima vuelta
    addi $t2, $t2, 4         # Avanzamos el puntero de nuestro vector
    addi $t0, $t0, 1         # Sumamos 1 al contador
    
    j    loop_vec            # Pegamos la vuelta

fin_vec:
    jr   $ra                 # El obrero termino y se va a su casa