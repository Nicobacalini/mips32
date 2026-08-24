.data
# --- Punteros de control ---
slist:   .word 0      # Lista de nodos libres
cclist:  .word 0      # Inicio de la lista de Categorias
wclist:  .word 0      # Categoria actual seleccionada
schedv:  .space 32    # Vector de 8 direcciones (para las funciones 1-8)

# --- Textos del menu ---
menu:    .ascii  "Colecciones de objetos categorizados\n"
         .ascii  "====================================\n"
    					.ascii  "1-Nueva categoria\n"
    					.ascii  "2-Siguiente categoria\n"
         .ascii  "3-Categoria anterior\n"
         .ascii  "4-Listar categorias\n"
         .ascii  "5-Borrar categoria actual\n"
         .ascii  "6-Anexar objeto a la categoria actual\n"
         .ascii  "7-Listar objetos de la categoria\n"
         .ascii  "8-Borrar objeto de la categoria\n"
         .ascii  "0-Salir\n"
         .asciiz "Ingrese la opcion deseada: "

# --- Mensajes ---
error:   .asciiz "Error: "
return:  .asciiz "\n"
catName: .asciiz "\nIngrese el nombre de una categoria: "
selCat:  .asciiz "\nSe ha seleccionado la categoria:"
idObj:   .asciiz "\nIngrese el ID del objeto a eliminar: "
objName: .asciiz "\nIngrese el nombre de un objeto: "
success: .asciiz "La operacion se realizo con exito\n\n"
notFound: .asciiz "Error: Objeto no encontrado\n"

.text
.globl main

 main:
 	# Inicializar el vector schedv
 	la $t0, schedv
 	
 	# Opcion 1
 	la $t1, newcategory
 	sw $t1, 0($t0)
 	
 	# Opcion 2
 	la $t1, nextcategory
 	sw $t1, 4($t0)
 	
 	# Opcion 3
	la $t1, prevcategory
	sw $t1, 8($t0)

	# Opcion 4
	la $t1, listcategories
	sw $t1, 12($t0)
    
	# Opcion 5
	la $t1, delcategory
	sw $t1, 16($t0)
	
	# Opcion 6
	la $t1, newobject
	sw $t1, 20($t0)
    
	# Opcion 7
	la $t1, listobjects
	sw $t1, 24($t0)

	# Opcion 8
	la $t1, delobject
	sw $t1, 28($t0)
	
	j server
	
	
server:
	# Imprimir el menu
	li $v0, 4 		# codigo 4 para imprimir una cadena de caracteres
	la $a0, menu	# Cargar texto del menu
	syscall
	
	# Leer opcion del usuario
	li $v0, 5 			# codigo 5 para leer un entero
	syscall
	move $t0, $v0 		# Guardar la opcion en $t0
	
	# Validar opcion 0 (SALIR)
	beqz $t0, fin
	
	# Validar rango (del 1-8)
	li $t1, 8
	bgt $t0, $t1, error_opcion	# Si es mayor que 8
	blez $t0, error_opcion		# Si es menos que 0
	
	# Calcular offset: (opcion - 1) * 4
	addi $t0, $t0, -1
	sll $t0, $t0, 2	
	 			
	# Saltar a la funcion
	la $t1, schedv		# Base del vector 
	add $t1, $t1, $t0	# Base + offset (direccion de la tabla)
	
	lw $t2, 0($t1)		# Cargar la direccion de la funcion donde tiene que ir
	
	# Saltar a la funcion
	jalr $t2			# Usar jarl para que vuelva aca cuando termine
	
	# Repetir menu
	j server

error_opcion:
	li $v0, 4
	la $a0, error
	syscall
	li $v0, 1           # El 1 es para imprimir entero
	li $a0, 101
	syscall
	li $v0, 4
	la $a0, return
	syscall
	j server            # Volver al menu, j para reniciar el ciclo

  
fin:
	li $v0, 10          # Salir del programa, codigo 10 para finalizar de forma limpia
	syscall


#   ------- FUNCIONES -------

