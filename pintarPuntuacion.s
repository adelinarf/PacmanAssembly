.data
.text
#La funcion pintarPuntuacion se encarga de separar la puntuacion obtenida por el jugador por unidad, decena, centena y unidad de mil.
#Se aloja en $t2 la unidad del puntaje, obtenida al hacer la operacion puntos%10, se aloja en $t3 la decena al hacer la operacion
#puntos%100, se aloja en $t4 la centena al hacer la operacion puntos%1000 y se aloja la unidad de mil en $t5 al hacer la operacion
#puntos%10000. Para obtener los valores de cada uno, se resta por el anterior:
# $t3 = $t3 - $t2
# $t4 = $t4 - $t3 - $t2
# $t5 = $t5 - $t4 - $t3 - $t2 
# Si el resgitro da 0, es que no contiene un valor alli y finalmente se dividen por sus respectivos valores 10, 100, 1000, 10000.
# Asi se obtienes los valores separados de cada uno de los digitos. Luego se verifican varios casos para los que se pinta segun los 
# valores obtenidos que no sean 0 y se llama en cada caso a la funcion PintarNumero las veces que sea necesaria.
pintarPuntuacion:
    #Prologo
    sw $fp ($sp)
    move $fp $sp
    sw $ra -4($sp)
    addi $sp $sp -8
        
    lw $t0, puntos
    li $t1, 10
    div $t0, $t1
    mfhi $t2   
    li $t1, 100
    div $t0, $t1
    mfhi $t3 
    sub $t3, $t3, $t2
    li $t1, 1000
    div $t0, $t1
    mfhi $t4 
    sub $t4, $t4, $t3
    sub $t4, $t4, $t2
    li $t1, 10000
    div $t0, $t1
    mfhi $t5 
    sub $t5, $t5, $t4
    sub $t5, $t5, $t3
    sub $t5, $t5, $t2
    
    div $t3, $t3, 10
    div $t4, $t4, 100
    div $t5, $t5, 1000
    
    beq $t5, 0, centenaPuntos
    beq $t4, 0, decenaPuntos
    beq $t3, 0, unidadPuntos
    
milPuntos:
    #hay 4 numeros
    move $a1 $t2
    li $a0 0
    jal PintarNumero
    
    move $a1 $t3
    li $a0 3
    jal PintarNumero
    
    move $a1 $t4
    li $a0 6
    jal PintarNumero
    
    move $a1 $t5
    li $a0 9
    jal PintarNumero
    
    b SalirPintarPuntos
    
centenaPuntos:
    #hay solo 3 numeros
    beq $t4, 0, decenaPuntos
     
    move $a1 $t2
    li $a0 0
    jal PintarNumero
    
    move $a1 $t3
    li $a0 3
    jal PintarNumero
    
    move $a1 $t4
    li $a0 6
    jal PintarNumero
    
    b SalirPintarPuntos
    
decenaPuntos:
    #hay solo 2 numeros 
    beq $t3, 0, unidadPuntos
    
    move $a1 $t2
    li $a0 0
    jal PintarNumero
    
    move $a1 $t3
    li $a0 3
    jal PintarNumero
    
    b SalirPintarPuntos

unidadPuntos:
    move $a1 $t2
    li $a0 0
    jal PintarNumero
    
    b SalirPintarPuntos  
    
SalirPintarPuntos:
    #Epilogo
    move $sp $fp
    lw $fp ($sp)
    lw $ra -4($sp)
    jr $ra
    