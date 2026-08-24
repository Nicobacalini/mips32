.text
main:
	lui $t0, 0xabcd  #carga la parte alta
	ori $t0, $t0, 0x12bd
	
	#cargamos la mascara (0xfffffd77) en $t1
	lui $t1, 0xffff
	ori $t1, $t1, 0xfd77
	
	#aplica la cirugia (AND)
	and $t0, $t0, $t1
	