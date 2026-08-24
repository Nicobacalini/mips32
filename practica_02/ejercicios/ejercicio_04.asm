.text
main:
	#cargar el numero del ejercicio (0xff0f1235)
	lui $t0, 0xff0f
	ori $t0, $t0, 0x1235
	
	#cargar la mascara para invertir
	# Como 0x288 es pequeño, podemos usar directo con $zero
	ori $t1, $zero , 0x288
	
	xor $t0, $t0 , $t1
	