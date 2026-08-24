.data
palabra: .word 0xAABBCCDD
palabra2: .word 0
.text

main:	
	la $s0, palabra
	la $s1, palabra2
	
	lb $t0, 0($s0)
	lb $t1, 1($s0)
	lb $t2, 2($s0)
	lb $t3, 3($s0)
	
	sb $t0, 0($s1)
	sb $t1, 1($s1)
	sb $t2, 2($s1)
	sb $t3, 3($s1)