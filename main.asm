.text
.globl main

j main 

main:
loop_principal:
    jal reset_tabuleiro
    li $v0, 4
    la $a0, msg_inicio
    syscall
    li $s0, 0

loop_jogo:
    beq $s0, 0, set_barra_X
    beq $s0, 1, set_barra_O

set_barra_X:
    li $a0, 0x00FF0000  
    jal desenhar_barra_status
    j turno_X

set_barra_O:
    li $a0, 0x000000FF 
    jal desenhar_barra_status
    j turno_O

turno_X:
    li $v0, 4
    la $a0, msg_jogador1
    syscall
    jal ler_jogada
    beqz $v0, jogada_invalida
    move $a0, $v0
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
    beqz $v0, jogada_invalida
    move $a0, $v0
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
    li $a0, 0x0000FF00 
    jal desenhar_barra_status
    
    jal print_board 
    li $v0, 4
    la $a0, msg_vitoriaX
    syscall
    j perguntar_novamente

ganhou_O:
    li $a0, 0x0000FF00 
    jal desenhar_barra_status

    jal print_board 
    li $v0, 4
    la $a0, msg_vitoriaO
    syscall
    j perguntar_novamente

empate:
    li $a0, 0x00888888 
    jal desenhar_barra_status

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
    beq $v0, 0, fim_real       

    li $v0, 4
    la $a0, msg_erro_input
    syscall
    j perguntar_novamente

fim_real:
    li $v0, 4
    la $a0, msg_final
    syscall
    li $v0, 10
    syscall

# --- INCLUDES ---
.include "dados.asm"
.include "funcoes.asm"
