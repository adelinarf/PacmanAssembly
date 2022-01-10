.data
.text
#La funcion inicializaTableroNegro toma como entrada:
# t2: colorNegro
#Se pinta de color negro todo el tablero llamando a las funciones inicializarNegro y finalizarNegro.
#La salida de la funcion es todo el tablero pintado colorNegro.
inicializaTableroNegro:
     #Prologo
     sw $fp ($sp)
     move $fp $sp
     addi $sp $sp -4
    
     lw $t0 MAT
     lw $t2 colorNegro
     li $t1, 0
     sw $t2, ($t0)
inicializarNegro:
     beq $t1, 1024, finalizarNegro
     add $t0, $t0, 4
     add $t1, $t1, 1
     sw $t2, ($t0)
     b inicializarNegro
     
finalizarNegro:
     #Epilogo
     move $sp $fp
     lw $fp ($sp)
     jr $ra