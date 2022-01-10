.data
.text
#La funcion DireccionAMoverFantasma toma como entrada:
# a0: Posicion en movimientoFantasma que tendra el fantasma
# a1: Posicion actual del fantasma
#Se verifica si el valor de a0 es 0,4,8 o 12 para saber si se movera a derecha, izquierda, arriba o abajo respectivamente.
#Y luego se suman los valores adecuados a la direccion en memoria del fantasma para obtener su nueva posicion.
#La salida de la funcion es la nueva direccion de memoria en la que se pintara el fantasma.
DireccionAMoverFantasma:
    #Prologo
    sw $fp ($sp)
    move $fp $sp
    addi $sp $sp -4
    
    move $t0 $a0   
    
    move $t1 $a1 
    beq $t0, 0, mueveADerecha
    beq $t0, 4, mueveAIzquierda
    beq $t0, 8, mueveAArriba
    beq $t0, 12, mueveAAbajo
    b salidaFuncion

mueveADerecha:
    add $t1, $t1, 4
    b salidaFuncion
    
mueveAIzquierda:
    sub $t1, $t1, 4
    b salidaFuncion
    
mueveAArriba:
    sub $t1, $t1, 128
    b salidaFuncion

mueveAAbajo:
    add $t1, $t1, 128
    b salidaFuncion
    
salidaFuncion:
    move $v0, $t1
    #Epilogo
    move $sp $fp
    lw $fp ($sp)
    jr $ra
