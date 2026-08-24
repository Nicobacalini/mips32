.data 0x10000000
	vector: .word 10,20
	resultado: .space 4

.text
main:	
	la $t2,	vector
	lw $t0, 0($t2)
	lw $t1, 4($t2)
	
	add $t3, $t0, $t1
	sw $t3, resultado