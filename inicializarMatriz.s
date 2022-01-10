.data
.text
inicializarMatriz:
     #Prologo
     sw $fp ($sp)
     move $fp $sp
     addi $sp $sp -4
     lw $t0 MAT
     lw $t2 colorComida
     li $t1, 0
     sw $t2, ($t0)
inicializa:
     beq $t1, 1024, finalInicializar
     add $t0, $t0, 4
     add $t1, $t1, 1
     sw $t2, ($t0)
     b inicializa

finalInicializar:
     #Epilogo
     move $sp $fp
     lw $fp ($sp)
     jr $ra
