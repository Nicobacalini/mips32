.data
matriz:    .word 10, 50, 25, 5, 30, 40, 60, 80, 1, 2, 3, 4
resultado: .word 0, 0, 0

filas:     .word 3
cols:      .word 4
umbral:    .word 20

.text
main:
    la $a0, matriz
    la $a1, resultado
    
    lw $a2, filas
    lw $a3, cols
    
    lw $s0, umbral
    
    jal procesarLotes
    
    li $v0, 10
    syscall

# ----------------------------------------------------------------
# PROCESAR LOTES
# Registros tuyos: $a0=Matriz, $a1=Resultado, $a2=Filas, $a3=Cols
# ----------------------------------------------------------------
procesarLotes:
    # Guardar RA
    addi $sp, $sp, -4
    sw   $ra, 0($sp)
    
    li   $t0, 0          # Contador de Filas (i)

loop_Validos:
    beq  $t0, $a2, end_procesar
    
    # Guardar Contexto (Todo lo que el obrero puede romper o movemos)
    addi $sp, $sp, -24   # 6 lugares
    sw   $a0, 0($sp)     # Puntero Matriz
    sw   $a1, 4($sp)     # Puntero Resultado
    sw   $a2, 8($sp)     # Filas
    sw   $a3, 12($sp)    # Cols
    sw   $t0, 16($sp)    # Contador Filas
    
    # --- PREPARAR ARGUMENTOS OBRERO ---
    # El obrero necesita: $a0 (Fila), $a1 (Largo)
    # $a0 ya está bien.
    # $a3 tiene las columnas, se lo pasamos a $a1 para el obrero.
    move $a1, $a3        
    
    jal  contarValidos
    
    # --- VOLVER Y RECUPERAR ---
    lw   $a0, 0($sp)
    lw   $a1, 4($sp)
    lw   $a2, 8($sp)
    lw   $a3, 12($sp)
    lw   $t0, 16($sp)
    addi $sp, $sp, 24

    # Guardar el resultado ($v0) en el vector resultado ($a1)
    sw   $v0, 0($a1)
    
    # --- AVANZAR PUNTEROS ---
    # Avanzar Matriz: Cols ($a3) * 4
    mul  $t9, $a3, 4
    add  $a0, $a0, $t9
    
    # Avanzar Resultado: 4 bytes
    addi $a1, $a1, 4
    
    # Avanzar contador
    addi $t0, $t0, 1
    j    loop_Validos

end_procesar:
    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra


# ----------------------------------------------------------------
# CONTAR VALIDOS (El Obrero)
# Recibe: $a0 (Fila), $a1 (Largo/Cols)
# Usa: $s0 (Umbral)
# ----------------------------------------------------------------
contarValidos:
    li   $v0, 0          # Resultado acumulador
    li   $t1, 0          # Contador columnas (j)

loop_obrero:
    # Usamos $a1 porque ahí le pasamos el largo
    beq  $t1, $a1, fin_obrero
    
    # Usamos $t2 para el valor
    lw   $t2, 0($a0)
    
    # Si Numero ($t2) <= Umbral ($s0)
    ble  $t2, $s0, siguiente
    
    # Si es mayor, sumamos 1
    addi $v0, $v0, 1
    
siguiente:
    addi $a0, $a0, 4     # Avanzar puntero en la fila
    addi $t1, $t1, 1     # Avanzar indice
    j    loop_obrero
    
fin_obrero:
    jr   $ra