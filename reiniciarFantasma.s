.data 
.text
#La funcion reiniciarFantasma toma como valores de entrada:
# a0: Posicion del fantasma en posicionesPersonajes
# a1: Color del fantasma
# a2: Numero de fila en la que estara el personaje, ya que, todos los fantasmas inician en la misma columna de la matriz
# Se coloca el fantasma en su nueva posicion y luego se toma el color de su posicion anterior y se retorna al mismo color, 
# si la posicion anterior era el color de Pacman, se pinta de negro y si no se pinta color del mismo color que la comida de Pacman.
reiniciarFantasma:
        #Prologo
        sw $fp ($sp)
        move $fp $sp
        addi $sp $sp -4 
        
        #en $a0 esta la posicion del personaje
        #en $a1 esta el color
        #en $a2 el numero de fila
        move $t0 $a0
        move $t1 $a1
        move $t3 $a2
        
	lw $s4 posicionesPersonajes($t0)
	lw $s0 MAT
        move $s1 $t3        
        mul $s1 $s1 32
        add $s1 $s1 26
        mul $s1 $s1 4
        add $s0 $s0 $s1
        move $s6, $s0
        add $s6 $s6 4  
        
        move $t2, $t0
        sub $t2, $t2, 4                
        lw $a0, colorPosicionAnterior($t2)
        lw $a1, colorPacman        
        bne $a0 $a1 cambiarColor
        lw $a0 colorNegro 
        sw $a0,($s4)  
        sw $t1, ($s6)  
        sw $s6, posicionesPersonajes($t0)
        b salirdeFunc
cambiarColor:
        lw $a0 colorComida
        sw $a0,($s4)  
        sw $t1, ($s6) 
        sw $s6, posicionesPersonajes($t0)
salirdeFunc:
        #Epilogo
        move $sp $fp
        lw $fp ($sp)
        jr $ra