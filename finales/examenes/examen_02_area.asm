.data

mensajeA: .asciiz "Ingrese A: "
mensajeB: .asciiz "Ingrese B: "
mensajeC: .asciiz "Ingrese C: "
resultado_msg: .asciiz "El area al cuadrado es: "

.text
main:
	
	# Pedir A
	li $v0, 4 			# Codigo syscall para imprimir string
	la $a0, mensajeA 	# Cargar la diraccion del mensaje a imprimir
	syscall
	li $v0, 5			# Codigo syscall para leer entero
	syscall
	# Comprobaciones
	blez $v0, fin
	move $t0, $v0
	
	# Pedir B
	li $v0, 4 			# Codigo syscall para imprimir string
	la $a0, mensajeB 	# Cargar la diraccion del mensaje a imprimir
	syscall
	li $v0, 5			# Codigo syscall para leer entero
	syscall
	# Comprobaciones
	blez $v0, fin
	move $t1, $v0
	
	# Pedir C
	li $v0, 4 			# Codigo syscall para imprimir string
	la $a0, mensajeC 	# Cargar la diraccion del mensaje a imprimir
	syscall
	li $v0, 5			# Codigo syscall para leer entero
	syscall
	# Comprobaciones
	blez $v0, fin
	move $t2, $v0
	
	
	# Preparar argumentos y llamar
	move $a0, $t0
	move $a1, $t1
	move $a2, $t2
	jal areasq
	
	# Mostrar el resultado y salir
	move $t9, $v0         # Guardar resultado del area
    li $v0, 4
    la $a0, resultado_msg
    syscall
    
    li $v0, 1             # Imprimir el entero resultante
    move $a0, $t9
    syscall

    j fin

areasq:
	addi $sp, $sp, -16
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	
	jal semip
	
	move $t4, $v0
	
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	
	sub $t0, $t4, $a0
	sub $t1, $t4, $a1
	sub $t2, $t4, $a2
	
	li $v0, 1
	
	# Multiplicacion progresiva: s * (s-a) * (s-b) * (s-c)
    mul $v0, $t4, $t0     # $v0 = s * (s-a)
    mul $v0, $v0, $t1     # $v0 = result * (s-b)
    mul $v0, $v0, $t2     # $v0 = result * (s-c)
	
	lw $ra, 0($sp)
    addi $sp, $sp, 16
    jr $ra

semip:
	li $v0, 0
	add $v0, $v0, $a0
	add $v0, $v0, $a1
	add $v0, $v0, $a2
	
	li $t0, 2
	div $v0, $v0, $t0
	mflo $v0 
	
	jr $ra  
	
fin:
    li $v0, 10            # Terminar programa correctamente
    syscall
