.data
vector: .byte 0, 1, 1, 1, 0
res:    .space 5           # Le puse nombre para no perdernos

.text
main:
    la $t0, vector         # $t0 apunta al inicio de vector
    la $t1, res            # $t1 apunta al inicio de res (donde guardaremos)

    # 1. CARGA DE DATOS (Arreglando la sintaxis)
    lb $s0, 0($t0)         # bool[0]
    lb $s1, 1($t0)         # bool[1]
    lb $s2, 2($t0)         # bool[2]
    lb $s3, 3($t0)         # bool[3]
    lb $s4, 4($t0)         # bool[4]
    
    and $t2, $s0, $s4
    sb $t2, 0($t1)
    
    or $t2 , $s1, $s3
    sb $t2, 1($t1)
    
    and $t2 , $s1, $s2
    or $t3, $t2, $s0
    
    sb $t3 , 2($t1)