newcategory: 
	# Crear espacio para nuevo dato y guardar el retorno 
	addiu $sp, $sp, -4	
	sw $ra, 4($sp)     	
	
	# Pedir nombre y crear nodo
	la $a0, catName
	jal getblock
	move $a2, $v0		# Direccion del nombre (que trajo getblock)
	la $a0, cclist		# $a0 = list
	li $a1, 0			# $a1 = NULL
	jal addnode
	
	# Si es la primera categoria, seleccionarla
	lw $t0, wclist
	bnez $t0, newcategory_end
	sw $v0, wclist		# Actualiza la lista de trabajo si era nulo
	
	# Mensaje exito
    li $v0, 4     
    la $a0, success
    syscall


newcategory_end:
	li $v0, 0 			# Codigo exito
	lw $ra, 4($sp)		# Recuperamos $ra de 4($sp)
	addiu $sp, $sp, 4	# Devolvemos el espacio a la pila
	jr $ra
	
	
nextcategory: 
	# Validar que existan categorias
	lw $t0, cclist	# Cargar categorias
	beqz $t0, error_no_cat
	
	# Verificar que no sea la unica
	lw $t0, wclist	# $t0 = Nodo Actual
	lw $t1, 12($t0) # $t1 = siguente
	beq $t0, $t1, error_one_cat_202 	# $t0 == $t1 -> Error 202
	
	# Avanzar al siguiente
	sw $t1, wclist
	
	# Mostrar categoria seleccionada
	li $v0, 4
	la $a0, selCat
	syscall
	lw $a0, 8($t1)	# Cargamos el nombre cat
	syscall
	
	# Codigo exito
	li $v0, 0	
	jr $ra



prevcategory: 
	# Validar que existan categorias
	lw $t0, cclist
	beqz $t0, error_no_cat
	
	# Verificar que no sea la unica
	lw $t0, wclist # t0 = nodo actual
	lw $t1, 0($t0) # t1 = anterior
	beq $t0, $t1, error_one_cat_202	# $t0 == $t1 -> Error 202
	
	# Retroceder al anterior
	sw $t1, wclist
	
	# Mostrar categoria seleccionada
	li $v0, 4
	la $a0, selCat
	syscall
	lw $a0, 8($t1)	# Imprimir nombre del nodo
	syscall
	
	li $v0, 0
	jr $ra
	 
listcategories: 
	# Validar que existan categorias
	lw $t0, cclist	# Inicio de la lista
	beqz $t0, error_no_cat_301
	
	
	lw $t2, wclist		# Categoria seleccionada
	move $t1 , $t0 		# Iterador (Empieza al inicio)
	
	
list_loop:
	# Marcar la categoria seleccionada con '>'
	bne $t1, $t2, print_space
	
	# Es la seleccionada
	li $a0, 62	# Codigo ASCII del '>'
	li $v0, 11	# codigo imprimir char
	syscall
	li $a0, 32      # Codigo ASCII " "
	li $v0, 11	
	syscall
	j print_name

print_space:
    li $a0, 32
    li $v0, 11
    syscall
    li $a0, 32
    li $v0, 11
    syscall

print_name:
	# Imprimir nombre de categoria
	lw $a0, 8($t1)	# Cargar direccion del nombre
	li $v0, 4	
	syscall
	# Imprimir Enter
	li $v0, 4
	la $a0, return
	syscall
	
	# # Carga el siguente nodo para avanzar hata completar el circulo
	lw $t1, 12($t1)	
	
	# Comparamos $t1 y $t0, si son iguales no repetimos
	bne $t1, $t0, list_loop
	
	li $v0, 0
	jr $ra
	
delcategory: 
    # Guardamos el RA
    addiu $sp, $sp, -4
    sw $ra, 4($sp)
    
    # Validamos que haya categorias
    lw $t0, cclist
    beqz $t0, error_no_cat_401

   
