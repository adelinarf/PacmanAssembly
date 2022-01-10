.data
DP :  .word 0x00000000
.text 
#La funcion dibujarPortal2 toma como entrada:
# t1: colorPortal2 / colorPortal3 
# Se aplica la formula (((columna*32)+filas)*4) para pintar los portales en las posiciones, 14,38 y 26,8
# de los colores colorPortal2 y colorPortal3 respectivamente.
#La salida es: las casillas 14,28 y 26,8 pintadas de colorPortal2 y colorPortal3 en el tablero.
dibujarPortal2:
    #Prologo
    sw $fp ($sp)
    move $fp $sp
    sw $ra -4($sp)
    addi $sp $sp -8
#El portal 2 aparece en la posicion 14,28
    lw $s0 MAT
    li $s1 14
    lw $t1 colorPortal2
    mul $s1 $s1 32
    add $s1 $s1 28
    mul $s1 $s1 4
    add $s0 $s0 $s1
    sw $t1, ($s0)
    sw $s0, DP
    move $s4, $s0

dibujarPortal3:
#El portal 3 aparece en la posicion 26,8
    lw $s0 MAT
    li $s1 29
    lw $t1 colorPortal3
    mul $s1 $s1 32
    add $s1 $s1 8
    mul $s1 $s1 4
    add $s0 $s0 $s1
    sw $t1, ($s0)
    sw $s0, DP
    move $s4, $s0
    jal pastillita1
    
    #Epilogo
    move $sp $fp
    lw $fp ($sp)
    lw $ra -4($sp)
    jr $ra
    
.include "superComida.s"
