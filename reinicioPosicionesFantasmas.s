.data
.text
#La funcion reinicioPosicionesFantasmas retorna los fantasmas a sus posiciones originales al inicio del juego.
#Se utiliza al momento de chocar con Pacman y perder una vida, si el juego se encuentra en modoEscape, se desactiva
#para todos los fantasmas.
#Se reinicia la posicion de cada uno de los fantasmas con una llamada a la funcion reiniciarFantasma.
#Tambien se reinicia la posicion de Pacman a la inicial del juego.
reinicioPosicionesFantasmas:
        #Prologo
        sw $fp ($sp)
        move $fp $sp
        sw $ra -4($sp)
        addi $sp $sp -8
        
        #PACMAN        
        lw $s0 MAT
        li $s1 20
        mul $s1 $s1 32
        add $s1 $s1 14
        mul $s1 $s1 4
        add $s0 $s0 $s1
        move $s6, $s0
        add $s6 $s6 4
                
        lw $a0 colorNegro
        lw $a1 posicionesPersonajes + 0
        sw $a0, ($a1)
        
        lw $a0 colorPacman
        sw $a0, ($s6)
        sw $s6, posicionesPersonajes+0
        
        li $a0 4
        lw $a1 colorPinky
        li $a2 6
        lw $s7 puntos
        add $s7, $s7, 10
        sw $s7, puntos
        jal reiniciarFantasma
        
        li $a0 8
        lw $a1 colorBlinky
        li $a2 7
        lw $s7 puntos
        add $s7, $s7, 10
        sw $s7, puntos        
        jal reiniciarFantasma        
        
        li $a0 12
        lw $a1 colorClyde
        li $a2 8
        lw $s7 puntos
        add $s7, $s7, 10
        sw $s7, puntos        
        jal reiniciarFantasma 
        
        li $a0 16
        lw $a1 colorInky
        li $a2 9
        lw $s7 puntos
        add $s7, $s7, 10
        sw $s7, puntos
        jal reiniciarFantasma 
        
        lw $a0 arriba
        sw $a0 D
        
        sw $zero modoEscape
        sw $zero contadorEscape
        li $a0 0
        sw $zero enModoEscape($a0)
        li $a0 4
        sw $zero enModoEscape($a0)
        li $a0 8
        sw $zero enModoEscape($a0)
        li $a0 12
        sw $zero enModoEscape($a0)
                
        #Epilogo
        move $sp $fp
        lw $fp ($sp)
        lw $ra -4($sp)
        jr $ra
