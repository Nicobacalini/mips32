.data
palabra1: .word 0
palabra2: .word 1

.text
main:
	lw $t0, palabra1
	lw $t1, palabra2
	sw $t1, palabra1
	sw $t0, palabra2
	
	
	
	