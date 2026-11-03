-- Código SQL recuperado do histórico do BigQuery (não reexecutado nesta revisão).
-- Job ID: job_O8sGvQ2cdVMljmVYJCd2kiKPzxD_ | Status no índice: EXECUTADO SEM ERRO.

CREATE OR REPLACE TABLE
  `heroic-bucksaw-513517-p9.silver.meta_alfabetizacao_municipio`
AS
SELECT
    *,
    CURRENT_TIMESTAMP() AS data_processamento
FROM
    `heroic-bucksaw-513517-p9.bronze.meta_alfabetizacao_municipio`;
