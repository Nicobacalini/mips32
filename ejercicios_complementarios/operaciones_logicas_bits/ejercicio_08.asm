.data
numero:	.word 0x12345678
resultado:	.word 0

.text
main:
    lw   $t0, numero      # $t0 = ORIGINAL 
    move $t1, $t0         # $t1 = COPIA
    li   $t2, 0           # $t2 = INVERTIDO
    li   $t3, 32          # Contador: 32 bits

loop:
    # Si el contador llega a 0, terminamos de invertir
    beqz $t3, comparar
    
    # Abrir hueco a la derecha en el Invertido
    sll  $t2, $t2, 1
    
    # Agarrar el último bit de la Copia
    andi $t4, $t1, 1
    
    # Pegar ese bit en el hueco libre del Invertido
    or   $t2, $t2, $t4
    
    # Tirar el bit usado de la Copia
    srl  $t1, $t1, 1      
    
    # Restar contador
    subi $t3, $t3, 1      
    
    j    loop

comparar:
    # $t0 tiene el Original
    # $t2 tiene el Invertido
    beq  $t0, $t2, es_palindromo  # ¿Son iguales?
    
    # --- NO LO ES ---
    j    fin

es_palindromo:
    li   $t5, 1    
    sw   $t5, resultado

fin:
    li   $v0, 10
    syscall