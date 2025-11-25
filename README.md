# ❌ Jogo da Velha MIPS ⭕

## Sobre o jogo:

Este projeto é uma implementação clássica do **Jogo da Velha (Tic-Tac-Toe)** desenvolvida inteiramente em **Assembly MIPS**. O diferencial deste projeto é a sua interface híbrida: a lógica e entrada de dados ocorrem via terminal, enquanto o estado do jogo é renderizado graficamente pixel a pixel utilizando a ferramenta **Bitmap Display**, demonstrando manipulação direta de memória e lógica de baixo nível.

-----

## 🚀 Configurando o Ambiente (MARS)

## ✅ Passo a passo

### 1\. Pré-requisitos

Você precisará do **MARS (MIPS Assembler and Runtime Simulator)** instalado em sua máquina. Ele é um arquivo `.jar` executável.

### 2\. Baixar os arquivos do projeto

Certifique-se de que os três arquivos principais estejam na mesma pasta, pois o `main.asm` depende dos outros dois:

  * `main.asm` (Arquivo principal)
  * `funcoes.asm` (Lógica e gráficos)
  * `dados.asm` (Variáveis e constantes)

### 3\. Configuração do Bitmap Display (Essencial)

O jogo escreve diretamente na memória Heap. Para visualizar, siga estes passos no MARS **antes** de rodar o jogo:

1.  Vá no menu **Tools** e selecione **Bitmap Display**.
2.  Configure exatamente com os valores abaixo:
      * **Unit Width in Pixels:** `16`
      * **Unit Height in Pixels:** `16`
      * **Display Width in Units:** `32`
      * **Display Height in Units:** `32`
      * **Base address for display:** `0x10040000 (heap)`
3.  Clique no botão **Connect to MIPS**.

### 4\. Executando o Jogo

1.  Abra o arquivo `main.asm` no MARS.
2.  Pressione \<kbd\>F3\</kbd\> (Assemble) para montar o código.
3.  Pressione \<kbd\>F5\</kbd\> (Run) para iniciar.
4.  Utilize a aba **Run I/O** para digitar as jogadas e veja o resultado na janela do **Bitmap Display**.

-----
 🧸 SOBRE O JOGO 🕹️

## 🕹️ Mecânica

### 👥 2 Jogadores (Hotseat)

  - O jogo alterna automaticamente entre o **Jogador X** (Vermelho) e o **Jogador O** (Azul).
  - A entrada é feita pelo console, escolhendo uma posição de **1 a 9**.
  - O objetivo é alinhar 3 símbolos na horizontal, vertical ou diagonal.

### 🗺️ Mapa de Teclas

O tabuleiro segue o layout numérico padrão:

| 1 | 2 | 3 |
|---|---|---|
| 4 | 5 | 6 |
| 7 | 8 | 9 |

-----

## 📋 Estados do Jogo

O jogo possui feedbacks visuais na **Barra de Status** (topo da tela gráfica):

  - **Vermelho:** Turno do Jogador X.
  - **Azul:** Turno do Jogador O.
  - **Verde:** Vitória confirmada.
  - **Cinza:** Empate (Velha).
-----
🛠️ TECNOLOGIAS UTILIZADAS

## 🛠️ Tecnologias e Ferramentas Utilizadas

Este jogo foi desenvolvido utilizando a linguagem **Assembly MIPS**, focando na arquitetura de computadores e manipulação de memória.

  - ⚙️ **Assembly MIPS**: Linguagem de baixo nível utilizada para toda a lógica, controle de fluxo e aritmética.
  - 🖥️ **MARS Simulator**: Simulador utilizado para montar e executar o código, além de prover as ferramentas de visualização de memória (Bitmap Display) e I/O (Syscalls).

**Conceitos aplicados:**

  * Manipulação de registradores e pilha (`$sp`, `$ra`).
  * Syscalls para entrada e saída.
  * Endereçamento de memória para desenho gráfico (Pixel Painting).
  * Modularização de código (`.include`).
-----
## 🫂 Desenvolvedores

| Nome | GitHub |
| ------------------------------------- | ------------------ |
| [**André Avelino**](https://github.com/avelinoandre) | @avelinoandre |
| [**Caio Mathews**](https://github.com/CaioMathews) | @caiomathews |
| [**Eduardo Albuquerque**](https://github.com/eduaab) | @eduaab |


-----
