.data
    #la base de estos numeros esta en la unidad
    ceroX: .word 12 12 12 13 13 14 14 15 15 16 16 16  #12
    ceroY: .word 18 19 20 18 20 18 20 18 20 18 19 20 
    unoX: .word 12 13 14 15 16 #5
    unoY: .word 20 20 20 20 20
    dosX: .word 12 12 12 13 14 14 14 15 16 16 16  #11
    dosY: .word 18 19 20 20 18 19 20 18 18 19 20
    tresX: .word 12 12 12 13 14 14 14 15 16 16 16 #11
    tresY: .word 18 19 20 20 18 19 20 20 18 19 20
    cuatroX: .word 12 12 13 13 14 14 14 15 16 #9
    cuatroY: .word 18 20 18 20 18 19 20 20 20
    cincoX: .word 12 12 12 13 14 14 14 15 16 16 16 #11
    cincoY: .word 18 19 20 18 18 19 20 20 18 19 20
    seisX: .word 12 12 12 13 14 14 14 15 15 16 16 16 #12
    seisY: .word 18 19 20 18 18 19 20 18 20 18 19 20
    sieteX: .word 12 12 12 13 14 15 16 #7
    sieteY: .word 18 19 20 20 20 20 20
    ochoX: .word 12 12 12 13 13 14 14 14 15 15 16 16 16 #13
    ochoY: .word 18 19 20 18 20 18 19 20 18 20 18 19 20
    nueveX: .word 12 12 12 13 13 14 14 14 15 16 16 16 #12
    nueveY: .word 18 19 20 18 20 18 19 20 20 18 19 20
.text
#La funcion PintarNumero toma como valores de entrada:
# a0 : El offset en el que se pintara el numero
# a1 :  El numero a pintarse
# El valor base para los numeros se encuentra en el numero mas a la derecha, por lo que la base en la unidad, la decena esta 3 espacios
# a la izquierda, la centena 6 espacios y asi sucesivamente. Se verifica por casos cual es el numero a pintar y se pinta segun los valores
# que se encuentran alojados en los words de este archivo. Se itera sobre el word la misma cantidad de veces de su tamano y la funcion no
# retorna ningun valor.
PintarNumero:
    #Prologo
    sw $fp ($sp)
    move $fp $sp
    addi $sp $sp -4

    move $t0, $a0
    move $t1, $a1
    li $s0 0
    li $t2, 0
    beq $t1, 0, pintarCero
    beq $t1, 1, pintarUno
    beq $t1, 2, pintarDos
    beq $t1, 3, pintarTres
    beq $t1, 4, pintarCuatro
    beq $t1, 5, pintarCinco
    beq $t1, 6, pintarSeis
    beq $t1, 7, pintarSiete
    beq $t1, 8, pintarOcho
    beq $t1, 9, pintarNueve
    
    
pintarCero:
    beq $t2, 12, saltarPintar
    lw $s1, ceroX($s0)
    lw $s2, ceroY($s0)
    sub $s2, $s2, $t0
    
    lw $s4 MAT
    move $s3 $s1
    mul $s3 $s3 32
    add $s3 $s3 $s2
    mul $s3 $s3 4
    add $s4 $s4 $s3  
    
    lw $a0 colorPortal3
    sw $a0, ($s4)
    
    add $s0, $s0, 4
    add $t2, $t2, 1
    b pintarCero

pintarUno:
    beq $t2, 5, saltarPintar
    lw $s1, unoX($s0)
    lw $s2, unoY($s0)
    sub $s2, $s2, $t0
    
    lw $s4 MAT
    move $s3 $s1
    mul $s3 $s3 32
    add $s3 $s3 $s2
    mul $s3 $s3 4
    add $s4 $s4 $s3  
    
    lw $a0 colorPortal2
    sw $a0, ($s4)
    
    add $s0, $s0, 4
    add $t2, $t2, 1
    b pintarUno
    
pintarDos:
    beq $t2, 11, saltarPintar
    lw $s1, dosX($s0)
    lw $s2, dosY($s0)
    sub $s2, $s2, $t0
    
    lw $s4 MAT
    move $s3 $s1
    mul $s3 $s3 32
    add $s3 $s3 $s2
    mul $s3 $s3 4
    add $s4 $s4 $s3  
    
    lw $a0 colorSuperComida
    sw $a0, ($s4)
    
    add $s0, $s0, 4
    add $t2, $t2, 1
    b pintarDos
    
