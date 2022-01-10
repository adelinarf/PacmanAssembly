.data
.text
#La funcion verificarSiPacmanRodea verifica si Pacman se encuentra a los lados o arriba o abajo del fantasma.
#Recibe como entrada:
# a0: Posicion del fantasma
#En caso de estar en modoEscape se ignora, para no reiniciar las posiciones de los fantasmas y perder vidas cuando
#no debe ocurrir. Si Pacman rodea al fantasma se coloca reiniciar en 1 para que al pintar de nuevo la pantalla se reinicien
#todas las posiciones de los personajes.
verificarSiPacmanRodea:
        #Prologo
        sw $fp ($sp)
        move $fp $sp
        addi $sp $sp -4
        
        move $t0, $a0 
        
        lw $a0 modoEscape
        beq $a0 1 epilogoRodear
        
        lw $s0, colorPacman

        sub $t1, $t0, 4

        add $t2, $t0, 4

        sub $t3, $t0, 128

        add $t4, $t0, 128
        lw $a0, ($t1)
        beq $a0, $s0, pacmanRodea
        lw $a0, ($t2)
        beq $a0, $s0, pacmanRodea    
        lw $a0, ($t3)
        beq $a0, $s0, pacmanRodea    
        lw $a0, ($t4)
        beq $a0, $s0, pacmanRodea
epilogoRodear:
        #Epilogo
        move $sp $fp
        lw $fp ($sp)
        jr $ra
        
pacmanRodea:
        lw $s7 V
        sub $s7, $s7, 1
        sw $s7, V
        
        li $a0 1
        sw $a0 reiniciar
        b epilogoRodear
