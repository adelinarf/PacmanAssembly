.data
.text
#La funcion verificarCondicionesMovimiento verifica si la direccion a la que se quiere cambiar un fantasma esta permitida
#y calcula la distancia Manhattan de esta posicion deseada hasta Pacman, alojandola en movimientoFantasma.
#Las entradas de la funcion son:
# a0: Direccion a la que quiere cambiar el fantasma
# a1: Direccion a donde quiere llegar el fantasma
#Si la direccion contiene una pared, otro fantasma o un portal, se coloca su distancia como 1000 para que no se considere 
#al momento de calcular el minimo.
verificarCondicionesMovimiento:
        #Prologo
        sw $fp ($sp)
        move $fp $sp
        addi $sp $sp -4

        move $t0, $a0 
        move $t4, $a1 
        lw $t1 ($t0)        
                        
        lw $a0 colorPared
        beq $t1 $a0 terminar 
        
        lw $a0 colorPinky
        beq $t1 $a0 terminar
        lw $a0 colorBlinky
        beq $t1 $a0 terminar
        lw $a0 colorClyde
        beq $t1 $a0 terminar
        lw $a0 colorInky
        beq $t1 $a0 terminar
        lw $a0 colorModoEscape
        beq $t1 $a0 terminar
        lw $a0 colorPortal2
        beq $t1 $a0 terminar
        lw $a0 colorPortal3
        beq $t1 $a0 terminar
        
        #Para conseguir la posicion (x,y) basado en la direccion de memoria se usan los siguientes calculos:
        #Si D es la direccion en memoria que tenemos y queremos conseguir su posicion en la matriz para calcular
        # la distancia Manhattan.
        # x = D - 0x10008000 / 32*4
        # y = D - 0x10008000 / 4
        # En s1 esta la fila en s2 esta la columna
        # En t2 esta la fila y en t3 esta la columna de donde se quiere llegar
        lw $s0 MAT
        sub $s0 $t0 $s0
        div $s1 $s0 128
        div $s2 $s0 4
        lw $s0 MAT
        sub $s0 $t4 $s0
        div $t2 $s0 128
        div $t3 $s0 4
        
        sub $s1 $s1 $t2
        sub $s2 $s2 $t3
        abs $s1 $s1
        abs $s2 $s2

        add $s1 $s1 $s2

        move $v0 $s1
        #Epilogo
        move $sp $fp
        lw $fp ($sp)
        jr $ra
        
terminar:
        li $s1 -1
        li $s2 -1
        li $v0 1000
        #Epilogo
        move $sp $fp
        lw $fp ($sp)
        jr $ra

