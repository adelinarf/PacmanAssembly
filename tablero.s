.data  
fin: .asciiz "tablero.txt"
buffer: .space 1
line: .space 1024
D1 : .word 0x00000000
.text
tablero:
    #Prologo
    sw $fp ($sp)
    move $fp $sp
    sw $ra -4($sp)
    addi $sp $sp -8
    
    jal dibujarPortal2
    
construirTablero:
    lw $s6, MAT
    la $s1 buffer
    la $s2 line
    li $s3 0      # current line length

    # open file
    li $v0 13     # syscall for open file
    la $a0 fin    # input file name
    li $a1 0      # read flag
    li $a2 0      # ignore mode 
    syscall       # open file 
    move $s0 $v0  # save the file descriptor 
    
read_loop:

    # read byte from file
    li $v0 14     # syscall for read file
    move $a0 $s0  # file descriptor 
    move $a1 $s1  # address of dest buffer
    li $a2 1      # buffer length
    syscall       # read byte from file

    # keep reading until bytes read <= 0
    blez $v0 read_done

    # naively handle exceeding line size by exiting
    slti $t0 $s3 1024
    beqz $t0 read_done

    # if current byte is a newline, consume line
    lb $s4 ($s1)
    li $t0 10
    beq $s4 $t0 consume_line

    # otherwise, append byte to line
    add $s5 $s3 $s2
    sb $s4 ($s5)

    # increment line length
    addi $s3 $s3 1

    b read_loop

consume_line:

    # null terminate line
    add $s5 $s3 $s2
    sb $zero ($s5)

    # reset bytes read
    li $s3 0

    # print line (or consume it some other way)
    move $a0 $s2
    #li $v0 4
    #syscall
    
    lb $t1, ($s2)
    lb $t2, 1($s2)
    lb $t3, 2($s2)
    lb $t4, 3($s2)
    move $s7 $t2
    
    #beq $t1, 48, read_done
    
    beq $t1 32 salta
    sub $t1, $t1, 48
    mul $t1, $t1, 10
    move $t2, $t1
    beq $t3 32 columna
    move $t2 $s7
    subi $t3, $t3, 48
    mul $t3, $t3, 10
    
    
    sub $t2 $t2 48
    add $t2, $t2, $t1
    
    sub $t4, $t4, 48
    add $t4, $t3, $t4
    b modificarMatriz
    
salta:
    #solo se considera t2    
    sub $t2, $t2, 48
    b columna2
columna2:
    subi $t4, $t4, 48
    beq $t3 32 modificarMatriz
    subi $t3 $t3 48
    mul $t3 $t3 10
    add $t4 $t3 $t4
    b modificarMatriz
    
columna:
    subi $t4, $t4, 48
    subi $t2, $s7, 48
    add $t2, $t2, $t1
    beq $t3 32 modificarMatriz
    subi $t3 $t3 48
    mul $t3 $t3 10
    add $t4 $t3 $t4
    b modificarMatriz
    
modificarMatriz:
    #addr = baseAddress + (rowIndex * colSize + colIndex)*datasize
    #li $v0 1
    #move $a0 $t2
    #syscall
    #li $v0 1
    #move $a0 $t4
    #syscall
    li $s7 0
    lw $a0, MAT
    add $s7, $s7, $a0
    mul $t2, $t2, 32 #32 es el numero de columnas
    add $t2, $t2, $t4
    mul $t2, $t2, 4 #datasize es el tamano de la direccion
    add $s7, $s7, $t2
           
    lw $t1 colorPared #0x00ff0f00
    sw $t1, ($s7)
    # print newline
    b loop
loop:
    li $a0 10
    li $v0 11
    syscall

    b read_loop

read_done:
    # close file
    li $v0 16     # syscall for close file
    move $a0 $s0  # file descriptor to close
    syscall       # close file
    b finalizar
finalizar:
    #Epilogo
    move $sp $fp
    lw $fp ($sp)
    lw $ra -4($sp)
    jr $ra

.include "portales.s"
