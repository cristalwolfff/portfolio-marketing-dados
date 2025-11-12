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
    Clientes_Limpos
WHERE 
    TotalCompras > 1500.00
    AND Cidade = 'Uberlandia';


-- Query 2: Clientes "Em Risco" (Churn Risk)
-- Objetivo: Campanha de reengajamento com cupom de desconto (ex: não compram há 90 dias).
SELECT 
    ClienteID,
    Email,
    DataUltimaCompra
FROM 
    Clientes_Limpos
WHERE 
    DataUltimaCompra < DATE_SUB(CURDATE(), INTERVAL 90 DAY);


-- Query 3: Clientes Novos (Welcome Kit)
-- Objetivo: Incluir na jornada de "Boas-Vindas" (cadastro nos últimos 30 dias).
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
SELECT
    ClienteID,
    Nome,
    Email,
    DataNascimento
FROM
    Clientes_Limpos
WHERE
    MONTH(DataNascimento) = MONTH(CURDATE())
    AND YEAR(DataNascimento) != 1900; -- Exclui os que não tinham data
