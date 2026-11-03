-- Código SQL recuperado do histórico do BigQuery (não reexecutado nesta revisão).
-- Job ID: job_qa_SI4X7BHlHN9oa_WEhaX56SphG | Status no índice: EXECUTADO SEM ERRO.

CREATE OR REPLACE TABLE
  `heroic-bucksaw-513517-p9.silver.uf`
PARTITION BY DATE(data_processamento)
CLUSTER BY ano, sigla_uf
AS
SELECT
    *,
    CURRENT_TIMESTAMP() AS data_processamento
FROM
    `heroic-bucksaw-513517-p9.bronze.uf`;
