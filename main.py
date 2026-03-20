import sys
from lexer import parseExpressao
from executor import executarExpressao
from assembly import gerarAssembly, salvarAssembly

# Função responsavel por ler o arquivo de entrada
def lerArquivo(nomeArquivo):

    try:
        with open(nomeArquivo, "r") as f:
            linhas = f.readlines()
        return linhas

    # Tratamento de erro caso o arquivo não exista
    except FileNotFoundError:
        print(f"Erro: arquivo '{nomeArquivo}' não encontrado.")
        sys.exit(1)

# Salva os tokens da ultima expressão processada
def salvarTokens(tokens):

    try:
        with open("tokens.txt", "w") as f:
            for t in tokens:
                f.write(t + "\n")

    except Exception as e:
        print(f"Erro ao salvar tokens: {e}")

# Exibe os resultados finais no terminal
def exibirResultados(resultados):

    print("\n===== RESULTADOS =====\n")

    for linha, r in resultados:
        print(f"Linha {linha}: {r:.1f}")

    print("\n======================\n")

def main():

    # Verifica se o usuario passou o arquivo como argumento
    if len(sys.argv) < 2:
        print("Uso: python main.py arquivoTeste.txt")
        sys.exit(1)

    nomeArquivo = sys.argv[1]

    linhas = lerArquivo(nomeArquivo)

    resultados = []
    linha_atual = 1

    # Guarda tokens para uso posterior
    tokensUltimaExecucao = []
    tokensTodasExpressoes = []

    # Processa cada linha do arquivo
    for linha in linhas:

        linha = linha.strip()

        # Ignora linhas vazias
        if not linha:
            continue

        try:
            # Etapa de analise lexica
            tokens = parseExpressao(linha)

            # Etapa de execução
            resultado = executarExpressao(tokens)

            resultados.append((linha_atual, resultado))

            tokensUltimaExecucao = tokens
            tokensTodasExpressoes.extend(tokens)

        except Exception as e:
            print(f"Erro na linha {linha_atual}: {e}")

        linha_atual += 1

    # Salva tokens da ultima expressão
    salvarTokens(tokensUltimaExecucao)

    # Gera codigo assembly baseado em todas expressões
    codigoAssembly = gerarAssembly(tokensTodasExpressoes)

    salvarAssembly(codigoAssembly)

    # Exibe resultados finais
    exibirResultados(resultados)

if __name__ == "__main__":
    main()