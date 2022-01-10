.data
.text
#La funcion PacMan se encarga de ejecutar la logica del juego en su totalidad, aqui se llaman a todas las funciones que forman
#parte del juego y se verifican los estados de todas las variables.
#Al inicio de la funcion se verifica cual es la direccion en la que debe moverse Pacman segun la variable teclaPresionada. Ademas se
#verifica si el juego esta pausado o no, si no esta pausado, se verifican la cantidad de vidas y de puntos para finalizar o ganar el 
#juego. Si el juego no debe finalizarse, ganarse o pausarse, se verifica si se reinicia, si no se debe reiniciar el juego se procede a
#actualizar las posiciones unicamente si se ha llegado a una interrupcion de timer donde se coloca actualizar = 1.
#La salida de esta funcion es 1 si se debe iniciar el juego desde el comienzo en el caso de haber ganado y presionar la teclar r
# y es 0 si solo debe ciclar el juego normalmente.
PacMan:
	#Prologo
        sw $fp ($sp)
        move $fp $sp
        sw $ra -4($sp)
        addi $sp $sp -8

	lw $t0 actualizar
	lw $a0 teclaPresionada
	jal ConseguirDireccion
	lw $a0 pausar
	beq $a0 1 ModoPausa
	sw $v0, D
	
	lw $a0 V
	beq $a0 $zero finJuego
	
	lw $a0 puntos
	lw $a1 puntosAGanar
	bge $a0 $a1 ganaJuego
	
	lw $a0 reiniciar
	beq $a0 1 ReiniciaJuego
		
	beq $t0 1 actualizarPosiciones #si actualizar es 1 se actualizan las posiciones de los personajes

        li $v0 0
finalPacMan:
	#Epilogo
        move $sp $fp
        lw $fp ($sp)
        lw $ra -4($sp)
        jr $ra
#Si pausa = 1 se pintan los puntos acumulados hasta el momento en la pantalla y se puede presionar p o q para volver al juego
#o terminar el juego.
ModoPausa:
        jal pintarPuntosEnPausa
        li $v0 0
        b finalPacMan        
#Si la variable V=0 se salta a esta etiqueta y se llama a la funcion GameOver que indica el fin del juego en donde se podra
#presionar la tecla r para reiniciar el juego o q para finalizar.
finJuego:
        jal GameOver
        li $v0 1
        b finalPacMan            
#Si la variable reiniciar = 1, se reinician las posiciones de cada uno de los personajes y se establece reiniciar=0 y se actualizan 
#las posiciones de los personajes nuevamente.
ReiniciaJuego:
        sw $t0 ($sp)
        jal reinicioPosicionesFantasmas
        lw $t0 ($sp)
        sw $zero reiniciar
        beq $t0 1 actualizarPosiciones
        li $v0 0
        b finalPacMan        
        
ganaJuego:
        jal HaGanado
        li $v0 1
        b finalPacMan 

#Si hay una interrupcion de timer se entra en esta etiqueta. Si el juego esta en modoEscape se suma el contador y se verifica si el 
#contador es igual a tiempoEscape, si es igual se establece el contador como 0 e igualmente la variable modoEscape.
#Si el juego no esta en modo escape, se verifica cual es la direccion en la que se esta moviendo Pacman.
actualizarPosiciones:
        lw $t5 D        
        lw $t4 direcciones
        lw $s0 ($t4)  #arriba, abajo, izquierda, derecha
        lw $s1 4($t4)
        lw $s2 8($t4)
        lw $s3 12($t4)            
        
        lw $s4 modoEscape
        beq $s4 1 modoEsc
        
modoEsc:
        lw $s5 contadorEscape
        add $s5, $s5, 1
        sw $s5 contadorEscape
        lw $a0 tiempoEscape
        bge $s5 $a0 terminarEscape 
casos:     
        beq $t5, $s0, moverArriba
        beq $t5, $s1, moverAbajo
        beq $t5, $s2, moverIzquierda
        beq $t5, $s3, moverDerecha
        
        b antesSaltar
        nop
terminarEscape:
        sw $zero modoEscape
        sw $zero contadorEscape
        b casos
        nop

moverArriba:
        #Si se mueve hacia arriba se resta a la direccion de Pacman 128 y se verifica si esta direccion contiene una pared, una
        #superComida, un portal o una comida regular. Hay etiquetas para cada uno de los casos.
                
        lw $s4 posicionesPersonajes        
        sub $s6, $s4, 128 
        lw $s7, ($s6)
        
        lw $a0 colorNegro
        beq $s7, $a0, movPacman  
        lw $a0 colorComida
        beq $s7, $a0, movPacmanSumar  
        lw $a0 colorPortal2
        beq $s7, $a0, movhacia3
        lw $a0 colorPortal3
        beq $s7, $a0, movhacia2
        lw $a0 colorSuperComida
        beq $s7, $a0, pastilla 
        lw $a0 colorPared
        beq $s7, $a0, noMover 

        b antesSaltar
        nop

#Esta etiqueta se accede al momento en que Pacman se come una superPastilla o superComida. Se modifica la posicion de Pacman en
#posicionesPersonajes a la posicion que originalmente tenia la pastilla y se colorea de negro el cuadro en donde se encontraba la
#pastilla. Luego se suman 10 puntos por la pastilla y se establece el juego en modo de escape, con cada uno de los fantasmas en 
#modo de escape.
pastilla:
        li $s0 0 
        lw $a0, colorNegro
        sw $a0, ($s4)  
        lw $a0, colorPacman
        sw $a0, ($s6)   
        sw $s6, posicionesPersonajes + 0  
        lw $s7 puntos
        add $s7, $s7, 10
        sw $s7, puntos
        li $a0 1
        sw $a0 modoEscape
        sw $a0, enModoEscape + 0
        sw $a0, enModoEscape + 4
        sw $a0, enModoEscape + 8
        sw $a0, enModoEscape + 12
        b antesSaltar
        nop

