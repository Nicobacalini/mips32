.data
mensajeN: .asciiz "\nIntroduzca N: "
mensajeD: .asciiz "Introduzca D: "
resultado: .asciiz "La suma de los multiplos es: "

.text
main:
    # Leer N
    li $v0, 4
    la $a0, mensajeN
    syscall
    li $v0, 5
    syscall
    
    blez $v0, fin        # Si N <= 0, terminar
    move $s0, $v0        # Guardar N temporalmente en $s0
    
    # Leer D
    li $v0, 4
    la $a0, mensajeD
    syscall
    li $v0, 5
    syscall
    
    blez $v0, fin        # Si D <= 0, terminar
    
    move $a1, $v0        # Segundo argumento: D
    move $a0, $s0        # Primer argumento: N
    
    jal sumdiv
    
    move $t9, $v0        # Guardar resultado de la suma
    
    # Imprimir resultado
    li $v0, 4
    la $a0, resultado
    syscall
    li $v0, 1
    move $a0, $t9
    syscall
    
    j main               # Volver a empezar

# --- FUNCIÓN sumdiv ---
sumdiv:
    # Reservar espacio en pila para preservar registros
    addi $sp, $sp, -20
    sw $ra, 0($sp)       # Dirección de retorno a main
    sw $s0, 4($sp)       # i (contador)
    sw $s1, 8($sp)       # acumulador
    sw $s2, 12($sp)      # N
    sw $s3, 16($sp)      # D

    move $s2, $a0        # Copiar N a $s2
    move $s3, $a1        # Copiar D a $s3
    li $s0, 1            # i = 1
    li $s1, 0            # suma = 0
    
sumdiv_loop:
    bgt $s0, $s2, fin_loop  # Si i > N, terminar loop
    
    move $a0, $s0        # Argumento 1: i
    move $a1, $s3        # Argumento 2: D
    jal esMultiplo
    
    beq $v0, $zero, no_sumar
    add $s1, $s1, $s0    # suma += i
    
no_sumar:
    addi $s0, $s0, 1     # i++
    j sumdiv_loop
    
fin_loop:
    move $v0, $s1        # Retornar la suma en $v0
    
    # Restaurar registros de la pila
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s3, 16($sp)
    addi $sp, $sp, 20
    jr $ra               # Regresar a main

# --- FUNCIÓN esMultiplo ---
esMultiplo:
    div $a0, $a1         # i / D
    mfhi $t2             # $t2 = resto
    beq $t2, $zero, es_m
    li $v0, 0            # No es múltiplo
    jr $ra
es_m:
    li $v0, 1            # Es múltiplo
    jr $ra

fin:
    li $v0, 10
    syscall
