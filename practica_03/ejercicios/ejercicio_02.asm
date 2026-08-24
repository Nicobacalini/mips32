.data
V: .word 2,-4,-6
res: .byte 0, 0, 0

.text
main:
	la $t0 , V
	la $t1, res
	li $t2, 3 #contador 
	
bucle: 
	#si es mayor o igual a 0 salta a positivo
	lw $t3, 0($t0)
	bgez $t3, positivo
	
	#caso contrario menor de 0, carga un 0 lo guardamos y salta al final
	li $t4, 0
	sb $t4, 0($t1)
	j avanzar

positivo: 
	li $t4, 1
	sb $t4, 0($t1) #lo guardamos en res

avanzar: 
	addi $t0, $t0 ,4 # $t0 es V (.word por eso 4) y le decimos que avance 4 byte
	addi $t1, $t1, 1 #t1 es res (.byte por eso 1) y le decimos que avance 1 byte
	
	addi $t2, $t2, -1 # decrementamos 1 el contador
	bnez $t2, bucle # si no es cero, volvemos a bucle
	
	