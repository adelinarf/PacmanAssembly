.data
p :  .word 0x00000000
.text 
pastillita1:
#Aparece pastilla en  21,28
    #Prologo
    sw $fp ($sp)
    move $fp $sp
    addi $sp $sp -4
    
    lw $s0 MAT
    li $s1 21
    lw $t1 colorSuperComida
    mul $s1 $s1 32
    add $s1 $s1 28
    mul $s1 $s1 4
    add $s0 $s0 $s1
    sw $t1, ($s0)
    sw $s0, p
    move $s4, $s0
    
pastillita2:
#Aparece pastilla en  4,28
    lw $s0 MAT
    li $s1 21
    lw $t1 colorSuperComida
    mul $s1 $s1 32
    add $s1 $s1 4
    mul $s1 $s1 4
    add $s0 $s0 $s1
    sw $t1, ($s0)
    sw $s0, p
    move $s4, $s0
    
pastillita3:
#Aparece pastilla en  4,4
    lw $s0 MAT
    li $s1 4
    lw $t1 colorSuperComida
    mul $s1 $s1 32
    add $s1 $s1 4
    mul $s1 $s1 4
    add $s0 $s0 $s1
    sw $t1, ($s0)
    sw $s0, p
    move $s4, $s0
    
pastillita4:
#Aparece pastilla en  4,28
    lw $s0 MAT
    li $s1 4
    lw $t1 colorSuperComida
    mul $s1 $s1 32
    add $s1 $s1 28
    mul $s1 $s1 4
    add $s0 $s0 $s1
    sw $t1, ($s0)
    sw $s0, p
    move $s4, $s0          
    
    #Epilogo
    move $sp $fp
    lw $fp ($sp)
    jr $ra
    
