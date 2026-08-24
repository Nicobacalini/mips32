.data

numeros: .word 10,10,10,10

promedio: .word 0

.text
main:
	la $s0, numeros
	
	lw $t1, 0($s0)
	lw $t2, 4($s0)
	lw $t3, 8($s0)
	lw $t4, 12($s0)
	
	add $t5, $t1, $t2
	add $t5, $t5, $t3
	add $t5, $t5, $t4
	
	sra $t5, $t5, 2
	
	sw $t5, promedio