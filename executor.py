import math

memoria = {}

historico = []

def executarExpressao(tokens):

    # Pilha usada para avaliação
    stack = []

    for token in tokens:

        if token in ["(", ")"]:
            continue

        if token.replace('.', '', 1).isdigit():
            stack.append(float(token))
            continue

        # Operações basicas
        if token == "+":
            if len(stack) < 2:
                raise ValueError("Erro: pilha insuficiente para operação '+'")

            b = stack.pop()
            a = stack.pop()
            stack.append(a + b)
            continue

        if token == "-":
            if len(stack) < 2:
                raise ValueError("Erro: pilha insuficiente para operação '-'")

            b = stack.pop()
            a = stack.pop()
            stack.append(a - b)
            continue

        if token == "*":
            if len(stack) < 2:
                raise ValueError("Erro: pilha insuficiente para operação '*'")

            b = stack.pop()
            a = stack.pop()
            stack.append(a * b)
            continue

        if token == "/":
            if len(stack) < 2:
                raise ValueError("Erro: pilha insuficiente para operação '/'")

            b = stack.pop()
            a = stack.pop()

            if b == 0:
                raise ValueError("Erro: divisão por zero")

            stack.append(a / b)
            continue

        # Divisão inteira
        if token == "//":
            if len(stack) < 2:
                raise ValueError("Erro: pilha insuficiente")

            b = int(stack.pop())
            a = int(stack.pop())

            if b == 0:
                raise ValueError("Erro: divisão inteira por zero")

            stack.append(a // b)
            continue

        # Resto
        if token == "%":
            if len(stack) < 2:
                raise ValueError("Erro: pilha insuficiente")

            b = int(stack.pop())
            a = int(stack.pop())

            if b == 0:
                raise ValueError("Erro: resto por zero")

            stack.append(a % b)
            continue

        # Potencia
        if token == "^":
            if len(stack) < 2:
                raise ValueError("Erro: pilha insuficiente")

            b = int(stack.pop())
            a = stack.pop()

            if b < 0:
                raise ValueError("Expoente negativo não suportado")

            stack.append(a ** b)
            continue

        # Recupera valor do historico
        if token == "RES":
            if len(stack) < 1:
                raise ValueError("RES requer índice")

            n = int(stack.pop())

            if n < 0 or n >= len(historico):
                raise ValueError("RES inválido")

            stack.append(historico[-(n + 1)])
            continue

        # Variaveis
        if token.isalpha():

            if token in memoria:
                stack.append(memoria[token])
            else:
                if len(stack) == 0:
                    raise ValueError(f"Variável '{token}' não inicializada")

                memoria[token] = stack.pop()
                stack.append(memoria[token])

            continue

        raise ValueError(f"Token inválido: {token}")

    # Expressão deve resultar em apenas um valor
    if len(stack) != 1:
        raise ValueError("Expressão malformada")

    resultado = stack.pop()

    # Verifica resultado invalido
    if math.isnan(resultado) or math.isinf(resultado):
        raise ValueError("Resultado inválido")

    # Salva no histórico
    historico.append(resultado)

    return resultado