.text


reset_tabuleiro:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    la $t0, board
    li $t1, '1'
    li $t2, 9
    
rt_loop:
    sb $t1, 0($t0)
    addi $t1, $t1, 1
    addi $t0, $t0, 1
    addi $t2, $t2, -1
    bnez $t2, rt_loop
    
    jal limpar_tela_grafica
    jal desenhar_grid
    
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

print_board:
    li $v0, 4
    la $a0, msg_tab
    syscall
    la $t0, board
    li $t1, 0
    
print_loop:
    lb $t2, 0($t0)
    beqz $t2, print_end
    li $v0, 11
    move $a0, $t2
    syscall
    addi $t1, $t1, 1
    beq $t1, 3, quebra
    beq $t1, 6, quebra
    addi $t0, $t0, 1
    j print_loop
    
quebra:
    li $v0, 4
    la $a0, quebraLinha
    syscall
    addi $t0, $t0, 1
    j print_loop
    
print_end:
    li $v0, 4
    la $a0, quebraLinha
    syscall
    jr $ra

ler_jogada:
    li $v0, 5
    syscall
    blt $v0, 1, jogada_erro_range
    bgt $v0, 9, jogada_erro_range
    jr $ra
jogada_erro_range:
    li $v0, 0
    jr $ra

atualizar_X:
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $a0, 4($sp) 

    la $t1, board
    addi $t0, $a0, -1
    add $t1, $t1, $t0
    lb $t2, 0($t1)
    beq $t2, 'X', invalidaX
    beq $t2, 'O', invalidaX
    
    li $t3, 'X'
    sb $t3, 0($t1)
    
    lw $a0, 4($sp)
    jal desenhar_X_grafico
    
    li $v0, 1
    lw $ra, 0($sp)
    addi $sp, $sp, 8
    jr $ra
    
invalidaX:
    li $v0, 0
    lw $ra, 0($sp)
    addi $sp, $sp, 8
    jr $ra

atualizar_O:
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $a0, 4($sp)

    la $t1, board
    addi $t0, $a0, -1
    add $t1, $t1, $t0
    lb $t2, 0($t1)
    beq $t2, 'X', invalidaO
    beq $t2, 'O', invalidaO
    
    li $t3, 'O'
    sb $t3, 0($t1)
    
    lw $a0, 4($sp)
    jal desenhar_O_grafico
    
    li $v0, 1
    lw $ra, 0($sp)
    addi $sp, $sp, 8
    jr $ra
    
invalidaO:
    li $v0, 0
    lw $ra, 0($sp)
    addi $sp, $sp, 8
    jr $ra

checar_vitoria:
    la $t0, board
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    lb $a0, 0($t0)
    lb $a1, 1($t0)
    lb $a2, 2($t0)
    jal check_three
    bnez $v0, cv_fim
    lb $a0, 3($t0)
    lb $a1, 4($t0)
    lb $a2, 5($t0)
    jal check_three
    bnez $v0, cv_fim
    lb $a0, 6($t0)
    lb $a1, 7($t0)
    lb $a2, 8($t0)
    jal check_three
    bnez $v0, cv_fim
    lb $a0, 0($t0)
    lb $a1, 3($t0)
    lb $a2, 6($t0)
    jal check_three
    bnez $v0, cv_fim
    lb $a0, 1($t0)
    lb $a1, 4($t0)
    lb $a2, 7($t0)
    jal check_three
    bnez $v0, cv_fim
    lb $a0, 2($t0)
    lb $a1, 5($t0)
    lb $a2, 8($t0)
    jal check_three
    bnez $v0, cv_fim
    lb $a0, 0($t0)
    lb $a1, 4($t0)
    lb $a2, 8($t0)
    jal check_three
    bnez $v0, cv_fim
    lb $a0, 2($t0)
    lb $a1, 4($t0)
    lb $a2, 6($t0)
    jal check_three
    
cv_fim:
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

