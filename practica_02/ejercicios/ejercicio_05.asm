.data
number: .word 0x1237
	.space 4
.text
main: 
	la $t0 , number
	lw $t1, 0($t0)
	sll $t2, $t1 , 5
	sw $t2, number+4