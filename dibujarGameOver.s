.data  
posicionesX_L : .word 7, 7, 8, 9, 10, 11, 11, 11
posicionesY_L : .word 7, 9, 9, 9, 9, 9, 10, 11    #7 tamano
posicionesX_O : .word 7, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 11
posicionesY_O : .word 13, 14, 15, 13, 15, 13, 15, 13, 15, 13, 14, 15   #12 tamano
posicionesX_S : .word 7, 7, 7, 8, 9, 9, 9, 10, 11, 11, 11
posicionesY_S : .word 17, 18, 19, 17, 17, 18, 19, 19, 17, 18, 19      #11 tamano
posicionesX_T : .word 7, 7, 7, 8, 9, 10, 11
posicionesY_T : .word 21, 22, 23, 22, 22, 22, 22   #7 tamano
.text
#La funcion dibujaLost dibuja las letras LOST al momento de perder la partida. Se itera sobre los word posicionesX_letra y
#posicionesY_letra que contienen las posiciones (x,y) en las que se debe pintar en el tablero para formar las letras.
#Se itera sobre cada word segun sus tamanos y finalmente se agrega un punto en cada esquina del tablero.
dibujaLost:
    #Prologo
    sw $fp ($sp)
    move $fp $sp
    addi $sp $sp -4
        
    li $t0, 0
    li $t1, 0
    li $t2, 0
    lw $t3, colorGameOver
pintarL:
    beq $t2, 8, pintar
    lw $s0, posicionesX_L($t0)
    lw $s1, posicionesY_L($t1)
    
    lw $s2 MAT
    mul $s0 $s0 32
    add $s0 $s0 $s1
    mul $s0 $s0 4
    add $s2 $s2 $s0
    sw $t3, ($s2)
    
    add $t0, $t0, 4
    add $t1, $t1, 4
    add $t2, $t2, 1
    j pintarL
    
pintar:
    li $t0, 0
    li $t1, 0
    li $t2, 0
    lw $t3, colorGameOver
pintarO:
    beq $t2, 12, pintar2
    lw $s0, posicionesX_O($t0)
    lw $s1, posicionesY_O($t1)
    #addr = baseAddress + (rowIndex * colSize + colIndex)*datasize
    lw $s2 MAT
    mul $s0 $s0 32
    add $s0 $s0 $s1
    mul $s0 $s0 4
    add $s2 $s2 $s0
    sw $t3, ($s2)
    
    add $t0, $t0, 4
    add $t1, $t1, 4
    add $t2, $t2, 1
    j pintarO
pintar2:
    li $t0, 0
    li $t1, 0
    li $t2, 0
    lw $t3, colorGameOver
pintarS:
    beq $t2, 11, pintar3
    lw $s0, posicionesX_S($t0)
    lw $s1, posicionesY_S($t1)
    #addr = baseAddress + (rowIndex * colSize + colIndex)*datasize
    lw $s2 MAT
    mul $s0 $s0 32
    add $s0 $s0 $s1
    mul $s0 $s0 4
    add $s2 $s2 $s0
    sw $t3, ($s2)
    
    add $t0, $t0, 4
    add $t1, $t1, 4
    add $t2, $t2, 1
    j pintarS
pintar3:
    li $t0, 0
    li $t1, 0
    li $t2, 0
    lw $t3, colorGameOver
pintarT:
    beq $t2, 7, pintar4
    lw $s0, posicionesX_T($t0)
    lw $s1, posicionesY_T($t1)
    #addr = baseAddress + (rowIndex * colSize + colIndex)*datasize
    lw $s2 MAT
    mul $s0 $s0 32
    add $s0 $s0 $s1
    mul $s0 $s0 4
    add $s2 $s2 $s0
    sw $t3, ($s2)
    
    add $t0, $t0, 4
    add $t1, $t1, 4
    add $t2, $t2, 1
    j pintarT
pintar4:
    lw $s0 MAT
    sw $t3, ($s0)
    
    lw $s0 MAT
    li $s1 0
    mul $s1 $s1 32
    add $s1 $s1 31
    mul $s1 $s1 4
    add $s0 $s0 $s1
    sw $t3, ($s0)
    
    lw $s0 MAT
    li $s1 31
    mul $s1 $s1 32
    add $s1 $s1 0
    mul $s1 $s1 4
    add $s0 $s0 $s1
    sw $t3, ($s0)
    
    lw $s0 MAT
    li $s1 31
    mul $s1 $s1 32
    add $s1 $s1 31
    mul $s1 $s1 4
    add $s0 $s0 $s1
    sw $t3, ($s0)
    #Epilogo
    move $sp $fp
    lw $fp ($sp)
    jr $ra
