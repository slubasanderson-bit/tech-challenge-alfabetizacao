-- Código SQL recuperado do histórico do BigQuery (não reexecutado nesta revisão).
-- Job ID: job_DK5WNMboy1QPJVi0TA3T4HBWf6zT | Status no índice: EXECUTADO SEM ERRO.

CREATE OR REPLACE TABLE
  `heroic-bucksaw-513517-p9.silver.meta_alfabetizacao_uf`
AS
SELECT
    *,
    CURRENT_TIMESTAMP() AS data_processamento
FROM
    `heroic-bucksaw-513517-p9.bronze.meta_alfabetizacao_uf`;
