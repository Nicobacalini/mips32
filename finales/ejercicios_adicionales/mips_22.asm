.data

matriz:   .word 2, 3, 7, 1
matriz_r: .word 0, 0, 0, 0
ingrese:  .asciiz "Ingrese N: "
espacio:  .asciiz " "
nueva_l:  .asciiz "\n"

.text
.globl main

main:
    la $t0, matriz
    li $t1, 2         # orden

    # Solicitar escalar
    li $v0, 4
    la $a0, ingrese
    syscall
    li $v0, 5
    syscall
    move $t2, $v0     # escalar

    # Preparar argumentos para dotMat
    move $a0, $t0     # matriz original
    move $a1, $t1     # orden
    move $a2, $t2     # escalar
    la $a3, matriz_r  # matriz resultado
    jal dotMat

    # Preparar argumentos para outMat
    la $a0, matriz_r
    move $a1, $t1
    jal outMat
    
    # Finalizar el programa (IMPORTANTE)
    li $v0, 10
    syscall

# ---------------------------------------------------------
dotMat:
    li $t0, 0 # filas

loop_dotMat:
    bge $t0, $a1, fin
    
    # Guardar registros en la pila
    addi $sp, $sp, -24
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)
    sw $a2, 12($sp)
    sw $a3, 16($sp)
    
    # Calcular desplazamiento (offset)
    mul $t3, $a1, $t0    # i * N
    sll $t3, $t3, 2      # offset en bytes (* 4)
    
    # Calcular punteros (CORREGIDO)
    add $t4, $a0, $t3    # puntero fila i en matriz original
    add $t5, $a3, $t3    # puntero fila i en matriz_r
    
    # Preparar llamada a dotVec
    move $a0, $t4
    move $a3, $t5
    jal dotVec
    
    # Restaurar registros de la pila
    lw $ra, 0($sp)
    lw $a0, 4($sp)
    lw $a1, 8($sp)
    lw $a2, 12($sp)
    lw $a3, 16($sp)
    addi $sp, $sp, 24    # (CORREGIDO: es positivo al restaurar)
    
    addi $t0, $t0, 1
    
    j loop_dotMat
    
# ---------------------------------------------------------
dotVec:
    li $t1, 0 # colum
    
loop_Vec:
    bge $t1, $a1, fin_loop_Vec
    
    lw $t5, 0($a0)
    mul $t6, $t5, $a2
    sw $t6, 0($a3)
    
    addi $a0, $a0, 4
    addi $a3, $a3, 4
    addi $t1, $t1, 1
    
    j loop_Vec

fin:
    jr $ra

fin_loop_Vec:
    jr $ra

# ---------------------------------------------------------
outMat:
    move $t3, $a0        # Usamos $t3 como puntero para no perder la dir base
    li $t0, 0            # contador de filas
    
loop_filas:
    bge $t0, $a1, fin_out
    li $t1, 0            # contador de columnas
    
loop_cols:
    bge $t1, $a1, fin_fila
    
    # Imprimir número
    lw $t2, 0($t3)       # Leer desde el puntero $t3
    li $v0, 1
    move $a0, $t2        # Ahora sí, es seguro usar $a0 para el syscall
    syscall
    
    # Imprimir espacio (opcional, para que no queden pegados)
    li $v0, 4
    la $a0, espacio
    syscall
    
    addi $t3, $t3, 4     # Avanzar nuestro puntero $t3
    addi $t1, $t1, 1
    j loop_cols
    
fin_fila:
    # imprimir salto de linea
    li $v0, 4
    la $a0, nueva_l
    syscall
    
    addi $t0, $t0, 1
    j loop_filas
    
fin_out:
    jr $ra