.data
matriz:    .word 10, 50, 20, 15, 5, 1, 9, 3, 100, 200, 50, 0
resultado: .word 0, 0, 0      
filas:     .word 3
cols:      .word 4

.text
main:
    la   $a0, matriz
    lw   $a1, filas
    lw   $a2, cols
    la   $a3, resultado
    
    jal  procesarSensores
    
    li   $v0, 10
    syscall

procesarSensores:
    # 1. Prologo
    addi $sp, $sp, -4
    sw   $ra, 0($sp)
    
    li   $t9, 0          # Contador de FILAS (j)

loop_sensores:
    # contador == filas ($a1), terminar
    beq  $t9, $a1, end_procesar

    # Guardar punteros y registros que vamos a perder
    addi $sp, $sp, -20   # Espacio para 5 cosas
    sw   $a0, 0($sp)     # Puntero Matriz actual
    sw   $a1, 4($sp)     # Cantidad Filas (Total)
    sw   $a2, 8($sp)     # Cantidad Cols (Total)
    sw   $a3, 12($sp)    # Puntero Resultado actual
    sw   $t9, 16($sp)    # Contador filas
    
    # PREPARAR ARGUMENTOS PARA EL OBRERO
    # buscarMax espera: $a0 (fila), $a1 (cantidad de elementos)
    # $a0 ya está bien (apunta a la fila actual).
    # Pasamos $a2 (cols) a $a1, porque el obrero recorre columnas.
    move $a1, $a2        
    
    # LLAMADA
    jal  buscarMax       # El resultado volverá en $v0
    
    # VOLVER Y GUARDAR
    # Recuperamos todo
    lw   $a0, 0($sp)
    lw   $a1, 4($sp)
    lw   $a2, 8($sp)
    lw   $a3, 12($sp)
    lw   $t9, 16($sp)
    addi $sp, $sp, 20
    
    # GUARDAR EL RESULTADO ($v0)
    sw   $v0, 0($a3)
    
    # c) AVANZAR PUNTEROS
    #    Matriz: Avanza una fila completa (Cols * 4 bytes)
    mul  $t8, $a2, 4
    add  $a0, $a0, $t8   
    
    #    Resultado: Avanza un casillero (4 bytes)
    addi $a3, $a3, 4     
    
    #    Contador ++
    addi $t9, $t9, 1
    j    loop_sensores

end_procesar:
    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra

buscarMax:
    # $a0 = Puntero inicio fila
    # $a1 = Cantidad elementos (Columnas)
    # Devuelve: $v0 con el valor máximo
    
    # ESTRATEGIA: Asumimos que el PRIMERO es el máximo provisional.
    lw   $v0, 0($a0)     # Max = vector[0]
    
    li   $t0, 1          # Empezamos el contador en 1 (el 0 ya lo vimos)
    addi $a0, $a0, 4     # Avanzamos puntero al segundo elemento

loop_max:
    beq  $t0, $a1, fin_max # Si terminamos la fila, volver
    
    lw   $t1, 0($a0)     # Cargar elemento actual
    
    # Comparar: Si Nuevo <= MaxActual, ignorar.
    ble  $t1, $v0, siguiente_max
    
    # Si es mayor, actualizamos el trono
    move $v0, $t1        # Nuevo Max = Actual

siguiente_max:
    addi $a0, $a0, 4     # Puntero++
    addi $t0, $t0, 1     # Contador++
    j    loop_max

fin_max:
    jr   $ra             # $v0 ya lleva el premio mayor