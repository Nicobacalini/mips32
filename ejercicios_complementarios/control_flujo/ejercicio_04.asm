.data
vector: .word 5, 4, 3, 2, 1   # El desorden total
size:   .word 5

.text
main:
    la   $s0, vector       # $s0: Dirección base del vector (Fija)
    lw   $s1, size         # $s1: Tamaño (5)
    
    li   $t0, 0            # $t0 = i (Empieza en 0)

# --- BUCLE EXTERNO (El dedo izquierdo) ---
loop_i:
    # Si i llega al final (size - 1), terminamos
    subi $t9, $s1, 1       # Limite es size-1
    beq  $t0, $t9, fin
    
    move $t2, $t0          # Asumimos que el MÍNIMO es el actual (min_idx = i)
    
    addi $t1, $t0, 1       # $t1 = j (Empieza en i + 1)

    # --- BUCLE INTERNO (El explorador) ---
    loop_j:
        beq  $t1, $s1, swap # Si j llega al final, hora de intercambiar
        
        # CALCULAR DIRECCIONES (La parte fea pero necesaria)
        # Necesitamos vector[j] y vector[min]
        
        # 1. Traer vector[j]
        mul  $t5, $t1, 4    # Offset j * 4
        add  $t5, $t5, $s0  # Dirección real
        lw   $t6, 0($t5)    # $t6 = valor de vector[j]
        
        # 2. Traer vector[min]
        mul  $t7, $t2, 4    # Offset min * 4
        add  $t7, $t7, $s0  # Dirección real
        lw   $t8, 0($t7)    # $t8 = valor de vector[min]
        
        # COMPARAR
        # Si vector[j] < vector[min], actualizamos el mínimo
        blt  $t6, $t8, nuevo_min
        
        j    siguiente_j

    nuevo_min:
        move $t2, $t1       # ¡Nuevo récord! min_idx = j
    
    siguiente_j:
        addi $t1, $t1, 1    # j++
        j    loop_j

    # --- HORA DEL INTERCAMBIO (SWAP) ---
    swap:
        # Intercambiamos vector[i] con vector[min_idx]
        
        # Dirección de vector[i]
        mul  $t5, $t0, 4
        add  $t5, $t5, $s0  # Direccion de i
        lw   $k0, 0($t5)    # Valor original de i
        
        # Dirección de vector[min] (ya sabemos que el índice está en $t2)
        mul  $t7, $t2, 4
        add  $t7, $t7, $s0  # Dirección de min
        lw   $k1, 0($t7)    # Valor del mínimo
        
        # ¡El cruce!
        sw   $k1, 0($t5)    # Ponemos el mínimo en la posición i
        sw   $k0, 0($t7)    # Ponemos el viejo valor de i donde estaba el mínimo
        
        # Avanzamos el dedo izquierdo
        addi $t0, $t0, 1    # i++
        j    loop_i

fin:
    li   $v0, 10
    syscall