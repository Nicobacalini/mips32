.data 0x10000000
vector:	.word 18, -1215

.data 0x10010000
	res_1: .space 4
	res_2: .space 4
	
.text
main:
	la $t0 , vector
	
	la $s0, res_1
	li $t3, 5
	
	lw $t1, 0($t0)
	lw $t2, 4($t0)
	
	#primera divicion
	div $t1, $t3
	mflo $t4
	sw $t4, 0($s0)
	
	#segunda divicion
	div $t2, $t3
	mflo $t4
	sw $t4, 4($s0)
	