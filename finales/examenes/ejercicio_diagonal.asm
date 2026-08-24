.data
matriz:   .word 2, 4, 6, 1, 5, 9, 3, 7, 8
orden:    .word 3
vec_diag: .word 0, 0, 0
suma:     .word 0

msg_diag: .asciiz "La diagonal principal es:\n"
msg_suma: .asciiz "\nLa suma (traza) de la diagonal es: "
espacio:  .asciiz " "

.text
main:
    # Preparar argumentos para getDiag
    la   $a0, matriz
    lw   $a1, orden
    la   $a2, vec_diag
    la   $a3, suma
    jal  getDiag

    # Imprimir texto diagonal
    la   $a0, msg_diag
    li   $v0, 4
    syscall

    # Llamar a outVec para mostrar la diagonal
    la   $a0, vec_diag
    lw   $a1, orden
    jal  outVec

    # Imprimir texto suma
    la   $a0, msg_suma
    li   $v0, 4
    syscall

    # Imprimir el valor de la suma
    lw   $a0, suma
    li   $v0, 1
    syscall

    # Fin del programa
    li   $v0, 10
    syscall

# --------------------------------------------------------
# getDiag (No-leaf)
# $a0: Matriz, $a1: Orden, $a2: Vector, $a3: Puntero Suma
# --------------------------------------------------------
getDiag:
    addi $sp, $sp, -20
    sw   $ra, 0($sp)
    sw   $a0, 4($sp)
    sw   $a1, 8($sp)
    sw   $a2, 12($sp)
    sw   $a3, 16($sp)

    # Calcular salto diagonal: (Orden * 4) + 4
    mul  $t1, $a1, 4
    addi $t1, $t1, 4
    
    li   $t0, 0
    move $t2, $a0
    move $t3, $a2

loop_diag:
    beq  $t0, $a1, fin_extraccion
    
    lw   $t4, 0($t2)         # Leer de matriz
    sw   $t4, 0($t3)         # Guardar en vector
    
    add  $t2, $t2, $t1       # Avanzar matriz
    addi $t3, $t3, 4         # Avanzar vector
    
    addi $t0, $t0, 1
    j    loop_diag

fin_extraccion:
    move $a0, $a2            # Pasar vector a $a0
    jal  sumVec
    
    # Guardar resultado en memoria
    lw   $a3, 16($sp)        # Recuperar puntero suma
    sw   $v0, 0($a3)         # Guardar lo que devolvio sumVec

    # Epilogo
    lw   $ra, 0($sp)
    lw   $a0, 4($sp)
    lw   $a1, 8($sp)
    lw   $a2, 12($sp)
    lw   $a3, 16($sp)
    addi $sp, $sp, 20
    jr   $ra

# --------------------------------------------------------
# sumVec (Leaf)
# $a0: Vector, $a1: Longitud
# Retorna: $v0 (Suma)
# --------------------------------------------------------
sumVec:
    li   $v0, 0
    li   $t0, 0

loop_sum:
    beq  $t0, $a1, fin_sum
    lw   $t1, 0($a0)
    add  $v0, $v0, $t1
    addi $a0, $a0, 4
    addi $t0, $t0, 1
    j    loop_sum

fin_sum:
    jr   $ra

# --------------------------------------------------------
# outVec (Leaf)
# $a0: Vector, $a1: Longitud
# --------------------------------------------------------
outVec:
    move $t0, $a0
    move $t1, $a1
    li   $t2, 0

loop_out:
    beq  $t2, $t1, fin_out
    
    lw   $a0, 0($t0)
    li   $v0, 1
    syscall
    
    la   $a0, espacio
    li   $v0, 4
    syscall
    
    addi $t0, $t0, 4
    addi $t2, $t2, 1
    j    loop_out

fin_out:
    jr   $ra