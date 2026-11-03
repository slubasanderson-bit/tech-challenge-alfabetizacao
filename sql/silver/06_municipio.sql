-- Código SQL recuperado do histórico do BigQuery (não reexecutado nesta revisão).
-- Job ID: job_Pb5fWmzX4qxSWqKZI0usIkG5p4Ik | Status no índice: EXECUTADO SEM ERRO.

CREATE OR REPLACE TABLE
  `heroic-bucksaw-513517-p9.silver.municipio`
PARTITION BY DATE(data_processamento)
CLUSTER BY ano, id_municipio
AS
SELECT
    *,
    CURRENT_TIMESTAMP() AS data_processamento
FROM
    `heroic-bucksaw-513517-p9.bronze.municipio`;
