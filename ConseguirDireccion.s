.data
.text
#La funcion ConseguirDireccion toma como valores de entrada:
# a0 : teclaPresionada
#Se verifican los distintos casos de importancia en el programa: Si es W,S,A,D,P o Q.
#Se incluyen casos para los valores ASCII de las letras en mayuscula y minuscula.
#Se retorna el valor en forma de asciiz para cada una de las direcciones a las que puede ir Pacman.
#En caso de las teclas p y q. Para la pausa se activa el bit de pausa = 1 y se establece teclaPresionada = -1.
#Para quit se carga el bit 0 en seguir para que finalice el programa.
ConseguirDireccion:
     #Prologo
    sw $fp ($sp)
    move $fp $sp
    addi $sp $sp -4
    
    beq $a0, 87, presionaW
    beq $a0, 119, presionaW

    beq $a0, 83, presionaS
    beq $a0, 115, presionaS

    beq $a0, 65, presionaA
    beq $a0, 97, presionaA

    beq $a0, 68, presionaD
    beq $a0, 100, presionaD

    beq $a0, 80, presionaP
    beq $a0, 112, presionaP

    beq $a0, 81, presionaQ
    beq $a0, 113, presionaQ
    
final:
    #Epilogo
    move $sp $fp
    lw $fp ($sp)
    jr $ra

presionaW:
    lw $v0 arriba
    b final    

presionaS:
    lw $v0 abajo
    b final

presionaA:
    lw $v0 izquierda
    b final

presionaD:
    lw $v0 derecha
    b final

presionaP:
    li $a0 1
    sw $a0 pausar
    li $a0 -1
    sw $a0 teclaPresionada
    b final
presionaQ:
    li $a0 0
    sb $a0 seguir
    b final
