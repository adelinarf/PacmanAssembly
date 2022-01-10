.data
.text
GameOver:
     #Prologo
     sw $fp ($sp)
     move $fp $sp
     sw $ra -4($sp)
     addi $sp $sp -8
     
     jal inicializarMatriz
     jal dibujaLost
     
esperandoEntrada:
     lw $a0 teclaPresionada
     beq $a0 82 reiniciarNuevoJuego
     beq $a0 114 reiniciarNuevoJuego
     beq $a0 81 terminaJuego
     beq $a0 113 terminaJuego
     j esperandoEntrada
     nop 
terminaJuego:
     li $a0 0
     lb $a0 seguir

reiniciarNuevoJuego:
     li $a0 -1
     sw $a0 teclaPresionada
     li $a0 4
     sw $a0 V
     sw $zero puntos
     
reiniciarJuegoPerdido:
     #Epilogo
     move $sp $fp
     lw $fp ($sp)
     lw $ra -4($sp)
     jr $ra
