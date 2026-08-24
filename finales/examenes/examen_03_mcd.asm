.data
mensajeA: .asciiz "Introduzca A: "
mensajeB: .asciiz "Introduzca B: "
mensajeR: .asciiz "El MCD es: "
salto: .asciiz "\n"
.text
main:
    jal pedirNum        # Llama a pedir los números (deja A en $a0 y B en $a1)
    
    move $s0, $a0       # Guardamos los originales por si acaso
    move $s1, $a1
    
    jal euclides        # Calcula el MCD (el resultado vuelve en $v0)
    
    move $t9, $v0       # Guardamos el resultado en un temporal
    
    # Imprimir el mensaje de resultado
    li $v0, 4
    la $a0, mensajeR
    syscall
    
    # Imprimir el número (MCD)
    li $v0, 1
    move $a0, $t9
    syscall
    
    li $v0, 4
    la $a0, salto
    syscall
    
    j main 

# --- Subrutina pedirNum ---
pedirNum:
    # Pedir A
    li $v0, 4
    la $a0, mensajeA
    syscall
    li $v0, 5
    syscall
    blez $v0, fin
    move $t0, $v0       # Guardar A temporalmente
    
    # Pedir B
    li $v0, 4
    la $a0, mensajeB
    syscall
    li $v0, 5
    syscall
    blez $v0, fin
    move $t1, $v0       # Guardar B temporalmente
    
    # Preparar registros de argumento para el retorno
    move $a0, $t0
    move $a1, $t1
    jr $ra

# --- Subrutina euclides ---
euclides:
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $s0, 4($sp)
    sw $s1, 8($sp)

    move $s0, $a0       # S0 es A
    move $s1, $a1       # S1 es B
	
bucle_euclides:
    beq $s1, $zero, fin_euclides  

    move $a0, $s0       
    move $a1, $s1       
    jal modulo          # Llama a la otra subrutina
    
    move $s0, $s1       # A = B
    move $s1, $v0       # B = resto
    
    j bucle_euclides

fin_euclides:
    move $v0, $s0       # El MCD queda en $v0
    lw $ra, 0($sp)
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    addi $sp, $sp, 12
    jr $ra

# --- Subrutina modulo ---
modulo:
    div $a0, $a1        
    mfhi $v0            
    jr $ra              

fin:
    li $v0, 10          
    syscall