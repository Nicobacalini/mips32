.data

bytes: .byte 1,2,3,4

palabra: .word 0

.text
main: 
	la $s0, bytes
	la $s1, palabra
	
	lb $t2, 0($s0)
	sb $t2, 0($s1)
	
	lb $t2, 1($s0)
	sb $t2, 1($s1)
	
	lb $t2, 2($s0)
	sb $t2, 2($s1)
	
	lb $t2, 3($s0)
	sb $t2, 3($s1)