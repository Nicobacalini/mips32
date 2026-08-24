.data

vector: .word 10,20,30,40
.align 2
v_destino: .space 16


.text
main:
	la $t0, vector
	la $t1, v_destino
	
	lw $t2, 0($t0)
	sw $t2, 12($t1)

	lw $t2, 4($t0)
	sw $t2, 8($t1)
	
	lw $t2, 8($t0)
	sw $t2, 4($t1)
	
	lw $t2, 12($t0)
	sw $t2, 0($t1)
	