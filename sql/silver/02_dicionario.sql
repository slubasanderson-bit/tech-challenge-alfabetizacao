-- Código SQL recuperado do histórico do BigQuery (não reexecutado nesta revisão).
-- Job ID: job_2cQ5gdRnHeMehgcXh3z5DfeM7VA1 | Status no índice: EXECUTADO SEM ERRO.

CREATE OR REPLACE TABLE
  `heroic-bucksaw-513517-p9.silver.dicionario`
AS
SELECT
    *,
    CURRENT_TIMESTAMP() AS data_processamento
FROM
    `heroic-bucksaw-513517-p9.bronze.dicionario`;