check_three:
    beq $a0, $a1, ct_check2
    move $v0, $zero
    jr $ra
    
ct_check2:
    beq $a1, $a2, ct_check_player
    move $v0, $zero
    jr $ra
    
ct_check_player:
    beq $a0, 'X', ct_win_x
    beq $a0, 'O', ct_win_o
    move $v0, $zero
    jr $ra
    
ct_win_x:
    li $v0, 1
    jr $ra
    
ct_win_o:
    li $v0, 2
    jr $ra

checar_empate:
    la $t0, board
    li $t1, 0
    
emp_loop:
    lb $t2, 0($t0)
    beqz $t2, emp_fim
    beq $t2, 'X', cont
    beq $t2, 'O', cont
    move $v0, $zero
    jr $ra
    
cont:
    addi $t1, $t1, 1
    addi $t0, $t0, 1
    blt $t1, 9, emp_loop
    li $v0, 1
    jr $ra
    
emp_fim:
    move $v0, $zero
    jr $ra

# --- FUNCOES GRAFICAS (BITMAP) ---

limpar_tela_grafica:
    li $t0, 0x10040000 
    li $t1, 1024       
    lw $t2, COR_FUNDO
    
loop_limpa:
    sw $t2, 0($t0)
    addi $t0, $t0, 4
    addi $t1, $t1, -1
    bnez $t1, loop_limpa
    jr $ra

desenhar_grid:
    lw $t2, COR_GRID
    li $t3, 0        
    li $t4, 32 
          
loop_grid:
    li $a0, 10
    move $a1, $t3
    move $a2, $t2
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal pinta_pixel
    lw $ra, 0($sp)
    addi $sp, $sp, 4

    li $a0, 21
    move $a1, $t3
    move $a2, $t2
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal pinta_pixel
    lw $ra, 0($sp)
    addi $sp, $sp, 4

    move $a0, $t3
    li $a1, 10
    move $a2, $t2
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal pinta_pixel
    lw $ra, 0($sp)
    addi $sp, $sp, 4

    move $a0, $t3
    li $a1, 21
    move $a2, $t2
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    jal pinta_pixel
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    
    addi $t3, $t3, 1
    blt $t3, 32, loop_grid
    jr $ra

pinta_pixel:
    li $t0, 0x10040000 
    mul $t1, $a1, 32   
    add $t1, $t1, $a0  
    sll $t1, $t1, 2    
    add $t0, $t0, $t1  
    sw $a2, 0($t0)
    jr $ra

desenhar_X_grafico:

    la $t0, pos_coords
    sll $t1, $a0, 1     
    add $t0, $t0, $t1
    lb $t5, 0($t0)      
    lb $t6, 1($t0)      
    lw $t7, COR_X
    
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    move $a0, $t5
    move $a1, $t6
    move $a2, $t7
    jal pinta_pixel 
    
    addi $a0, $t5, -1
    addi $a1, $t6, -1
    jal pinta_pixel 
    
    addi $a0, $t5, 1
    addi $a1, $t6, 1
    jal pinta_pixel 
    
    addi $a0, $t5, -1
    addi $a1, $t6, 1
    jal pinta_pixel 
    
    addi $a0, $t5, 1
    addi $a1, $t6, -1
    jal pinta_pixel 
    
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

desenhar_O_grafico:

    la $t0, pos_coords
    sll $t1, $a0, 1
    add $t0, $t0, $t1
    lb $t5, 0($t0)      
    lb $t6, 1($t0)      
    lw $t7, COR_O
    
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    
    move $a0, $t5
    addi $a1, $t6, -1
    move $a2, $t7
    jal pinta_pixel 
    
    move $a0, $t5
    addi $a1, $t6, 1
    jal pinta_pixel 
    
    addi $a0, $t5, -1
    move $a1, $t6
    jal pinta_pixel 
    
    addi $a0, $t5, 1
    move $a1, $t6
    jal pinta_pixel 
    
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra