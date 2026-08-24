.data
# Nodos de la lista (Dato, Puntero al Siguiente)
nodo3: .word 30, 0    
nodo2: .word 15, nodo3   
nodo1: .word 25, nodo2    

resultado: .word 0          # Aca guardamos el total de carreos

meta: .word 20              # Kills necesarias para que sea carreo

.text
main:
    la   $a0, nodo1         # puntero al PRIMER nodo
    la   $a1, resultado     # Puntero al vector de resultado
    lw   $s0, meta          # Guardamos el 20
    
    jal  procesarHistorial
    
    li   $v0, 10
    syscall

procesarHistorial:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)
    
    move $t0, $a0
    li   $s1, 0
    
loop_lista:
    # Condicion de corte
    beqz $t0, fin_lista
    
    # Guardar Contexto 
    addi $sp, $sp, -12
    sw   $a1, 0($sp)
    sw   $t0, 4($sp)
    sw   $s1, 8($sp)
    
    # Preparar Argumentos
    lw   $a0, 0($t0)
    
    # Llamada al Obrero
    jal  esCarreo
    
    # Recuperar Contexto
    lw   $a1, 0($sp)
    lw   $t0, 4($sp)
    lw   $s1, 8($sp)
    addi $sp, $sp, 12
    
    # Sumar al Total
    add  $s1, $s1, $v0
    
    # AVANZAR EN LA LISTA
    lw   $t0, 4($t0)
    
    j    loop_lista

fin_lista:
    # Guardar y Volver
    sw   $s1, 0($a1)
    
    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra

esCarreo:
    # Comparar las Kills ($a0) con la Meta ($s0)
    ble  $a0, $s0, no_carreo
    
    # Si paso de largo, es > 20. Devolvemos 1.
    li   $v0, 1
    jr   $ra
    
no_carreo:
    # Devolvemos 0
    li   $v0, 0
    jr   $ra