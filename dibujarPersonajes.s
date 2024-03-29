.data
.text
#La funcion toma como entrada:
#Las variables posicionesPersonajes, colorBlinky, colorInky, colorClyde, colorPinky, colorPacman
#Se busca la posicion de los personajes que son 7, 27; 9,27; 8,27, 6,27 y 20,14, en las cuales se le 
#asigna los colores respectivos en posicionesPersonajes 8, 16, 12, 4, 0, respectivamente.
#La salida es que los personajes son pintados en las posiciones 20,14; 6,27; 7,27; 8,27; 9,27.
dibujarPersonajes:
        #Prologo
        sw $fp ($sp)
        move $fp $sp
        addi $sp $sp -4
        #pacman aparece en la posicion 20, 14
        lw $s0 MAT
        li $s1 20
        lw $t1 colorPacman
        mul $s1 $s1 32
        add $s1 $s1 14
        mul $s1 $s1 4
        add $s0 $s0 $s1
        sw $t1, ($s0)
        lw $t2, posicionesPersonajes
        sw $s0, posicionesPersonajes+0
        
        #pinky aparece en la posicion 6, 27
        lw $s0 MAT
        li $s1 6
        lw $t1 colorPinky
        mul $s1 $s1 32
        add $s1 $s1 27
        mul $s1 $s1 4
        add $s0 $s0 $s1
        sw $t1, ($s0)
        sw $s0, posicionesPersonajes + 4
        
        #blinky aparece en la posicion 7, 27
        lw $s0 MAT
        li $s1 7
        lw $t1 colorBlinky
        mul $s1 $s1 32
        add $s1 $s1 27
        mul $s1 $s1 4
        add $s0 $s0 $s1
        sw $t1, ($s0)
        sw $s0, posicionesPersonajes + 8
        
        #clyde aparece en la posicion 8, 27
        lw $s0 MAT
        li $s1 8
        lw $t1 colorClyde
        mul $s1 $s1 32
        add $s1 $s1 27
        mul $s1 $s1 4
        add $s0 $s0 $s1
        sw $t1, ($s0)
        sw $s0, posicionesPersonajes + 12
        
        #inky aparece en la posicion 9, 27
        lw $s0 MAT
        li $s1 9
        lw $t1 colorInky
        mul $s1 $s1 32
        add $s1 $s1 27
        mul $s1 $s1 4
        add $s0 $s0 $s1
        sw $t1, ($s0)
        sw $s0, posicionesPersonajes + 16
        
        #Epilogo
        move $sp $fp
        lw $fp ($sp)
        jr $ra
