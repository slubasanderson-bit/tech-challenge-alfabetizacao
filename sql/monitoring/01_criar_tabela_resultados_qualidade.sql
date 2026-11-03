-- Código SQL recuperado do histórico do BigQuery (não reexecutado nesta revisão).
-- Job ID: job_i0HWikR1P8aEXP0x3c7Q9WeTURBc | Status no índice: EXECUTADO SEM ERRO.

CREATE TABLE IF NOT EXISTS
  `heroic-bucksaw-513517-p9.monitoring.resultados_qualidade` (
    id_execucao STRING,
    data_validacao TIMESTAMP,
    tabela_analisada STRING,
    regra STRING,
    tipo_regra STRING,
    total_registros INT64,
    registros_com_problema INT64,
    percentual_problema FLOAT64,
    status STRING,
    descricao STRING
  );
