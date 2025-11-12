# portfolio-marketing-dados
Portfólio de projetos de simulação para Marketing. Demonstra um processo de ETL usando Python (Pandas) para limpar uma base de clientes e, em seguida, usa SQL (Queries) para criar segmentações de audiência, simulando um ambiente de DBM ou Salesforce Marketing Cloud (SFMC).

꧁∙·▫ₒₒ▫ᵒᴼᵒ▫ₒₒ▫꧁ PORTFÓLIO DE SIMULAÇÃO: ETL e Segmentação para Marketing ꧂▫ₒₒ▫ᵒᴼᵒ▫ₒₒ▫·∙꧂


Este repositório demonstra minhas habilidades práticas em Python e SQL aplicadas a um cenário comum de Marketing e CRM, alinhado aos requisitos de vagas de Analista de Marketing técnico.

✧･ﾟ: *✧･ﾟ:* 　OBJETIVO DO PROJETO　 *:･ﾟ✧*:･ﾟ✧

Simular o processo completo de ETL (Extract, Transform, Load) e Segmentação de uma base de clientes, preparando os dados para campanhas personalizadas em plataformas como o Salesforce Marketing Cloud (SFMC).

•◌•◌•◌•◌•◌•◌•◌•★•◌•◌•◌•◌•◌•◌•◌••◌•◌•◌•◌•◌•◌•◌•★•◌•◌•◌•◌•◌•◌•◌••◌•◌•◌•◌•◌•◌•◌•★•◌•◌•◌•◌•◌•◌•◌••◌•◌•◌•◌•◌•◌•◌•★•◌•◌•◌•◌•◌•◌•◌••◌•◌•◌•◌•◌•◌•◌•★•◌•◌•◌•◌•◌•◌•◌••◌•◌•◌•◌•◌•◌•◌•
A "história" é a seguinte:
•◌•◌•◌•◌•◌•◌•◌•★•◌•◌•◌•◌•◌•◌•◌••◌•◌•◌•◌•◌•◌•◌•★•◌•◌•◌•◌•◌•◌•◌••◌•◌•◌•◌•◌•◌•◌•★•◌•◌•◌•◌•◌•◌•◌••◌•◌•◌•◌•◌•◌•◌•★•◌•◌•◌•◌•◌•◌•◌••◌•◌•◌•◌•◌•◌•◌•★•◌•◌•◌•◌•◌•◌•◌••◌•◌•◌•◌•◌•◌•◌•

☆ Dados Brutos (dados_brutos.csv): Recebemos uma base de clientes despadronizada e com erros.

☆ ETL com Python (simulacao_etl.py): Usamos a biblioteca Pandas (Python) para limpar, transformar e carregar os dados em um formato limpo e pronto para uso.

☆ Segmentação com SQL (segmentacao.sql): Usamos queries SQL para segmentar a base limpa (simulando uma Data Extension do SFMC) e criar audiências para campanhas.

•◌•◌•◌•◌•◌•◌•◌•★•◌•◌•◌•◌•◌•◌•◌••◌•◌•◌•◌•◌•◌•◌•★•◌•◌•◌•◌•◌•◌•◌••◌•◌•◌•◌•◌•◌•◌•★•◌•◌•◌•◌•◌•◌•◌••◌•◌•◌•◌•◌•◌•◌•★•◌•◌•◌•◌•◌•◌•◌••◌•◌•◌•◌•◌•◌•◌•★•◌•◌•◌•◌•◌•◌•◌••◌•◌•◌•◌•◌•◌•◌•
1. ETL com Python (simulacao_etl.py)

O script Python (utilizando a biblioteca Pandas) é responsável por pegar a base de dados dados_brutos.csv e prepará-la para ser usada em campanhas.

► Processos realizados no script:

Extração: Carregamento dos dados do arquivo dados_brutos.csv.

► Transformação (Limpeza):

Remoção de clientes duplicados (baseado no email).

Padronização de strings (ex: e-mails em minúsculo, nomes com primeira letra maiúscula).

Correção de erros de digitação comuns (ex: @gmail..com -> @gmail.com).

Padronização de números de telefone (removendo caracteres como (, ), -).

Tratamento de valores ausentes (ex: data_nascimento nula).

► Carga (Load):

Exportação da base tratada para um novo arquivo: dados_limpos.csv.

•◌•◌•◌•◌•◌•◌•◌•★•◌•◌•◌•◌•◌•◌•◌••◌•◌•◌•◌•◌•◌•◌•★•◌•◌•◌•◌•◌•◌•◌••◌•◌•◌•◌•◌•◌•◌•★•◌•◌•◌•◌•◌•◌•◌••◌•◌•◌•◌•◌•◌•◌•★•◌•◌•◌•◌•◌•◌•◌••◌•◌•◌•◌•◌•◌•◌•★•◌•◌•◌•◌•◌•◌•◌••◌•◌•◌•◌•◌•◌•◌•
2. Segmentação com SQL (segmentacao.sql)

As queries SQL abaixo demonstram como a base dados_limpos.csv (agora limpa e estruturada) seria consultada para criar segmentações de audiência.

► Exemplos de Queries:

-- Query 1: Clientes de Alto Valor (VIP) de Uberlândia
-- Objetivo: Enviar um convite para um evento local.
SELECT 
    ClienteID,
    Nome,
    Email
FROM 
    Clientes_Limpos
WHERE 
    TotalCompras > 1500.00
    AND Cidade = 'Uberlandia';

-- Query 2: Clientes "Em Risco" (Não compram há mais de 90 dias)
-- Objetivo: Campanha de reengajamento com cupom de desconto.
SELECT 
    ClienteID,
    Email,
    DataUltimaCompra
FROM 
    Clientes_Limpos
WHERE 
    DataUltimaCompra < DATE_SUB(CURDATE(), INTERVAL 90 DAY);

-- Query 3: Clientes Novos (Cadastro nos últimos 30 dias)
-- Objetivo: Incluir na jornada de "Boas-Vindas" (Welcome Kit).
SELECT 
    ClienteID,
    Nome,
    Email
FROM 
    Clientes_Limpos
WHERE 
    DataCadastro >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

-- Query 4: Aniversariantes do Mês
-- Objetivo: Enviar campanha de feliz aniversário com brinde.
-- (Assumindo que o campo data_nascimento foi tratado)
SELECT
    ClienteID,
    Nome,
    Email,
    DataNascimento
FROM
    Clientes_Limpos
WHERE
    MONTH(DataNascimento) = MONTH(CURDATE());
