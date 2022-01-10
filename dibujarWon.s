.data  
posicionesX_W : .word 10, 11, 12, 13, 14, 13, 12, 13, 10, 11, 12, 13, 14
posicionesY_W : .word  9, 9, 9, 9, 9, 10, 11, 12, 13, 13, 13, 13, 13 #13 tamano
posicionesX_WO : .word 10, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 14
posicionesY_WO : .word 15, 16, 17, 15, 17, 15, 17, 15, 17, 15, 16, 17 #12 tamano
posicionesX_N : .word 10, 11, 12, 13, 14, 11, 12, 13, 10, 11, 12, 13, 14
posicionesY_N : .word 19, 19, 19, 19, 19, 20, 21, 21, 22, 22, 22, 22, 22 #13 tamano
.text
dibujaWon:
    #Prologo
    sw $fp ($sp)
    move $fp $sp
    addi $sp $sp -4
        
    li $t0, 0
    li $t1, 0
    li $t2, 0
    lw $t3, colorGanado
pintarW:
    beq $t2, 13, pintaW2
    lw $s0, posicionesX_W($t0)
    lw $s1, posicionesY_W($t1)
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
    j pintarW
    
pintaW2:
    li $t0, 0
    li $t1, 0
    li $t2, 0
pintarWO:
    beq $t2, 12, pintarWO2
    lw $s0, posicionesX_WO($t0)
    lw $s1, posicionesY_WO($t1)
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
    j pintarWO
pintarWO2:
    li $t0, 0
    li $t1, 0
    li $t2, 0
pintarN:
    beq $t2, 13, pintarGanado
    lw $s0, posicionesX_N($t0)
    lw $s1, posicionesY_N($t1)
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
    j pintarN
pintarGanado:
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