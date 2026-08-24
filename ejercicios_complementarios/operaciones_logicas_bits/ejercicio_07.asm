.data

byte: .byte 0x3B
record_max : .word 0


.text
main:
    lb   $t0, byte    # $t0 = byte que vamos a destruir
    
    li   $t1, 0             # $t1 = contador_actual 
    li   $t2, 0             # $t2 = record_max 
    li   $t3, 8             # $t3 = iteraciones 
    
loop:
	# si iteraciones es 0
	beqz $t3, romper_racha
	
	# aislamos el bit
	andi $t4, $t0, 1
	
	# Si es 0 rompemos la racha
	beqz $t4, romper_racha
	
	# Si es 1 sumamos uno a contador_actual 
	addi $t1, $t1, 1
	
	ble  $t1, $t2, avanzar
	move $t2, $t1
	j avanzar
	
romper_racha:
li $t1, 0

avanzar:
	srl $t0, $t0, 1
	subi $t3, $t3, 1
	j loop