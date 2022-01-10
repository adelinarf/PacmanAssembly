	.data
#                                Variables utilizadas en el codigo
# seguir : Es un byte que indica si el ciclo principal del juego sigue 1 o termina 0.
# C : Es una variable que se utiliza para la conversion de ticks del reloj, se debe introducir la velocidad del procesador en Ghz.
# teclaPresionada : Es una variable que se modifica al ocurrir una interrupcion de teclado y se aloja el valor ASCII de la tecla.
# MAT : Es una variable que tiene la direccion base de la matriz
# S : Es una variable que indica cada cuantos segundos se actualiza la pantalla.
# D : Es una variable que indica la direccion en la que se mueve Pacman.
# V : Es una variable que indica el numero de vidas que tiene Pacman. 
# actualizar: Es una variable que indica si debe actualizarse 1 o no 0 la pantalla con los datos que se han calculado, se establece
# como 1 al momento de tener una interrupcion de timer.
# modoEscape: Es una variable que indica si el juego esta en modoEscape o no. El modo de escape es el que inicia al momento en que 
# Pacman come una superComida o superPastilla y puede comerse a los fantasmas.
# tiempoEscape: Es una variable que indica por cuantos ciclos de reloj durara el modo de escape.
# contadorEscape: Es una variable que aumenta en cada ciclo de reloj durante el modo de escape para verificar si se debe terminar o no.
# colorNegro, colorPacman, colorPared, colorSuperComida, colorPortal2, colorPortal3, colorComida, colorPinky, colorBlinky, colorClyde, 
# colorInky, colorGameOver y colorGanado son variables que indican el color para cada uno de los personajes y colores para el tablero.
# pausar: Esta variable indica si el juego debe ser pausado o no en el proximo ciclo de reloj.
# puntosAGanar: Esta variable indica el numero de puntos que debe tomar Pacman para ganar el juego.
# reiniciar: Esta variable indica si el juego debe reiniciar las posiciones de los personajes en el siguiente ciclo de reloj.
# arriba, abajo, izquierda, derecha : Son variables que indican las direcciones en las que puede moverse Pacman.
# direcciones : Es un arreglo que se utiliza para acceder con mayor facilidad a las variables arriba, abajo, izquierda y derecha que son 
# .asciiz.
# movimientoFantasma: Es un arreglo que se utiliza para alojar los valores de distancia entre Pacman y cierta posicion a la que se desea
# mover un fantasma. Se utiliza para conseguir su minimo valor y mover a los fantasmas.
# posicionesPersonajes: Es un arreglo que contiene la posicion actual de cada uno de los personajes en el orden: Pacman, Pinky, Blinky
# Clyde e Inky.
# enModoEscape: Es un arreglo que indica si un fantasma esta en modo escape o no. Esta ubicados en el orden Pinky, Blinky, Clyde e Inky.
# Ya que, al chocar con Pacman el fantasma deja de estar en modo escape y es necesaria una estructura para verificar si se encuentra en 
# dicho modo o no.
# puntos: Esta variable aloja el numero de puntos que tiene el jugador.
#
seguir:	.byte 1
C: .word 3 #velocidad del procesador en Ghz
teclaPresionada : .word 87
MAT : .word 0x10008000
S : .word 1
D : .ascii "A"
V : .word 3
actualizar : .word 0
modoEscape: .word 0
tiempoEscape: .word 100
contadorEscape : .word 0
colorNegro: .word 0x00000000
colorPacman: .word 0x00FEF016
colorPared: .word 0x00515A5A
colorSuperComida: .word 0x00E1BEE7
colorPortal2 : .word 0x00F4511E
colorPortal3: .word 0x00FF5722
colorComida: .word 0x00E8F8F5
colorPinky : .word 0x0033691E #fantasma verde
colorBlinky: .word 0x00FF0000 #fantasma rojo
colorClyde: .word 0x005D4037 #fantasma marron
colorInky: .word 0x0003A9F4 #tantasma azul
colorGameOver : .word 0x00FF6241
colorGanado: .word 0x006FEC50
pausar: .word 0
puntosAGanar: .word 576
reiniciar: .word 0
.align 2
arriba: .asciiz "A"
.align 2
abajo: .asciiz "B"
.align 2
izquierda: .asciiz "I"
.align 2
derecha: .asciiz "D"
.align 2
direcciones : .word arriba, abajo, izquierda, derecha
.align 2
movimientoFantasma : .word 0,0,0,0  
.align 2
posicionesPersonajes : .word 0, 0, 0, 0, 0
.align 2
enModoEscape : .word 0,0,0,0
.align 2
puntos: .word 0
.align 2
	.globl seguir
	.globl C
	.globl S
	.globl teclaPresionada
	.globl actualizar
	.globl main
	.globl arriba
	.globl abajo
	.globl izquierda
	.globl derecha
	.globl posicionesPersonajes
	.globl movimientoFantasma
	.globl modoEscape
	.globl enModoEscape
	.text
#En la funcion main del programa se llama a la funcion que crea la pantalla de inicio en la que se presiona la tecla S para comenzar
#el juego. Luego al iniciar, se inicializa la matriz del tablero con el color base, luego se pintan las paredes, las superComidas, 
#portales y finalmente se dibujan los personajes.
#Una vez se tiene el tablero de juego se inicia el ciclo que se mantendra mientras se juega, hasta presionar la tecla q.
#En este ciclo principal del juego, se llama a la funcion PacMan que contiene toda la logica del juego y retorna un valor $v0
#que sera 0 si continua el juego y 1 si debe reiniciarse y saltar de nuevo a la etiqueta main.
#La unica manera de terminar el juego es presionando la tecla q que convierte seguir = 0 y salta a la etiqueta Salir donde se termina
#el programa.
main:
        jal pantallaInicio
                           
        jal inicializarMatriz    
        jal tablero
        
        li $a0, 0x0000ff11 #0x0000ff11 #0x0000810f #0x0000ffff # Se activan las interrupciones de teclado y timer
        mtc0 $a0, $12
        li $a1 0xffff0000
        lw  $a0 ($a1)
        ori $a0 0x2
        sw  $a0 ($a1)
  
        jal dibujarPersonajes
Main:
	lb $t1 seguir
	beqz $t1 Salir
	nop

        jal PacMan
        move $t0, $v0
        beq $t0, 1, main

	b Main
	nop   
	
Salir:	
	li $v0 1
	la $a0 puntos
	syscall 
	
	li $v0 10
	syscall
.include "tablero.s"
.include "PacMan.s"
.include "ConseguirDireccion.s"
.include "inicializarMatriz.s"
.include "moverFantasmas.s"
.include "dibujarPersonajes.s"
.include "reinicioPosicionesFantasmas.s"
.include "GameOver.s"
.include "HaGanado.s"
.include "pantallaInicio.s"
.include "pintarPuntosEnPausa.s"
.include "pintarPuntuacion.s"
.include "pintarNumero.s"
.include "DireccionAMoverFantasma.s"
.include "verificarSiPacmanRodea.s"
.include "moverFantasma.s"
.include "DistanciaManhattan.s"
.include "verificarCondicionesMovimiento.s"
.include "dibujarGameOver.s"
.include "inicializaTableroNegro.s"
.include "dibujarWon.s"
.include "reiniciarFantasma.s"