"""
Gerador de Assembly ARMv7 (CPULATOR) com suporte a IEEE754 64 bits

Integrantes (ordem alfabética):
Murilo Chandelier Pedrazzani - https://github.com/MuriloPedrazzani
Ricardo Ryu Magalhães Makino - https://github.com/ryumakino
Ricardo Vinicius Moreira Vianna - https://github.com/ricaprof

Grupo no Canvas: RA1 8
Disciplina: Construção de Interpretadores
Professor: Frank Alcantara

"""

OPERADORES = {"+", "-", "*", "/", "//", "%", "^"}

def is_numero(token):
    try:
        float(token) 
        return True
    except ValueError:
        return False

def is_variavel(token):
    return token.isalpha() and token.isupper() and token != "RES"

def executarExpressao(tokens, historico, tabela_simbolos):

    pilha_semantica = []

    # Percorre todos os tokens gerados pelo lexer
    for token in tokens:

        if token == "(":
            pilha_semantica.append("(")

        elif token == ")":
            escopo = []

            while pilha_semantica and pilha_semantica[-1] != "(":
                escopo.insert(0, pilha_semantica.pop())

            if not pilha_semantica:
                raise ValueError("Erro Sintático: Parênteses desbalanceados.")

            pilha_semantica.pop() 

            if len(escopo) == 3 and escopo[0][0] == "VAL" and escopo[1][0] == "VAL" and escopo[2][0] == "OP" and escopo[2][1] in OPERADORES:
                operador = escopo[2][1]
                divisor_literal = escopo[1][1]

                if operador in ["/", "//", "%"]:
                    if divisor_literal in ["0", "0.0", "-0", "-0.0"]:
                        raise ValueError(f"Erro Semântico: Divisão por zero estática detectada no literal '{divisor_literal}'.")

                pilha_semantica.append(("VAL", "resultado_simulado"))

            # Caso de uso do comando RES para acessar historico
            elif len(escopo) == 2 and escopo[0][0] == "VAL" and escopo[1][0] == "RES":
                try:
                    n_val = int(float(escopo[0][1]))
                except ValueError:
                    raise ValueError(f"Erro Semântico: O índice para RES deve ser um número inteiro. Recebido: {escopo[0][1]}")

                # Verifica se existe valor suficiente no historico
                if n_val < 0 or n_val >= len(historico):
                    raise ValueError(f"Erro Semântico: Histórico insuficiente para ({n_val} RES). Linhas em histórico: {len(historico)}")
                    
                pilha_semantica.append(("VAL", "valor_historico"))

            elif len(escopo) == 2 and escopo[0][0] == "VAL" and escopo[1][0] == "VAR":
                nome_var = escopo[1][1]

                tabela_simbolos[nome_var] = "alocado" 
                pilha_semantica.append(("VAL", "valor_escrito"))

            elif len(escopo) == 1 and escopo[0][0] == "VAR":
                nome_var = escopo[0][1]

                if nome_var not in tabela_simbolos:
                    tabela_simbolos[nome_var] = "alocado_implicito"

                pilha_semantica.append(("VAL", "valor_lido"))

            elif len(escopo) == 1 and escopo[0][0] == "VAL":
                pilha_semantica.append(escopo[0])

            # Caso a estrutura não corresponda a nenhuma regra valida
            else:
                tipos = [e[0] for e in escopo]
                raise ValueError(f"Erro Semântico: Regra de formação RPN inválida neste escopo: {tipos}")

        elif is_numero(token):
            pilha_semantica.append(("VAL", token))

        elif token == "RES":
            pilha_semantica.append(("RES", "RES"))

        elif is_variavel(token):
            pilha_semantica.append(("VAR", token))

        elif token in OPERADORES:
            pilha_semantica.append(("OP", token))

        else:
            raise ValueError(f"Erro Léxico/Semântico: Token desconhecido -> '{token}'")

    # Ao final da analise a pilha deve ter apenas um valor resultante
    if len(pilha_semantica) != 1 or pilha_semantica[0][0] != "VAL":
        raise ValueError(f"Erro Estrutural: A expressão não pôde ser completamente resolvida. Pilha final -> {pilha_semantica}")

    return "Válida (Resolvido para Assembly)"