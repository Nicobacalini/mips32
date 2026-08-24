.data
byte: .byte 0xAA, 0xBB,0xCC, 0xDD
.align 2
# Reserva para Word en orden inverso (0xDDCCBBAA)
word_reverse: .word 0
# Reserva para Word intercambiando pares (0xBBAADDCC)
word_pares: .word

