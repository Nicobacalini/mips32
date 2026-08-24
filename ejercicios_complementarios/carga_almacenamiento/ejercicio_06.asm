.data
palabraA: .word 0x11223344
palabraB: .word 0x55667788

palabra: .word 0

.text
main:
	lw  $t0, palabraA
	lw  $t1, palabraB
	
	#Preparar la parte ALTA 11220000
	lui $t2, 0xFFFF
	and $t0, $t0, $t2
	
	# Preparar la parte BAJA 00007788
	andi $t1, $t1, 0xFFFF
	
	# Unir
	or $t3, $t0, $t1
	sw  $t3, palabra