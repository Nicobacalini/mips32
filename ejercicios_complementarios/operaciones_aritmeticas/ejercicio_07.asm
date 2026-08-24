.data

numero1: .word 48
numero2: .word 18
mcd_final: .word 0

.text
main:
	lw $t0, numero1
    lw $t1, numero2

loop:	
	
	div $t0, $t1
	mfhi $t2 #resto
	
	beqz $t2, fin

	move $t0, $t1
	move $t1, $t2
	j loop
	
fin: 
	sw $t1, mcd_final
	