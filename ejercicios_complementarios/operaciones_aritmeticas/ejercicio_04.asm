.data

numeroA: .word 2
numeroB: .word 2
numeroC: .word 2


resultado: .word 0
.text

main:

	lw $t1, numeroA
	lw $t2, numeroB
	lw $t3, numeroC
	
	mul $t4, $t1, $t1
	mul $t5, $t2, $t2
	mul $t6, $t3, $t3
	
	add $t4, $t4, $t5
	add $t4, $t4, $t6
	
	sw $t4, resultado