# Borrar todos los objetos de la categoria   
loop_clean_objects:
    lw $t0, wclist      # Cargamos la categoria actual
    lw $t1, 4($t0)      # $t1 = Puntero a la lista de objetos
    
    # Si $t1 es 0, la lista esta vacia -> Terminamos limpieza
    beqz $t1, fin_clean_objects
    
    # Preparamos argumentos para borrar objetos
    move $a0, $t1       # $a0 = Nodo a borrar
    addi $a1, $t0, 4    # $a1 = Direccion del puntero de la lista
    # Guardar $t0 porque jal puede ensuciar registros temporales
    
    jal delnode
    
    # Repetimos el ciclo
    j loop_clean_objects
    
fin_clean_objects:
    # Identificar cual nodo eliminar y su siguente
    lw $a0, wclist      # $a0 = Nodo categoria a borrar
    lw $t1, 12($a0)     # $t1 = categoria siguiente 
    
    # Comprobar si es el unico nodo
    beq $a0, $t1, es_ultimo_nodo
    
    # Hay mas nodos
    sw $t1, wclist
    j llamar_delnode_cat 
    
es_ultimo_nodo:
    sw $zero, wclist

llamar_delnode_cat:
    # Borramos categoria
    la $a1, cclist      # $a1 = Direccion de la lista principal
    jal delnode
    
    # Mensaje Exito
    li $v0, 4
    la $a0, success
    syscall
    
    # Salir
    li $v0, 0           
    lw $ra, 4($sp)      # Recuperamos RA
    addiu $sp, $sp, 4   # Restauramos Stack
    jr $ra

	
	
newobject: 
	# Guardamos el RA
	addiu $sp, $sp, -4
	sw    $ra, 4($sp)
	
	# Validar que exista categoria
	lw $t0, wclist
	beqz $t0, error_no_cat_501
	
	# Pedir nombre del objeto
	la $a0, objName		# Input categoria name
	jal getblock
	move $a2, $v0		# $a2 = Nombre (para addnode)

	 # Recargar el $t0 por si tiene basura 
	lw $t0, wclist
	# Calcular ID: 1 si esta vacia
	lw $t1, 4($t0)
	beqz $t1, id_uno
	
	# ultimo + 1
	lw $t2, 0($t1) 		# Buscamos el ultimo
	lw $a1, 4($t2)		# Cargamos id
	addi $a1, $a1, 1
	j crear_nodo
	
id_uno:
	li $a1, 1

crear_nodo: 
    addi $a0, $t0, 4    # Direccion de la sublista
    jal addnode         # Insertamos el nuevo objeto
    
    # Primero imprimimos el mensaje de exito
    li $v0, 4
    la $a0, success
    syscall
	
    # Restauramos la pila
    lw $ra, 4($sp)
    addiu $sp, $sp, 4
    
	# Codigo exito
    li $v0, 0
    jr $ra

	
listobjects: 
	# Validar si hay categorias
	lw $t0, wclist
	beqz $t0, error_no_cat_601
	
	# Validar que tenga objetos
	lw $t1 , 4($t0)		# $t1 = Primer objeto
	beqz $t1, error_no_obj_602
	move $t2, $t1		# $t2 = Iterador

list_obj_loop:
	# IMPRIMIR ID
	lw $a0, 4($t2)
	li $v0, 1
	syscall
	
	# Imprimir separador " - "
	li $a0, 32              # Espacio
	li $v0, 11
	syscall
	li $a0, 45              # Guion '-'
	li $v0, 11
	syscall
	li $a0, 32              # Espacio
	li $v0, 11
	syscall

	# Imprimir nombre
	lw $a0, 8($t2)
	li $v0, 4
	syscall
	
	# Imprimir Enter
	li $v0, 4
	la $a0, return
	syscall

	lw $t2, 12($t2)		# Cargamos Nodo siguente
	bne $t2, $t1, list_obj_loop # si no son iguales repetimos

print_id:
	li $v0, 0
	jr $ra

listobj_end:
    li $v0, 0
    jr $ra
	
