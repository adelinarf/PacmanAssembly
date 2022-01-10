.data
    PausaLinea1 : .word 0,0,0,0,0,0,0,0,0,0,0,0
    PausaLinea2 : .word 0,0,0,0,0,0,0,0,0,0,0,0
    PausaLinea3 : .word 0,0,0,0,0,0,0,0,0,0,0,0
    PausaLinea4 : .word 0,0,0,0,0,0,0,0,0,0,0,0
    PausaLinea5 : .word 0,0,0,0,0,0,0,0,0,0,0,0
.text
#La funcion pintarPuntosEnPausa se encarga de pintar el puntaje acumulado hasta el momento de realizar la pausa del juego.
#Esta funcion pinta el fondo negro para los numeros y llama a la funcion pintarPuntuacion que se encarga de pintar los numeros.
#Ademas maneja la pausa, esperando una entrada de input del teclado con la tecla p (para detener la pausa) o q (para culminar
#el juego con seguir = 0). 
#Se pinta de negro la seccion de la matriz que abarca desde las filas 12 a 16 y las columnas 9 a 20. En este rectangulo se pintaran
#los 4 digitos que puede abarcar el puntaje del juego. Ademas se alojan los colores de cada cuadro en los word PausaLineai para poder
#retornar al juego sin problemas.
#Una vez se pulsa la tecla p se itera sobre cada uno de los word PausaLineai para recuperar el color del tablero antes de haber dado pausa
#al juego. Los word PausaLineai se guardan en los registros t3-t7.
pintarPuntosEnPausa:
    #Prologo
    sw $fp ($sp)
    move $fp $sp
    sw $ra -4($sp)
    addi $sp $sp -8
    
    lw $t2, colorNegro
    li $t3, 0 
    li $t4, 0
    li $t5, 0
    li $t6, 0
    li $t7, 0
    
    li $t0 9  #valor minimo de y
    li $t1 20 #valor maximo de y
    li $s0 12 #valor minimo de x
    li $s1 16 #valor maximo de x
    
iterarEnX:
    bgt $t0 $t1 cambioIteracion
    
    lw $s2 MAT
    move $s3 $s0
    mul $s3 $s3 32
    add $s3 $s3 $t0
    mul $s3 $s3 4
    add $s2 $s2 $s3
    
    lw $s4, ($s2)
    
    beq $s0, 12, primeraLinea
    beq $s0, 13, segundaLinea
    beq $s0, 14, terceraLinea
    beq $s0, 15, cuartaLinea
    beq $s0, 16, quintaLinea
    
primeraLinea:
    sw $s4, PausaLinea1($t3)
    add $t3, $t3, 4
    b continuarIteracionenX
    
segundaLinea:
    sw $s4, PausaLinea2($t4)
    add $t4, $t4, 4
    b continuarIteracionenX

terceraLinea:
    sw $s4, PausaLinea3($t5)
    add $t5, $t5, 4
    b continuarIteracionenX

cuartaLinea:
    sw $s4, PausaLinea4($t6)
    add $t6, $t6, 4
    b continuarIteracionenX

quintaLinea:
    sw $s4, PausaLinea5($t7)
    add $t7, $t7, 4
    b continuarIteracionenX

continuarIteracionenX:
    sw $t2, ($s2)
    
    add $t0 $t0 1
    b iterarEnX
    #pacman aparece en la posicion 20, 14
cambioIteracion:
    li $t0 9
    add $s0 $s0 1
    bgt $s0 $s1 terminaIterarEnY
    b iterarEnX

terminaIterarEnY:
    jal pintarPuntuacion
iterarEnPausa:
    lw $a0 teclaPresionada
    beq $a0 80 continuarJuegoPausa
    beq $a0 112 continuarJuegoPausa
    beq $a0 81 terminarJuegoPausa
    beq $a0 113 terminarJuegoPausa
    j iterarEnPausa
    nop
    
terminarJuegoPausa:
    li $a0 0
    lb $a0 seguir
    b lineaFinal
    
continuarJuegoPausa:
    li $a0 -1
    sw $a0 teclaPresionada
    sw $zero pausar
    
retornarColores:
    lw $s2 MAT
    li $s3 12
    mul $s3 $s3 32
    add $s3 $s3 9
    mul $s3 $s3 4
    add $s2 $s2 $s3 
    move $s4, $s2
    li $t0 0
    li $t1 0
coloresLinea1:
    beq $t1, 13, linea2 
    lw $s5, PausaLinea1($t0)
    sw $s5, ($s4)
    add $t0,$t0, 4
    add $s4,$s4, 4
    add $t1, $t1, 1
    b coloresLinea1
linea2:
    li $t1, 0
    li $t0, 0
    move $s4, $s2
    add $s4 $s4 128
coloresLinea2:
    beq $t1, 13, linea3 
    lw $s5, PausaLinea2($t0)
    sw $s5, ($s4)
    add $t0,$t0, 4
    add $s4,$s4, 4
    add $t1, $t1, 1
    b coloresLinea2
linea3:
    li $t1, 0
    li $t0, 0
    move $s4, $s2
    add $s4, $s4, 128
    add $s4, $s4, 128
coloresLinea3:
    beq $t1, 13, linea4 
    lw $s5, PausaLinea3($t0)
    sw $s5, ($s4)
    add $t0,$t0, 4
    add $s4,$s4, 4
    add $t1, $t1, 1
    b coloresLinea3
linea4:
    li $t1, 0
    li $t0, 0
    move $s4, $s2
    add $s4, $s4, 128
    add $s4, $s4, 128
    add $s4, $s4, 128
coloresLinea4:
    beq $t1, 13, linea5
    lw $s5, PausaLinea4($t0)
    sw $s5, ($s4)
    add $t0,$t0, 4
    add $s4,$s4, 4
    add $t1, $t1, 1
    b coloresLinea4
linea5:
    li $t1, 0
    li $t0, 0
    move $s4, $s2
    add $s4, $s4, 128
    add $s4, $s4, 128
    add $s4, $s4, 128
    add $s4, $s4, 128
coloresLinea5:
    beq $t1, 12, lineaFinal
    lw $s5, PausaLinea5($t0)
    sw $s5, ($s4)
    add $t0,$t0, 4
    add $s4,$s4, 4
    add $t1, $t1, 1
    b coloresLinea5
lineaFinal:
    
    #Epilogo
    move $sp $fp
    lw $fp ($sp)
    lw $ra -4($sp)
    jr $ra
