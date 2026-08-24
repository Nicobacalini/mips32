.data
N:      .word 5
result: .word 0

.text
main:
    lw   $s0, N
    li   $t0, 1

    # sllv DESTINO, FUENTE, CANTIDAD_EN_REGISTRO
    sllv $t1, $t0, $s0
    
    sw   $t1, result