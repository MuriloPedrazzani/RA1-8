# Interpretador RPN com Geração de Assembly ARMv7


## Instituição

Pontifícia Universidade Católica do Paraná — PUCPR

## Integrantes (ordem alfabética)

- Murilo Chandelier Pedrazzani - [@MuriloPedrazzani](https://github.com/MuriloPedrazzani)
- Ricardo Ryu Magalhães Makino - [@ryumakino](https://github.com/ryumakino)
- Ricardo Vinicius Moreira Vianna - [@ricaprof](https://github.com/ricaprof)


## Disciplina

Construção de Interpretadores


## Professor
Frank Alcantara


## Grupo no Canvas
RA1 8


## Descrição

Este projeto implementa a **Fase 1 de um compilador (front-end)** para expressões matemáticas em **Notação Polonesa Reversa (RPN)**, gerando código **Assembly ARMv7** compatível com o simulador **CPULATOR (modelo DE1-SOC)**.

### Regra de Ouro do Projeto
O sistema segue o modelo de **Stack Machine purista**:
- Nenhum cálculo matemático é realizado em Python.
- O Python atua apenas em:
  - Análise Léxica  
  - Validação Semântica  
  - Geração de Código  
- Toda execução ocorre na **FPU do processador ARM via Assembly gerado**.

O compilador também possui **tolerância a falhas**:
- Linhas com erro são isoladas.
- Não interrompem a execução das demais linhas válidas.

---

## Estrutura do Projeto
```text
project/
│
├── main.py          
├── lexer.py         
├── executor.py       
├── assembly.py      
├── teste_lexer.py   
├── teste1.txt        
├── teste2.txt
├── teste3.txt
├── tokens.txt        # Saída: tokens válidos (JSON)
└── program.s         # Saída: código Assembly gerado
```

---

## Fluxo de Execução

```text
Arquivo de Entrada (.txt)
        ↓
Lexer (FSM sem regex + Boundary Check)
        ↓
Executor (Validação Semântica e Estrutural)
        ↓
Gerador de Assembly (ARMv7)
        ↓
program.s
```

---

## Descrição dos Módulos

### 🔹 `main.py`
Orquestrador do compilador:
* Lê o arquivo de entrada.
* Processa linha a linha com tolerância a falhas.
* Executa lexer e validação semântica.
* Mantém histórico para o comando RES.
* Gera `tokens.txt` e `program.s` apenas com linhas válidas.

### 🔹 `lexer.py`
Analisador léxico baseado em FSM (sem regex):
* Tokenização da entrada.
* Validação de números (IEEE 754).
* Validação de variáveis (apenas maiúsculas).
* Validação de operadores.
* Boundary Checker (evita tokens inválidos como `123abc` ou `///`).

### 🔹 `executor.py`
Validação semântica usando pilha simulada:
* Não realiza cálculos.
* Garante conformidade com RPN.
* Detecta: Stack underflow, Divisão por zero (estática), Uso inválido de RES, Variáveis não inicializadas.
* Usa tuplas `("VAL", valor)` para simular execução sem ferir a regra do trabalho.

### 🔹 `assembly.py`
Gerador de código Assembly ARMv7:
* Stack Machine pura.
* IEEE 754 (double precision).
* Constant Pooling.
* Suporte a variáveis e histórico (RES).
* Execução real ocorre na FPU ARM (64 bits).

### 🔹 `teste_lexer.py`
Suíte de testes automatizados:
* Casos básicos e avançados.
* Edge cases (limites).
* Testes de carga.
* Relatório automático.

---

## Operações Suportadas

```text
+   soma
-   subtração
* multiplicação
/   divisão real
//  divisão inteira
%   resto
^   potência (expoente inteiro ≥ 0)
```

---

## Variáveis e Histórico

### 🔹 RES (Histórico)
Permite acessar resultados anteriores:
```text
(3.5 4.0 +)   @ resultado salvo
(0 RES)       @ acessa o mais recente
```
**Regras:**
* O índice deve ser inteiro.
* Deve existir no histórico.

### 🔹 Variáveis
```text
(10.5 X)   @ atribui valor a X
(X)        @ lê valor de X
```
**Regras:**
* Apenas letras maiúsculas.
* Deve ser inicializada antes da leitura.

---

## Execução

**Rodar o compilador:**
```bash
python main.py teste1.txt
```

**Rodar os testes:**
```bash
python teste_lexer.py
```

---

## Saídas Geradas
* `program.s` → código Assembly gerado para o processador.
* `tokens.txt` → tokens válidos serializados em formato JSON.

---

## Execução no CPULATOR
1. Acesse: [https://cpulator.01xz.net/?sys=arm-de1soc](https://cpulator.01xz.net/?sys=arm-de1soc)
2. Cole o conteúdo de `program.s`.
3. Pressione **F5** (Compile and Load).
4. Pressione **F3** (Run).

---

## Tratamento de Exceções em Hardware

Proteções implementadas diretamente no Assembly:
* Divisão por zero.
* Índices inválidos no RES.
* Expoentes inválidos.

**Comportamento de erro:** Caso alguma violação ocorra, o programa:
1. Desvia para a label `throw_error`.
2. Escreve `0x3FF` no endereço de memória `0xFF200000`.
3. **Acende todos os LEDs vermelhos da DE1-SOC** para alertar o usuário.
4. Interrompe a execução.

---

## Considerações Finais

Este projeto demonstra:
* Separação clara entre *front-end* e execução.
* Uso de arquitetura baseada em pilha (Stack Machine).
* Geração de código de baixo nível com alta fidelidade ao hardware (Assembly ARMv7 + FPU).
* Robustez arquitetural com tolerância a falhas.