.data

numero: .word 5
cantidad: .word 0
pariedad: .word 0

.text
main:
    lw $t0, numero
    li $t1, 0 
    
loop:
	beqz $t0, fin
	andi $t2, $t0, 1 # t2 = $t0 AND 1
					 # Si termina en 1 , $t2=1
	add $t1, $t1, $t2
	srl $t0, $t0, 1 # Empujamos todo a la derecha 1 posicion
	
	j loop
	
fin:

	sw $t1, cantidad
	
	# Calculamos pariedad, (si el contador es impar o par)
	andi $t3, $t1, 1
	
	sw $t3, pariedad