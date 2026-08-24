.data
A: .word 14
B: .word 7

cociente: .word 0
resto: .word 0

.text
main:
	lw $t0, A
	lw $t1, B
	
	div $t0, $t1
	mflo $t2
	mfhi $t3

	srl $t4, $t1, 1	
	
	ble $t3, $t4, guardar_resultados
	addi $t2, $t2, 1
	sub  $t3, $t3, $t1
	 
guardar_resultados:
	 sw $t2, cociente
	 sw $t3, resto