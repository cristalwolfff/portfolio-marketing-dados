/*
 * ===============================================
 * ARQUIVO DE SEGMENTAÇÃO SQL
 * ===============================================
 * * Estas queries simulam a segmentação de clientes
 * em uma Data Extension (SFMC) ou DBM, 
 * utilizando a base de dados limpa (dados_limpos.csv).
 *
 * Tabela Simulada: Clientes_Limpos
 */


-- Query 1: Clientes de Alto Valor (VIP) de Uberlândia
-- Objetivo: Enviar um convite para um evento local exclusivo.
SELECT 
    ClienteID,
    Nome,
    Email,
    TotalCompras
FROM 
    dados_limpos
WHERE 
    TotalCompras > 1500.00
    AND Cidade = 'Uberlândia';


-- Query 2: Clientes "Em Risco" (Churn Risk)
-- Objetivo: Campanha de reengajamento com cupom de desconto (ex: não compram há 90 dias).
SELECT 
    ClienteID,
    Email,
    DataUltimaCompra
FROM 
    dados_limpos
WHERE 
    DataUltimaCompra < date('now', '-90 days');


-- Query 3: Clientes Novos (Welcome Kit)
-- Objetivo: Incluir na jornada de "Boas-Vindas" (cadastro nos últimos 30 dias).
SELECT
    ClienteID,
    Nome,
    Email
FROM
    dados_limpos
WHERE
    DataCadastro >= date('now', '-30 days');


-- Query 4: Aniversariantes do Mês
-- Objetivo: Enviar campanha de feliz aniversário com brinde.
SELECT
    ClienteID,
    Nome,
    Email,
    DataNascimento
FROM
    dados_limpos
WHERE
    strftime('%m', DataNascimento) = strftime('%m', 'now')
    AND strftime('%Y', DataNascimento) != '1900';
