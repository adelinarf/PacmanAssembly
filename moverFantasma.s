.data
.text
#La funcion moverFantasma se encarga de mover un fantasma dada su posicion en el arreglo posicionesPersonajes, el color 
#del fantasma y la posicion a la que quiere llegar. 
#Sus entradas son:
# a0: Posicion del fantasma en el arreglo posicionesPersonajes
# a1: Color del fantasma
# a2: Posicion a la que el fantasma quiere llegar
# Dentro de esta funcion se llama a la funcion DistanciaManhattan que retorna la direccion en la que debe moverse el
#fantasma y se utiliza en la funcion DireccionAMoverFantasma para conocer la direccion en memoria en la que se guarda
#el color del fantasma.
#Luego se evaluan los casos del color que se encuentra actualmente en la posicion en que quiere pintarse el fantasma.
#Si la posicion tiene a Pacman se pierde una vida
#Si es un cuadro negro o de color comida, se pinta el fantasma 
#Si es el color de modoEscape se trata de otro fantasma y se ignora
moverFantasma:
        #Prologo
        sw $fp ($sp)
        move $fp $sp
        sw $ra -4($sp)
        addi $sp $sp -8
        
        move $s5 $a0 
        move $s6 $a1 
        move $a1, $a2 
        
        lw $a0 posicionesPersonajes($s5)
        
        jal DistanciaManhattan
        move $a0, $v1
        lw $a1 posicionesPersonajes($s5)
        
        jal DireccionAMoverFantasma
	
        move $t0, $v0  
        lw $t1, posicionesPersonajes($s5)
        
        lw $t2 ($t0)
        sub $a0 $s5 4
        sw $t2, colorPosicionAnterior($a0)
        
        lw $a0 colorPacman
        beq $t2, $a0, pierdeVidas
        lw $a0 colorNegro
        beq $t2, $a0, posicionaFantasma
        lw $a0 colorComida
        beq $t2, $a0, posicionaFantasma
        lw $a0 colorModoEscape
        beq $t2, $a0, buscaOtroCamino

buscaOtroCamino:
        b saltar
#Si el fantasma esta enModoEscape se retorna el fantasma a su posicion original y se hace modoEscape=0.
#Si no esta en modoEscape se pierde una vida y se reinicia el juego en las posiciones originales.
pierdeVidas:                
        sub $s7, $s5, 4
        lw $a0 enModoEscape($s7)
        beq $a0 1 localizarFantasma
        
        lw $s7 V
        sub $s7, $s7, 1
        sw $s7, V
        
        li $a0 1
        sw $a0 reiniciar
        
        b saltar
#Esta etiqueta posiciona al fantasma en su posicion inicial luego de chocar con el personaje en modoEscape
localizarFantasma:
        sw $zero, enModoEscape($s7)
        lw $s0 MAT
        div $s1 $s5 4
        add $s1 $s1 6
        mul $s1 $s1 32
        add $s1 $s1 27
        mul $s1 $s1 4
        add $s0 $s0 $s1
        
	lw $a0 colorNegro
	sw $a0, ($t1) 
	        
        beq $s7 0 coloreaPinky
        beq $s7 4 coloreaBlinky
        beq $s7 8 coloreaClyde
        beq $s7 12 coloreaInky
        b restaurarPosicion
coloreaPinky:
        lw $a0 colorPinky
        b restaurarPosicion
coloreaBlinky:
        lw $a0 colorBlinky
        b restaurarPosicion
coloreaClyde:
        lw $a0 colorClyde
        b restaurarPosicion
coloreaInky:
        lw $a0 colorInky
        b restaurarPosicion
        
restaurarPosicion:     
        sw $a0, ($s0)
	sw $s0, posicionesPersonajes($s5)
        b saltar 
#Esta etiqueta posiciona a fantasma en la direccion de memoria que hemos encontrado anteriormente y guarda el nuevo valor
#de su posicion en el arreglo posicionesPersonajes, ademas verifica si Pacman rodea al fantasma con una funcion llamada
#verificarSiPacmanRodea, si Pacman esta en los cuadros adyacentes, se pierde una vida y se reinicia.
posicionaFantasma:
        sw $s6, ($t0)  
        sub $a0 $s5 4   
        lw $s0 colorPosicionAnterior($a0)
        lw $t1, posicionesPersonajes($s5)
        sw $s0, ($t1)        
        sw $t0, posicionesPersonajes($s5)
        
        move $a0, $t0
        jal verificarSiPacmanRodea
        
        b saltar
       
saltar:
        #Epilogo
        move $sp $fp
        lw $fp ($sp)
        lw $ra -4($sp)
        jr $ra
