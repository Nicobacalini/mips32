.data
introducir: .asciiz "Introduzca N:"
resultado: .asciiz "Numero Fibo es: "

.text

main:
	li $v0, 4
	la $a0, introducir
	syscall
	li $v0, 5
	syscall
	
	blez $v0, fin
	
	move $a0, $v0
	
	jal calcfib
	
	# 4. Imprimir el resultado S devuelto en $v0
    move $t9, $v0       # Guardar resultado temporalmente
    
    li $v0, 4
    la $a0, resultado
    syscall
    
    li $v0, 1           # Imprimir entero resultante
    move $a0, $t9
    syscall
	
	j main
	
calcfib:
	addi $sp, $sp, -4
	sw $ra , 0($sp)
	li $t0, 0 #  prev=0
	li $t1, 1 # curr=1
	li $t2, 0 # i=0
	beq $a0, $zero, fin_loop
	
fib_loop:
	beq $t2, $a0, fin_loop
	add $t3, $t0, $t1		#nuevo
	move $t0, $t1
	move $t1, $t3
	addi $t2, $t2, 1
	
	j fib_loop
	
fin_loop:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	move $v0, $t1
	jr $ra
	
fin :
	
	
	
	