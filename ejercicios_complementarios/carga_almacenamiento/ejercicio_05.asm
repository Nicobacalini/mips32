.data
palabra:  .word 0x12345678
palabra2: .word 0

.text
main:
    lw  $t0, palabra
    

    sll $t1, $t0, 8       # Mueve a la izquierda: 34567800
    srl $t2, $t0, 24      # Mueve a la derecha:   00000012
    or  $t3, $t1, $t2     # Fusiona:              34567812
    
    sw  $t3, palabra2
    
 
	
	