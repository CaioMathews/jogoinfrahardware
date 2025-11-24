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
msg_erro_input: .asciiz "\nOpcao invalida! Digite 1 ou 0.\n"
quebraLinha: .asciiz "\n"

# Cores e Coordenadas 
COR_FUNDO: .word 0x00000000 # Preto
COR_GRID:  .word 0x00FFFFFF # Branco
COR_X:     .word 0x00FF0000 # Vermelho
COR_O:     .word 0x000000FF # Azul

# Tabela de coordenadas X,Y para as posicoes 1-9 (Logica 32x32)
pos_coords: .byte 0,0, 5,5, 16,5, 27,5, 5,16, 16,16, 27,16, 5,27, 16,27, 27,27
