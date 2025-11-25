# ❌ Jogo da Velha MIPS ⭕

## Sobre o jogo:

Este projeto é uma implementação clássica do **Jogo da Velha (Tic-Tac-Toe)** desenvolvida inteiramente em **Assembly MIPS**. O diferencial deste projeto é a sua interface híbrida: a lógica e entrada de dados ocorrem via terminal, enquanto o estado do jogo é renderizado graficamente pixel a pixel utilizando a ferramenta **Bitmap Display**, demonstrando manipulação direta de memória e lógica de baixo nível.

-----

# 📂 Estrutura do Projeto

Aqui está uma explicação geral do que cada ficheiro e as suas funções principais realizam no projeto.  
O código está dividido de forma **modular**:

- O **`main.asm`** controla o fluxo do jogo (*o “quê” acontece*).  
- O **`funcoes.asm`** executa as tarefas específicas (*o “como” acontece*).
- O **`dados.asm`** armazena as variáveis e constantes essenciais (o "com o quê" acontece).
---

## 1. `main.asm` — *O Gestor do Jogo*

Este ficheiro contém o **ponto de entrada** (`main`) e o **ciclo principal** do jogo.  
Ele não desenha nem calcula vitórias diretamente; ele apenas define *quando* cada etapa ocorre.

### 🔄 Loops principais
- **`loop_principal` & `loop_jogo`**  
  Reiniciam o jogo e alternam entre os turnos dos jogadores.

### 🎨 Barra de turno
- **`set_barra_X` / `set_barra_O`**  
  Mudam a cor da barra superior (vermelho ou azul) indicando o jogador da vez.

### 🎮 Turnos
- **`turno_X` / `turno_O`**  
  - Pedem ao jogador um número.  
  - Chamam `atualizar_X` ou `atualizar_O`.  
  - Chamam `checar_vitoria`.  
  - Se ninguém ganhou, passam o turno com `troca_turno`.

### 🏁 Estados finais
- **`ganhou_X` / `ganhou_O` / `empate`**  
  - Mostram a mensagem final.  
  - Mudam a barra (Verde = vitória, Cinza = empate).  
  - Perguntam se deseja jogar novamente.

---

## 2. `funcoes.asm` — *A Lógica e os Gráficos*

Este ficheiro contém as funções mais importantes do jogo, divididas entre backend lógico e desenho gráfico.

---

### A. 🔧 **Lógica do Jogo**

- **`reset_tabuleiro`**  
  Reinicia o array `"123456789"`, limpa a tela gráfica e redesenha a grelha.

- **`ler_jogada`**  
  Lê input com syscall 5 e valida se está entre 1 e 9.

- **`atualizar_X` / `atualizar_O`**  
  Valida a posição, atualiza o `board` e desenha o símbolo no ecrã.

- **`checar_vitoria`**  
  Verifica linhas, colunas e diagonais usando `check_three`.

- **`checar_empate`**  
  Se não houver mais números (só X e O), declara empate.

---

### B. 🖼️ **Funções Gráficas (Bitmap Display)**

Estas funções escrevem diretamente em **`0x10040000`**, pintando pixel a pixel.

- **`limpar_tela_grafica`** – Pinta tudo de preto.  
- **`desenhar_grid`** – Desenha as quatro linhas brancas do tabuleiro.  
- **`pinta_pixel`** – Pinta um pixel específico (base para tudo).  
- **`desenhar_X_grafico` / `desenhar_O_grafico`** – Desenham os símbolos usando `pos_coords`.  
- **`desenhar_barra_status`** – Pinta a barra no topo indicando turnos e resultados.

---

# 🚀 Configurando o Ambiente (MARS)

## ✅ Passo a passo

### 1. Pré-requisitos
Baixe o **MARS (MIPS Assembler and Runtime Simulator)** – é um `.jar`.

### 2. Arquivos necessários
Coloque estes 3 arquivos **na mesma pasta**:

- `main.asm`  
- `funcoes.asm`  
- `dados.asm`

### 3. Configurar o Bitmap Display
Antes de iniciar o jogo:

1. Tools → **Bitmap Display**  
2. Configure:
   - Unit Width: `8`  
   - Unit Height: `8`  
   - Display Width: `256`  
   - Display Height: `256`  
   - Base address: `0x10040000 (heap)`
3. Clique em **Connect to MIPS**

### 4. Executando
1. Abra `main.asm`  
2. <kbd>F3</kbd> – Assemble  
3. <kbd>F5</kbd> – Run  
4. Digite as jogadas na aba **Run I/O**  
5. Veja o resultado no **Bitmap Display**

---

# 🧸 SOBRE O JOGO 🕹️

## 🕹️ Mecânica

### 👥 2 Jogadores
- Alternância automática entre **X (vermelho)** e **O (azul)**  
- Jogadas de **1 a 9**  
- Objetivo: completar 3 em linha

---

## 🗺️ Mapa de Teclas

| 1 | 2 | 3 |
|---|---|---|
| 4 | 5 | 6 |
| 7 | 8 | 9 |

---

# 📋 Estados do Jogo

A barra no topo indica:

- 🔴 **Vermelho:** Jogador X  
- 🔵 **Azul:** Jogador O  
- 🟢 **Verde:** Vitória  
- ⚪ **Cinza:** Empate  

---

# 🛠️ Tecnologias Utilizadas

- ⚙️ **Assembly MIPS** – lógica e processamento  
- 🖥️ **MARS** – execução, Bitmap Display e I/O  

### Conceitos aplicados
- Uso de registradores e pilha  
- Syscalls  
- Escrita direta na memória gráfica  
- Modularização com `.include`

---

# 🫂 Desenvolvedores

| Nome | GitHub | Email |
|------|--------|--------|
| **André Avelino** | @avelinoandre | aafo@cesar.school |
| **Caio Mathews** | @caiomathews | cmmf@cesar.school |
| **Eduardo Albuquerque** | @eduaab | eaab@cesar.school |

---
