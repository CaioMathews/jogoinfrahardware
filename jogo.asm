.data
board: .asciiz "123456789"
msg_inicio: .asciiz "\n=== JOGO DA VELHA ===\n"
msg_tab: .asciiz "\nTabuleiro atual:\n"
msg_jogador1: .asciiz "\nJogador X, escolha uma posicao (1-9): "
msg_jogador2: .asciiz "\nJogador O, escolha uma posicao (1-9): "
msg_invalida: .asciiz "\nPosicao invalida! Tente novamente.\n"
msg_vitoriaX: .asciiz "\nJogador X venceu!\n"
msg_vitoriaO: .asciiz "\nJogador O venceu!\n"
msg_empate: .asciiz "\nEmpate!\n"
msg_final: .asciiz "\nFim de jogo.\n"
msg_replay: .asciiz "\nDeseja jogar novamente? (1-Sim, 0-Nao): "
quebraLinha: .asciiz "\n"

.text
.globl main

main:

loop_principal:
    
    jal reset_tabuleiro

    li $v0, 4
    la $a0, msg_inicio
    syscall

    li $s0, 0 

loop_jogo:
    jal print_board

    beq $s0, 0, turno_X
    beq $s0, 1, turno_O

turno_X:
    li $v0, 4
    la $a0, msg_jogador1
    syscall
    jal ler_jogada
    move $t0, $v0
    jal atualizar_X
    beqz $v0, jogada_invalida
    jal checar_vitoria
    beq $v0, 1, ganhou_X
    j troca_turno

turno_O:
    li $v0, 4
    la $a0, msg_jogador2
    syscall
    jal ler_jogada
    move $t0, $v0
    jal atualizar_O
    beqz $v0, jogada_invalida
    jal checar_vitoria
    beq $v0, 2, ganhou_O
    j troca_turno

jogada_invalida:
    li $v0, 4
    la $a0, msg_invalida
    syscall
    j loop_jogo

troca_turno:
    xori $s0, $s0, 1
    jal checar_empate
    bnez $v0, empate
    j loop_jogo

ganhou_X:
    jal print_board 
    li $v0, 4
    la $a0, msg_vitoriaX
    syscall
    j perguntar_novamente 

ganhou_O:
    jal print_board 
    li $v0, 4
    la $a0, msg_vitoriaO
    syscall
    j perguntar_novamente

empate:
    jal print_board 
    li $v0, 4
    la $a0, msg_empate
    syscall
    j perguntar_novamente

perguntar_novamente:
    li $v0, 4
    la $a0, msg_replay
    syscall

    li $v0, 5       
    syscall

    beq $v0, 1, loop_principal 
    
    j fim_real

fim_real:
    li $v0, 4
    la $a0, msg_final
    syscall
    li $v0, 10
    syscall


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
    move $v0, $v0
    jr $ra

atualizar_X:
    la $t1, board
    addi $t0, $t0, -1
    add $t1, $t1, $t0
    lb $t2, 0($t1)
    beq $t2, 'X', invalidaX
    beq $t2, 'O', invalidaX
    li $t3, 'X'
    sb $t3, 0($t1)
    li $v0, 1
    jr $ra
invalidaX:
    move $v0, $zero
    jr $ra

atualizar_O:
    la $t1, board
    addi $t0, $t0, -1
    add $t1, $t1, $t0
    lb $t2, 0($t1)
    beq $t2, 'X', invalidaO
    beq $t2, 'O', invalidaO
    li $t3, 'O'
    sb $t3, 0($t1)
    li $v0, 1
    jr $ra
invalidaO:
    move $v0, $zero
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

reset_tabuleiro:
    la $t0, board        
    li $t1, '1'          
    li $t2, 9            
rt_loop:
    sb $t1, 0($t0)       
    addi $t1, $t1, 1     
    addi $t0, $t0, 1     
    addi $t2, $t2, -1    
    bnez $t2, rt_loop    
    jr $ra              