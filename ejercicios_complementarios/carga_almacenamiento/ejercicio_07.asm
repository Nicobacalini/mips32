.data
matriz1: .word 1,2,3,4,5,6 # 1 2 3
						   # 4 5 6

matriz2: .word 24		   # 1 4
						   # 2 5
						   # 3 6
						   
.text

main: 
	la $s0, matriz1
	la $s1, matriz2
	
	lw $t0, 0($s0)
	sw $t0, 0($s1)
	
	lw $t0, 4($s0)
	sw $t0, 8($s1)
	
	lw $t0, 8($s0)
	sw $t0, 16($s1)
	
	lw $t0, 12($s0)
	sw $t0, 4($s1)
	
	lw $t0, 16($s0)
	sw $t0, 12($s1)
	
	lw $t0, 20($s0)
	sw $t0, 20($s1)
	
	
	
