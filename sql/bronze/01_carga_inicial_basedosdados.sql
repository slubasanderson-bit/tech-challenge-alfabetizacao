-- Código SQL recuperado do histórico do BigQuery (não reexecutado nesta revisão).
-- Job ID: job_LfdJk4OJcHJc4aCWRJCaX4uZ5vW4 | Status no índice: EXECUTADO SEM ERRO.
-- ATENÇÃO: carga inicial com CREATE TABLE IF NOT EXISTS, não atualiza fonte nem preserva versões em reexecuções.

-- 1. Dados individuais dos alunos
CREATE TABLE IF NOT EXISTS
  `heroic-bucksaw-513517-p9.bronze.alunos`
PARTITION BY DATE(data_ingestao)
AS
SELECT
    *,
    CURRENT_TIMESTAMP() AS data_ingestao,
    'oficial_basedosdados' AS origem
FROM
  `basedosdados.br_inep_avaliacao_alfabetizacao.alunos`;

-- 2. Indicadores por município
CREATE TABLE IF NOT EXISTS
  `heroic-bucksaw-513517-p9.bronze.municipio`
PARTITION BY DATE(data_ingestao)
AS
SELECT
    *,
    CURRENT_TIMESTAMP() AS data_ingestao,
    'oficial_basedosdados' AS origem
FROM
  `basedosdados.br_inep_avaliacao_alfabetizacao.municipio`;

-- 3. Indicadores por estado
CREATE TABLE IF NOT EXISTS
  `heroic-bucksaw-513517-p9.bronze.uf`
PARTITION BY DATE(data_ingestao)
AS
SELECT
    *,
    CURRENT_TIMESTAMP() AS data_ingestao,
    'oficial_basedosdados' AS origem
FROM
  `basedosdados.br_inep_avaliacao_alfabetizacao.uf`;

-- 4. Metas por município
CREATE TABLE IF NOT EXISTS
  `heroic-bucksaw-513517-p9.bronze.meta_alfabetizacao_municipio`
PARTITION BY DATE(data_ingestao)
AS
SELECT
    *,
    CURRENT_TIMESTAMP() AS data_ingestao,
    'oficial_basedosdados' AS origem
FROM
  `basedosdados.br_inep_avaliacao_alfabetizacao.meta_alfabetizacao_municipio`;

-- 5. Metas por estado
CREATE TABLE IF NOT EXISTS
  `heroic-bucksaw-513517-p9.bronze.meta_alfabetizacao_uf`
PARTITION BY DATE(data_ingestao)
AS
SELECT
    *,
    CURRENT_TIMESTAMP() AS data_ingestao,
    'oficial_basedosdados' AS origem
FROM
  `basedosdados.br_inep_avaliacao_alfabetizacao.meta_alfabetizacao_uf`;

-- 6. Dicionário de dados
CREATE TABLE IF NOT EXISTS
  `heroic-bucksaw-513517-p9.bronze.dicionario`
PARTITION BY DATE(data_ingestao)
AS
SELECT
    *,
    CURRENT_TIMESTAMP() AS data_ingestao,
    'oficial_basedosdados' AS origem
FROM
  `basedosdados.br_inep_avaliacao_alfabetizacao.dicionario`;
