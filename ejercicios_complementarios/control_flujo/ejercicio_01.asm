.data

vector: .word 1,2,3,4,20
size: .word 5
.text
main:
	la $t0, vector
	li $t1, 0 # contador
	lw $t2, size
	li $t3, 0 #maximo
	
loop:
	beq  $t1, $t2, end  # Si contador == size, terminamos
	lw $t4, 0($t0) # carga elemento actual
	
	# Si el actual ($t4) es mayor que el maximo ($t3), vamos a actualizar.
	bgt  $t4, $t3, actualizar_max
	
	j avanzar
	
actualizar_max:
	move $t3, $t4


avanzar:
	addi $t0, $t0, 4    # Mover puntero al siguiente word
    addi $t1, $t1, 1    # Sumar 1 al contador
    j    loop
    
end:
    li $v0, 10
    syscall
	