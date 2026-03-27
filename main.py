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

import sys
import json

from lexer import parseExpressao
from executor import executarExpressao
from assembly import gerarAssembly, salvarAssembly

TOKENS_FILE = "tokens.txt"


def lerArquivo(nome_arquivo):
    try:
        with open(nome_arquivo, "r", encoding="utf-8") as f:
            return f.readlines()
    except FileNotFoundError:
        # Caso o arquivo não exista, encerra o programa
        print(f"Erro: O arquivo '{nome_arquivo}' não foi encontrado.")
        sys.exit(1)


def exibirResultados(linhas_processadas, tokens_por_linha, status_list):
    print("\n=== RESULTADOS DA ANÁLISE ===\n")

    # Percorre todas as linhas validas e exibe informações
    for i, (linha, tokens, status) in enumerate(zip(linhas_processadas, tokens_por_linha, status_list), start=1):
        print(f"Linha {i}: {linha}")
        print(f"  Tokens: {tokens}")
        print(f"  Status: {status}\n")


# Salva todos os tokens validos em um arquivo JSON
def salvar_tokens(tokens_por_linha, nome_arquivo=TOKENS_FILE):
    try:
        with open(nome_arquivo, "w", encoding="utf-8") as f:
            json.dump(tokens_por_linha, f, indent=4, ensure_ascii=False)

        print(f"Tokens válidos salvos em '{nome_arquivo}'")

    except Exception as e:
        print(f"Erro ao salvar tokens: {e}")


# Função principal que controla todo o fluxo do programa
def processar_arquivo(nome_arquivo):

    historico_resultados = []

    tokens_por_linha = []

    linhas_validas = []

    status_list = []

    erros = 0

    tabela_simbolos = {}

    linhas = lerArquivo(nome_arquivo)

    print(f"\n=== PROCESSANDO ARQUIVO: {nome_arquivo} ===\n")

    # Percorre todas as linhas do arquivo
    for numero_linha, linha in enumerate(linhas, start=1):

        linha_str = linha.strip()

        if not linha_str:
            continue

        try:
            tokens = parseExpressao(linha_str)

            status = executarExpressao(tokens, historico_resultados, tabela_simbolos)

            historico_resultados.append(tokens) 
            
            tokens_por_linha.append(tokens)
            linhas_validas.append(linha_str)
            status_list.append(status)

        except ValueError as e:
            print(f"[ERRO] Falha na linha {numero_linha}: {linha_str}")
            print(f"       Detalhe: {e}\n")

            erros += 1
            continue

    if tokens_por_linha:
        exibirResultados(linhas_validas, tokens_por_linha, status_list)
    else:
        print("Nenhuma expressão válida para processar.")

    # Mostra quantidade de erros encontrados
    if erros > 0:
        print(f" Atenção: Foram encontrados {erros} erro(s) no arquivo.")
        print("   As linhas com erro foram ignoradas na geração do Assembly.\n")

    # Se existirem tokens validos gera os arquivos de saida
    if tokens_por_linha:

        salvar_tokens(tokens_por_linha)

        try:
            # Geração do codigo Assembly
            codigo_assembly = gerarAssembly(tokens_por_linha)

            # Salva o codigo em program.s
            salvarAssembly(codigo_assembly)

            print("Assembly gerado com sucesso em 'program.s'.")

        except Exception as e:
            print(f"Erro fatal ao gerar Assembly: {e}")

    else:
        print("Compilação abortada: Nenhuma entrada válida para gerar Assembly.")

    print("\n=== FIM DA EXECUÇÃO ===")

def main():

    if len(sys.argv) != 2:
        print("Uso correto: python main.py <arquivo.txt>")
        sys.exit(1)

    processar_arquivo(sys.argv[1])

if __name__ == "__main__":
    main()