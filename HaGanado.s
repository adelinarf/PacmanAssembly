.data
.text
HaGanado:
     #Prologo
     sw $fp ($sp)
     move $fp $sp
     sw $ra -4($sp)
     addi $sp $sp -8
     
     jal inicializarMatriz
     jal dibujaWon
     li $a0 0
esperandoGanar:
     beq $a0 2000 reiniciarNuevoJuegoGanar
     add $a0 $a0 1
     j esperandoGanar
     nop 
reiniciarNuevoJuegoGanar:
     li $a0 -1
     sw $a0 teclaPresionada
     li $a0 4
     sw $a0 V
     sw $zero puntos
     
     #Epilogo
     move $sp $fp
     lw $fp ($sp)
     lw $ra -4($sp)
     jr $ra