delobject: 
	# Guardamos el RA
	addiu $sp, $sp, -4
	sw $ra, 4($sp)
	
	# Validar si hay categoria
	lw $t0, wclist
	beqz $t0, error_no_cat_701
	
	# validar si hay objetos
	lw    $t1, 4($t0)       # $t1 = Primer objeto
	beqz  $t1, object_not_found

	# Pedir ID a eliminar
	li $v0, 4
	la $a0, idObj
	syscall
	
	# Leer opcion del usuario
	li $v0, 5
	syscall
	
	move $s0, $v0 		# Guarda la opcion en $s0
	move  $t2, $t1		# $t2 = Viajero
	
buscamos_id_loop:
	lw $t3, 4($t2) 		# $t3 = ID del objeto actual
	beq $t3, $s0, ejecutar_borrado
	
	lw $t2, 12($t2)		# Avanzar
	
	# Si no dimos la vuelta, seguimos buscando
	bne $t2, $t1, buscamos_id_loop
	# Sino
	j object_not_found
	
ejecutar_borrado:
	move  $a0, $t2 			# $a0 = Direccion del nodo a borrar
	addi  $a1, $t0, 4       # $a1 = Direccion de la lista dentro de la categoria
	jal   delnode

delobj_fin:
    # Mensaje Exito
    li $v0, 4
    la $a0, success
    syscall
    
    # Carga el 0 exito
    li $v0, 0  
    
    # Salir
    lw $ra, 4($sp)          # Recuperar retorno
    addiu $sp, $sp, 4       # Liberar pila
    jr $ra

object_not_found:
	li $v0, 4
	la $a0, notFound    # Imprimimos "Error: Objeto no encontrado"
	syscall
	li $v0, 1           # Retornamos 1 (Error)
	lw $ra, 4($sp)
	addiu $sp, $sp, 4
	jr $ra


#   ------- ERRORES -------         

error_no_cat:
	li $v0, 4
	la $a0, error
	syscall
	li $a0, 201
	li $v0, 1
	syscall
	j nextcat_fin

error_one_cat_202:
	li $v0, 4
	la $a0, error
	syscall
	li $a0, 202
	li $v0, 1
	syscall
	jr $ra
	
error_no_cat_301:
	li $v0, 4
	la $a0, error
	syscall
	li $a0, 301
	li $v0, 1
	syscall
	jr $ra
	
error_no_cat_401:
	li $v0, 4
	la $a0, error
	syscall
	li $a0, 401
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, return
	syscall
	lw $ra, 4($sp) 	# Restaurar pila antes de salir por error
	addiu $sp, $sp, 4
	jr $ra

error_no_cat_501:
	li $v0, 4
	la $a0, error
	syscall
	li $a0, 501
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, return
	syscall
	lw $ra, 4($sp)
	addiu $sp, $sp, 4
	jr $ra
	
error_no_cat_601:
	li $v0, 4
	la $a0, error
	syscall
	li $a0, 601
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, return
	syscall
	jr $ra

error_no_obj_602:
	li $v0, 4
	la $a0, error
	syscall
	li $a0, 602
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, return
	syscall
	jr $ra
	
error_no_cat_701:
	li    $v0, 4
	la $a0, error
	syscall
	li    $a0, 701
	li $v0, 1
	syscall
	li    $v0, 4
	la $a0, return
	syscall
	lw    $ra, 4($sp)	# Restaurar pila antes de salir por error
	addiu $sp, $sp, 4
	jr    $ra
	
nextcat_fin:
	li $v0, 0	# Retornar 0 
	jr $ra

menu_loop:
	j menu_loop # Volver al menu


#                 FUNCIONES TP

smalloc:
    lw $t0, slist # Donde tenemos bloques basuras para reutilizar
    beqz $t0, sbrk # Si da 0 es porque no tenemos ningun bloque
    
    # Si no salto hay bloques para reutilizar
    move $v0, $t0	# ponemos el $v0 el bloque a reutilizar
    lw $t0, 12($t0)	# ponemos el siguiente de ese bloque basura como principal
    sw $t0, slist	# Actualizamos la lista de basura (slist)
    jr $ra		

sbrk:
    li $a0, 16          # Tamaño de nodo fijo (4 palabras = 16 bytes)
    li $v0, 9           # Syscall sbrk
    syscall
    jr $ra				# Volvemos a quien llamo la funcion que lo llamo
		
