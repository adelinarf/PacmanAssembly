.data
    colorModoEscape: .word 0x001F618D  #Color con el que se pintan los fantasmas durante el modoEscape
    colorPosicionAnterior: .word colorNegro,colorNegro,colorNegro,colorNegro
    .globl colorPosicionAnterior
.text
#La funcion moverFantasmas se encarga de ejecutar los procedimientos necesarios para el movimiento de cada uno 
#de los fantasmas del juego. Verifica si el juego se encuentra en modoEscape o no para modificar el movimiento de
#los fantasmas. Hay una etiqueta para manejar el movimiento de los fantasmas en modoEscape.
#Pinky tiene como objetivo el cuadro justo en frente de Pacman.
#Blinky tiene como objetivo llegar a la misma posicion de Pacman.
#Clyde tiene como objetivo llegar a dos lineas antes de la posicion de Pacman.
#Inky tiene como objetivo encerrar a Pacman entre Blinky y el y comienza a moverse cuando Pacman tiene 10 puntos.
#Esta funcion define las direcciones objetivo en las que deben estar los fantasmas para llegar a Pacman y 
#llama a la funcion moverFantasma para mover a cada uno de los fantasmas.
moverFantasmas:
    #Prologo
    sw $fp ($sp)
    move $fp $sp
    sw $ra -4($sp)
    addi $sp $sp -8
    
    lw $a0 modoEscape
    beq $a0 1 Escape
    
    li $a0 4
    lw $a1 colorPinky
    lw $a2 posicionesPersonajes + 0
    lw $t0 D
    lw $t1 arriba
    beq $t0 $t1 buscaArriba
    lw $t1 abajo
    beq $t0 $t1 buscaAbajo
    lw $t1 derecha
    beq $t0 $t1 buscaDerecha
    lw $t1 izquierda
    beq $t0 $t1 buscaIzquierda
buscaArriba:
    sub $a2, $a2, 128
    b movPinky
buscaAbajo:
    add $a2, $a2, 128
    b movPinky
buscaDerecha:
    add $a2, $a2, 4
    b movPinky
buscaIzquierda:
    sub $a2, $a2, 4    
movPinky:
    jal moverFantasma
    
    li $a0 8
    lw $a1 colorBlinky
    lw $a2 posicionesPersonajes + 0
    jal moverFantasma
    
    li $a0 12
    lw $a1 colorClyde
    lw $a2 posicionesPersonajes + 0
    add $a2 $a2 128
    add $a2 $a2 128
    jal moverFantasma
    
    lw $t0 puntos
    bge $t0 10 mueve
    
mueve:
    li $a0 16
    lw $a1 colorInky
    lw $a2 posicionesPersonajes + 0
    lw $t0 posicionesPersonajes + 8
    sub $a2 $a2 $t0
    abs $t0 $a2
    lw $a2 posicionesPersonajes + 0
    add $a2, $a2, $t0    
    jal moverFantasma
ep:
    #Epilogo
    move $sp $fp
    lw $fp ($sp)
    lw $ra -4($sp)
    jr $ra
#Si el juego se encuentra en modoEscape se ejecuta el movimiento de los fantasmas con esta etiqueta.
#Hay un arreglo llamado enModoEscape que contiene si cada fantasma se encuentra en modoEscape o no.
#Ya que al chocar un fantasma con Pacman, este fantasma sale del modoEscape y se modifica su movimiento.
#Si estan en modo escape:
#	Pinky escapa a la esquina izquierda arriba
#	Blinky escapa a la esquina derecha de arriba
#	Clyde escapa a la esquina izquierda de abajo
#	Inky escapa a la esquina derecha abajo
#
Escape:
    li $v0 0
    lw $a0, enModoEscape($v0)
    beq $a0 0 noEscapePinky
    lw $s0 MAT
    li $s1 0
    mul $s1 $s1 32
    add $s1 $s1 0
    mul $s1 $s1 4
    add $s0 $s0 $s1
   
    li $a0 4
    lw $a1 colorModoEscape
    move $a2 $s0 
    jal moverFantasma

escapeBlinky:
    li $v0 4
    lw $a0 enModoEscape($v0)
    beq $a0 0 noEscapeBlinky
    lw $s0 MAT
    li $s1 0
    mul $s1 $s1 32
    add $s1 $s1 31
    mul $s1 $s1 4
    add $s0 $s0 $s1
    
    li $a0 8
    lw $a1 colorModoEscape
    move $a2 $s0
    jal moverFantasma
   
escapeClyde:
    li $v0 8
    lw $a0 enModoEscape($v0)
    beq $a0 0 noEscapeClyde 
    lw $s0 MAT
    li $s1 31
    mul $s1 $s1 32
    add $s1 $s1 0
    mul $s1 $s1 4
    add $s0 $s0 $s1
    
    li $a0 12
    lw $a1 colorModoEscape
    move $a2 $s0
    jal moverFantasma
    
escapeInky:
    li $v0 12
    lw $a0 enModoEscape($v0)
    beq $a0 0 noEscapeInky
    lw $s0 MAT
    li $s1 31
    mul $s1 $s1 32
    add $s1 $s1 31
    mul $s1 $s1 4
    add $s0 $s0 $s1
    
    li $a0 16
    lw $a1 colorModoEscape
    move $a2 $s0
    jal moverFantasma
epilogoEscape:    
    #Epilogo
    move $sp $fp
    lw $fp ($sp)
    lw $ra -4($sp)
    jr $ra

#Si estan en modoEscape pero un fantasma en particular no esta en modoEscape, se mueven de la siguiente manera:
#	Pinky tiene como objetivo una posicion a la izquierda de Pacman
#	Blinky tiene como objetivo la posicion de Pacman
#	Clyde tiene como objetivo 8 posiciones a la derecha de Pacman
#	Inky tiene como objetivo la posicion tal que pueda atrapar junto a Blinky a Pacman
noEscapePinky:
    li $a0 4
    lw $a1 colorPinky
    lw $a2 posicionesPersonajes + 0
    sub $a2 $a2 4
    jal moverFantasma
    b escapeBlinky
noEscapeBlinky:
    li $a0 8
    lw $a1 colorBlinky
    lw $a2 posicionesPersonajes + 0
    jal moverFantasma
    b escapeClyde
noEscapeClyde:
    li $a0 12
    lw $a1 colorClyde
    lw $a2 posicionesPersonajes + 0
    add $a2 $a2 32
    jal moverFantasma
    b escapeInky
noEscapeInky:
    li $a0 16
    lw $a1 colorInky
    lw $a2 posicionesPersonajes + 0
    lw $t0 posicionesPersonajes + 8
    sub $a2 $a2 $t0
    abs $t0 $a2
    lw $a2 posicionesPersonajes + 0
    add $a2, $a2, $t0    
    jal moverFantasma
    b epilogoEscape