pintarTres:
    beq $t2, 11, saltarPintar
    lw $s1, tresX($s0)
    lw $s2, tresY($s0)
    sub $s2, $s2, $t0
    
    lw $s4 MAT
    move $s3 $s1
    mul $s3 $s3 32
    add $s3 $s3 $s2
    mul $s3 $s3 4
    add $s4 $s4 $s3  
    
    lw $a0 colorPacman
    sw $a0, ($s4)
    
    add $s0, $s0, 4
    add $t2, $t2, 1
    b pintarTres

pintarCuatro:
    beq $t2, 9, saltarPintar
    lw $s1, cuatroX($s0)
    lw $s2, cuatroY($s0)
    sub $s2, $s2, $t0
    
    lw $s4 MAT
    move $s3 $s1
    mul $s3 $s3 32
    add $s3 $s3 $s2
    mul $s3 $s3 4
    add $s4 $s4 $s3 
    
    lw $a0 colorBlinky
    sw $a0, ($s4)
    
    add $s0, $s0, 4
    add $t2, $t2, 1
    b pintarCuatro

pintarCinco:
    beq $t2, 11, saltarPintar
    lw $s1, cincoX($s0)
    lw $s2, cincoY($s0)
    sub $s2, $s2, $t0
    
    lw $s4 MAT
    move $s3 $s1
    mul $s3 $s3 32
    add $s3 $s3 $s2
    mul $s3 $s3 4
    add $s4 $s4 $s3  
    
    lw $a0 colorClyde
    sw $a0, ($s4)
    
    add $s0, $s0, 4
    add $t2, $t2, 1
    b pintarCinco

pintarSeis:
    beq $t2, 12, saltarPintar
    lw $s1, seisX($s0)
    lw $s2, seisY($s0)
    sub $s2, $s2, $t0
    
    lw $s4 MAT
    move $s3 $s1
    mul $s3 $s3 32
    add $s3 $s3 $s2
    mul $s3 $s3 4
    add $s4 $s4 $s3  
    
    lw $a0 colorPinky
    sw $a0, ($s4)
    
    add $s0, $s0, 4
    add $t2, $t2, 1
    b pintarSeis
    
pintarSiete:
    beq $t2, 7, saltarPintar
    lw $s1, sieteX($s0)
    lw $s2, sieteY($s0)
    sub $s2, $s2, $t0
    
    lw $s4 MAT
    move $s3 $s1
    mul $s3 $s3 32
    add $s3 $s3 $s2
    mul $s3 $s3 4
    add $s4 $s4 $s3  
    
    lw $a0 colorInky
    sw $a0, ($s4)
    
    add $s0, $s0, 4
    add $t2, $t2, 1
    b pintarSiete

pintarOcho:
    beq $t2, 13, saltarPintar
    lw $s1, ochoX($s0)
    lw $s2, ochoY($s0)
    sub $s2, $s2, $t0
    
    lw $s4 MAT
    move $s3 $s1
    mul $s3 $s3 32
    add $s3 $s3 $s2
    mul $s3 $s3 4
    add $s4 $s4 $s3  
    
    lw $a0 colorGameOver
    sw $a0, ($s4)
    
    add $s0, $s0, 4
    add $t2, $t2, 1
    b pintarOcho

pintarNueve:
    beq $t2, 12, saltarPintar
    lw $s1, nueveX($s0)
    lw $s2, nueveY($s0)
    sub $s2, $s2, $t0
    
    lw $s4 MAT
    move $s3 $s1
    mul $s3 $s3 32
    add $s3 $s3 $s2
    mul $s3 $s3 4
    add $s4 $s4 $s3  
    
    lw $a0 colorGanado
    sw $a0, ($s4)
    
    add $s0, $s0, 4
    add $t2, $t2, 1
    b pintarNueve
    
saltarPintar:
    #Epilogo
    move $sp $fp
    lw $fp ($sp)
    jr $ra
    