sfree:
    lw $t0, slist
    sw $t0, 12($a0)
    sw $a0, slist       # $a0 direccion del nodo a reciclar
    jr $ra

# ------------------------------------------------------------------------------
# addnode: Añade un nodo al final de una lista circular doble
# $a0: Direccion del PUNTERO a la lista
# $a1: Datos campo 4 (Sublista)
# $a2: Datos campo 8 (Puntero a nombre)
# $v0: Devuelve la direccion del nuevo nodo
# ------------------------------------------------------------------------------
addnode:
    addi $sp, $sp, -8
    sw $ra, 8($sp)
    sw $a0, 4($sp)
    jal smalloc
    sw $a1, 4($v0)      # Guardar contenido
    sw $a2, 8($v0)      # Guardar nombre
    lw $a0, 4($sp)
    lw $t0, ($a0)       # Cargar direccion del primer nodo
    beqz $t0, addnode_empty_list

addnode_to_end:
    lw $t1, ($t0)       # Cargar ultimo nodo (prev del primero)
    # Actualizar punteros del nuevo nodo
    sw $t1, 0($v0)      # prev = ultimo
    sw $t0, 12($v0)     # next = primero
    # Actualizar punteros de los vecinos
    sw $v0, 12($t1)     # next del ultimo = nuevo
    sw $v0, 0($t0)      # prev del primero = nuevo
    j addnode_exit

addnode_empty_list:
    sw $v0, ($a0)       # La lista apunta al nuevo nodo
    sw $v0, 0($v0)      # prev se apunta a si mismo
    sw $v0, 12($v0)     # next se apunta a si mismo

addnode_exit:
    lw $ra, 8($sp)
    addi $sp, $sp, 8
    jr $ra

# ------------------------------------------------------------------------------
# delnode: Elimina un nodo de la lista y libera memoria
# $a0: Direccion del nodo a borrar
# $a1: Direccion del PUNTERO a la lista (para actualizar si borramos el primero)
# ------------------------------------------------------------------------------
delnode:
    addi $sp, $sp, -8
    sw $ra, 8($sp)
    sw $a0, 4($sp)
    lw $a0, 8($a0)      # Obtener direccion del bloque de nombre
    jal sfree           # Liberar el bloque de nombre
    lw $a0, 4($sp)      # Restaurar $a0 (nodo a borrar)
    lw $t0, 12($a0)     # Obtener siguiente nodo

    beq $a0, $t0, delnode_point_self # ¿Es el unico nodo?

    lw $t1, 0($a0)      # Obtener nodo anterior
    sw $t1, 0($t0)      # El prev del siguiente ahora es mi anterior
    sw $t0, 12($t1)     # El next del anterior ahora es mi siguiente
    lw $t1, 0($a1)      # Cargar cabeza de la lista

    bne $a0, $t1, delnode_exit # Si no borramos la cabeza, salir
    sw $t0, ($a1)       # Si borramos la cabeza, actualizar puntero lista al siguiente
    j delnode_exit

delnode_point_self:
    sw $zero, ($a1)     # La lista queda vacia (NULL)

delnode_exit:
    jal sfree           # Liberar el nodo borrado
    lw $ra, 8($sp)
    addi $sp, $sp, 8
    jr $ra

# ------------------------------------------------------------------------------
# getblock: Pide texto al usuario y lo guarda en memoria
# $a0: Direccion del mensaje a mostrar
# $v0: Direccion del bloque de memoria con el string guardado
# ------------------------------------------------------------------------------
getblock:
    addi $sp, $sp, -4
    sw $ra, 4($sp)
    li $v0, 4
    syscall             # Imprimir mensaje ($a0)
    jal smalloc         # Pedir memoria para el texto
    move $a0, $v0
    li $a1, 16          # Largo maximo (siempre bloques de 16 bytes)
    li $v0, 8           # Syscall leer string
    syscall
    move $v0, $a0       # Devolver direccion del string
    lw $ra, 4($sp)
    addi $sp, $sp, 4
    jr $ra

