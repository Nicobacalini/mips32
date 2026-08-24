.data
data1: .word 10 #inicio rango 1
data2: .word 20 #final rango 1
data3: .word 50 #inicio rango 2
data4: .word 60 #final rango 2
num_prob: .word 25

res: .byte 0 #resultado lo iguales a 0
.text
main:
	lw $t1, data1
	lw $t2, data2
	lw $t3, data3
	lw $t4, data4
	lw $t5, num_prob #numero a comprobar
	
	# probamos el primero rango de (10 a 20)
	blt $t5, $t1, probar_rango_2 # Si es menor que el minimo, falló el Rango 1. Vamos a probar el 2.
	bgt $t5, $t2, probar_rango_2 #Si es mayor que el maximo, falló el Rango 1. Vamos a probar el 2.
	
	j exito
	
probar_rango_2:
	# Si es menor que el minimo 2, fallo totalmente
	blt $t5, $t3, fallo
	bgt $t5, $t4, fallo
	
	# Si llegamos hasta aca es porque esta en el rango 2/
	j exito
	
fallo:
	j fin
	
exito:
	la $t0, res
	li $t6, 1
	sb $t6, 0($t0)
	
fin:
	#fin del programa