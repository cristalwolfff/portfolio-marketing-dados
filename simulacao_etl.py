import pandas as pd
import re

def limpar_dados_clientes(arquivo_entrada, arquivo_saida):
    """
    Função de ETL para limpar a base de dados de clientes.
    Lê um CSV, trata os dados e salva um novo CSV limpo.
    """
    
    print(f"Iniciando processo de ETL do arquivo: {arquivo_entrada}")

    # 1. EXTRAÇÃO (Extract)
    # Tenta ler o CSV. Se não encontrar, gera um erro.
    try:
        df = pd.read_csv(arquivo_entrada)
    except FileNotFoundError:
        print(f"Erro: Arquivo {arquivo_entrada} não encontrado.")
        return

    # 2. TRANSFORMAÇÃO (Transform)
    
    # Remover duplicatas baseadas no e-mail (chave primária de marketing)
    df.drop_duplicates(subset='Email', keep='first', inplace=True)

    # Padronizar E-mails:
    # - Converte para minúsculo
    # - Corrige erros comuns (ex: '..com')
    df['Email'] = df['Email'].str.lower()
    df['Email'] = df['Email'].str.replace('..com', '.com', regex=False)

    # Padronizar Nomes:
    # - Converte para "Title Case" (Ex: "BRUNO COSTA" -> "Bruno Costa")
    df['Nome'] = df['Nome'].str.title()

    # Padronizar Telefones:
    # - Remove todos os caracteres não numéricos
    # - Usa regex para extrair apenas dígitos
    def limpar_telefone(tel):
        if pd.isna(tel):
            return None
        # Remove qualquer coisa que não seja dígito
        return re.sub(r'\D', '', str(tel))
        
    df['Telefone'] = df['Telefone'].apply(limpar_telefone)

    # Padronizar Cidades:
    # - Converte para "Title Case" (Ex: "uberlândia" -> "Uberlândia")
    df['Cidade'] = df['Cidade'].str.title()

    # Tratamento de Datas e Valores Nulos:
    # - Converte colunas de data para o formato datetime
    # - Preenche DataNascimento nula com uma data padrão (ex: 01-01-1900)
    #   para evitar erros em queries SQL.
    df['DataCadastro'] = pd.to_datetime(df['DataCadastro'])
    df['DataUltimaCompra'] = pd.to_datetime(df['DataUltimaCompra'])
    df['DataNascimento'] = pd.to_datetime(df['DataNascimento'], errors='coerce')
    df['DataNascimento'].fillna(pd.to_datetime('1900-01-01'), inplace=True)

    # 3. CARGA (Load)
    # Salva o DataFrame limpo em um novo arquivo CSV
    try:
        df.to_csv(arquivo_saida, index=False, encoding='utf-8')
        print(f"Processo de ETL concluído. Arquivo limpo salvo em: {arquivo_saida}")
    except Exception as e:
        print(f"Erro ao salvar o arquivo: {e}")

# --- Execução do Script ---
if __name__ == "__main__":
    limpar_dados_clientes('dados_brutos.csv', 'dados_limpos.csv')
