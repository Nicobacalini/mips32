.data

vector:.word 1,2,60,40,70
size: .word 5

.text

main: 
	la $t0, vector
	lw $t1, size
	li $t3, 0 # contador
	li $t4, 50 # mayor
	li $t6, 0 # cuantos mayores hay
	
loop:
	beq  $t3, $t1, end
	
	lw $t5, 0($t0)
	
	bgt $t5, $t4, contar
	
	j avanzar
	
contar: 
	addi $t6, $t6, 1

avanzar:
	addi $t3, $t3, 1
	addi $t0, $t0, 4
	j loop

end:
    li $v0, 10
    syscall