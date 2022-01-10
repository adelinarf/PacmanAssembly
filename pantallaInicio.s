.data
    letraPx: .word 11 12 13 14 11 13 11 12 13  
    letraPy: .word 4   4  4  4  5  5  6  6  6 #10
    letraAx: .word 11 11 11 12 12 13 13 13 14 14   
    letraAy: .word  8  9 10  8 10 8   9 10  8 10 #11
    letraCx: .word 11 11 11 12 13 14 14 14
    letraCy: .word 12 13 14 12 12 12 13 14 #9
    letraMx: .word 11 11 11 11 11 12 12 12 13 13 13 14 14 
    letraMy: .word 16 17 18 19 20 16 18 20 16 18 20 16 20 #14
    letraNx: .word 11 11 11 12 12 13 13 14 14 
    letraNy: .word 26 27 28 26 28 26 28 26 28 #10
    letraSx: .word 17, 17, 17, 18, 19, 19, 19, 20, 21, 21, 21 
    letraSy: .word 14, 15, 16, 14, 14, 15, 16, 16, 14, 15, 16
    colorS : .word 0x00FEF016
.text
pantallaInicio:
    #Prologo
    sw $fp ($sp)
    move $fp $sp
    sw $ra -4($sp)
    addi $sp $sp -8
    
    jal inicializaTableroNegro
    
    li $t0, 0
    li $t1, 0
    li $t2, 0
    lw $t3, colorS
pintarPInicio:
    beq $t2, 9, despuesP
    lw $s0, letraPx($t0)
    lw $s1, letraPy($t1)
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
    j pintarPInicio
despuesP:
    li $t0, 0
    li $t1, 0
    li $t2, 0
pintarAInicio:
    beq $t2, 10, despuesA
    lw $s0, letraAx($t0)
    lw $s1, letraAy($t1)
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
    j pintarAInicio
despuesA:
    li $t0, 0
    li $t1, 0
    li $t2, 0
pintarCInicio:
    beq $t2, 8, despuesC
    lw $s0, letraCx($t0)
    lw $s1, letraCy($t1)
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
    j pintarCInicio
despuesC:
    li $t0, 0
    li $t1, 0
    li $t2, 0
pintarMInicio:
    beq $t2, 13, despuesM
    lw $s0, letraMx($t0)
    lw $s1, letraMy($t1)
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
    j pintarMInicio
despuesM:
    li $t0, 0
    li $t1, 0
    li $t2, 0
pintarAInicio2:
    beq $t2, 10, despuesA2
    lw $s0, letraAx($t0)
    lw $s1, letraAy($t1)
    add $s1, $s1, 14
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
    j pintarAInicio2
despuesA2:
    li $t0, 0
    li $t1, 0
    li $t2, 0
pintarNInicio:
    beq $t2, 9, despuesN
    lw $s0, letraNx($t0)
    lw $s1, letraNy($t1)
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
    j pintarNInicio
despuesN:
    li $t0, 0
    li $t1, 0
    li $t2, 0
pintarSInicio:
    beq $t2, 11, esperarTeclado
    lw $s0, letraSx($t0)
    lw $s1, letraSy($t1)
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
    j pintarSInicio
    
esperarTeclado:
     lw $a0 teclaPresionada
     beq $a0 83 nuevoJuego
     beq $a0 115 nuevoJuego
     j esperarTeclado
     nop 
nuevoJuego:    
    #Epilogo
    move $sp $fp
    lw $fp ($sp)
    lw $ra -4($sp)
    jr $ra
