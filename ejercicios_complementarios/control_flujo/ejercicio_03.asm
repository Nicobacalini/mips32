.data

vector: .word 1,2,3,4,5,6,7,8
size: .word 8
objetivo: .word 3
esta: .word 0 
.text

main:
	la $t0, vector
	lw $t1, objetivo
	li $t2, 0 # contador
	lw $t3, size

loop:
	beq $t2, $t3, end
	lw $t6, 0($t0) # actual
	
	beq $t6, $t1, encontrado
	
siguente:
	addi $t2, $t2, 1
	addi $t0, $t0, 4
	j loop
	
encontrado:
	li   $t6, 1
	sw   $t6, esta
	
	
end: 
	li   $v0, 10
    syscall
	
	