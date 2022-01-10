.data
.text
#La funcion DistanciaManhattan toma como entrada:
# a0: Posicion del fantasma
# a1: Posicion en donde quiere estar el fantasma
# En esta posicion se hace una llamada a otra funcion llamada verificarCondicionesMovimiento, la que se encarga de calcular la 
# distancia Manhattan entre la posicion del fantasma y Pacman, esto se realiza para los cuadros que se encuentra arriba, abajo, a la
#derecha e izquierda del fantasma, luego se alojan en un arreglo llamado movimientoFantasma.
#Una vez se tienen las distancias en movimientoFantasma, se busca el minimo, el minimo de este arreglo, sera la posicion a la que el 
#fantasma debera moverse para acercarse a Pacman.
#La funcion retorna el minimo y el valor del arreglo, es decir, 0 si debe moverse a la derecha, 4 si es a la izquierda, 8 hacia
#arriba y 12 si debe moverse hacia abajo.
DistanciaManhattan:
        #Prologo
        sw $fp ($sp)
        move $fp $sp
        sw $ra -4($sp)
        addi $sp $sp -8
        
	move $t1, $a0
	move $t2, $a1
	lw $t4, movimientoFantasma
	
	add $t0 $t1 4   #posicion a la derecha
	move $a0 $t0
	move $a1, $t2
	sw $t4 -8($sp)
	sw $t1 -12($sp)
	sw $t2 -16($sp)
	jal verificarCondicionesMovimiento
	lw $t4 -8($sp)
	lw $t1 -12($sp)
	lw $t2 -16($sp)
	move $t0, $v0
	sw $t0, movimientoFantasma+0 
	
	sub $t0 $t1 4   #posicion a la izquierda
	move $a0 $t0
	move $a1, $t2
	sw $t4 -8($sp)
	sw $t1 -12($sp)
	sw $t2 -16($sp)
	jal verificarCondicionesMovimiento
	lw $t4 -8($sp)
	lw $t1 -12($sp)
	lw $t2 -16($sp)
	move $t0, $v0
	sw $t0, movimientoFantasma+4 
	
	sub $t0 $t1 128  #posicion a la arriba
	move $a0 $t0
	move $a1, $t2
	sw $t4 -8($sp)
	sw $t1 -12($sp)
	sw $t2 -16($sp)
	jal verificarCondicionesMovimiento
	lw $t4 -8($sp)
	lw $t1 -12($sp)
	lw $t2 -16($sp)
	move $t0, $v0
	sw $t0, movimientoFantasma + 8 
	
	add $t0 $t1 128  #posicion a la abajo
	move $a0 $t0
	move $a1, $t2
	sw $t4 -8($sp)
	sw $t1 -12($sp)
	sw $t2 -16($sp)
	jal verificarCondicionesMovimiento
	lw $t4 -8($sp)
	lw $t1 -12($sp)
	lw $t2 -16($sp)
	move $t0, $v0
	sw $t0, movimientoFantasma + 12 
	
	
	lw $t0, movimientoFantasma
	li $t1, 100000
	li $t3 0
	li $t4 0 
	
minimo:
        bge $t3, 16, minimoencontrado
        lw $t2, movimientoFantasma($t3)
        ble $t2, $t1, esminimo
        addi $t3, $t3, 4
        
        j minimo
esminimo:
        move $t1, $t2
        move $t4, $t3
        add $t3, $t3, 4
        j minimo
minimoencontrado:        
        move $v0 $t1
        move $v1 $t4
	
        #Epilogo
        move $sp $fp
        lw $fp ($sp)
        lw $ra -4($sp)
        jr $ra