#Esta etiqueta mueve a Pacman desde el portal 2 hacia el 3. Coloca a Pacman una posicion a la derecha al lado del portal.
#En la posicion en la que se encontraba Pacman pinta negro y actualiza la posicion actual de Pacman en posicionesPersonajes.
movhacia3:
        lw $s0 MAT
        li $s1 29
        mul $s1 $s1 32
        add $s1 $s1 8
        mul $s1 $s1 4
        add $s0 $s0 $s1
        move $s6, $s0
        add $s6 $s6 4
        
        lw $a0, colorNegro
        sw $a0,($s4)  
        lw $a0, colorPacman
        sw $a0, ($s6)  
        sw $s6, posicionesPersonajes + 0
        b antesSaltar
        nop

#Esta etiqueta mueve a Pacman desde el portal 3 hacia el 2. Coloca a Pacman una posicion a la derecha al lado del portal.
#En la posicion en la que se encontraba Pacman pinta negro y actualiza la posicion actual de Pacman en posicionesPersonajes.
movhacia2:
        lw $s0 MAT
        li $s1 14
        mul $s1 $s1 32
        add $s1 $s1 28
        mul $s1 $s1 4
        add $s0 $s0 $s1
        move $s6, $s0
        add $s6 $s6 4
      
        lw $a0, colorNegro
        sw $a0, ($s4)  
        lw $a0, colorPacman
        sw $a0, ($s6)  
        sw $s6, posicionesPersonajes + 0 
        b antesSaltar
        nop
        
#Esta etiqueta mueve a Pacman en los casos en que el tablero no cuenta con ningun tipo de comida ni superComida.
movPacman:
        lw $a0, colorNegro
        sw $a0, ($s4)  
        lw $a0, colorPacman
        sw $a0, ($s6)  
        sw $s6, posicionesPersonajes + 0 
        b antesSaltar
        nop

#Esta etiqueta mueve a Pacman en los casos en que come la comida del tablero. Ademas suma 1 punto por cada cuadro de comida
#que come y los guarda en puntos.
movPacmanSumar:
        lw $a0 colorNegro
        sw $a0, ($s4) 
        lw $a0 colorPacman
        sw $a0, ($s6) 
        sw $s6, posicionesPersonajes + 0 
        lw $s7 puntos
        add $s7, $s7, 1
        sw $s7, puntos
        b antesSaltar
        nop

noMover:
        b antesSaltar
        nop
        
moverAbajo:
        #Si se mueve hacia abajo se suma a la direccion de Pacman 128 y se verifica si esta direccion contiene una pared, una
        #superComida, un portal o una comida regular. Hay etiquetas para cada uno de los casos.

        lw $s4 posicionesPersonajes        
        add $s6, $s4, 128
        lw $s7, ($s6)
        
        lw $a0 colorNegro
        beq $s7, $a0, movPacman 
        lw $a0 colorComida
        beq $s7, $a0, movPacmanSumar 
        lw $a0 colorPortal2
        beq $s7, $a0, movhacia3
        lw $a0 colorPortal3
        beq $s7, $a0, movhacia2
        lw $a0 colorSuperComida
        beq $s7, $a0, pastilla 
        lw $a0 colorPared
        beq $s7, $a0, noMover
        
        b antesSaltar
        nop
        
moverIzquierda:
        #Si se mueve hacia arriba se resta a la direccion de Pacman 4 y se verifica si esta direccion contiene una pared, una
        #superComida, un portal o una comida regular. Hay etiquetas para cada uno de los casos.

        lw $s4 posicionesPersonajes
        sub $s6, $s4, 4
        lw $s7, ($s6)
        
        lw $a0 colorNegro
        beq $s7, $a0, movPacman 
        lw $a0 colorComida
        beq $s7, $a0, movPacmanSumar
        lw $a0 colorPortal2
        beq $s7, $a0, movhacia3
        lw $a0 colorPortal3
        beq $s7, $a0, movhacia2
        lw $a0 colorSuperComida
        beq $s7, $a0, pastilla
        lw $a0 colorPared
        beq $s7, $a0, noMover 
        
        b antesSaltar
        nop
moverDerecha:
        #Si se mueve hacia arriba se suma a la direccion de Pacman 4 y se verifica si esta direccion contiene una pared, una
        #superComida, un portal o una comida regular. Hay etiquetas para cada uno de los casos.

        lw $s4 posicionesPersonajes
        add $s6, $s4, 4
        lw $s7, ($s6)
        
        lw $a0 colorNegro
        beq $s7, $a0, movPacman 
        lw $a0 colorComida
        beq $s7, $a0, movPacmanSumar 
        lw $a0 colorPortal2
        beq $s7, $a0, movhacia3
        lw $a0 colorPortal3
        beq $s7, $a0, movhacia2
        lw $a0 colorSuperComida
        beq $s7, $a0, pastilla
        lw $a0 colorPared
        beq $s7, $a0, noMover
        
        b antesSaltar
        nop
#En esta etiqueta se llama a la funcion moverFantasmas que se encargara de mover a cada uno de los fantasmas del juego.
#Antes de realizar un nuevo ciclo en el loop principal del juego, se establece actualizar como 0, para evitar actualizar la 
#pantalla en cada ciclo de reloj.
antesSaltar:
        sw $t1 ($sp)
        jal moverFantasmas
        lw $t1 ($sp)
        li $v0 0
        sw $v0, actualizar

        li $v0 0
        b finalPacMan 
