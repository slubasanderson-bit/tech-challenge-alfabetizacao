-- Código SQL recuperado do histórico do BigQuery (não reexecutado nesta revisão).
-- Job ID: job_S80LCrX0-V2KuL1kFpUFLZOjbjuK | Status no índice: EXECUTADO SEM ERRO.
-- ATENÇÃO: duração fixada em zero e CREATE OR REPLACE sobrescreve histórico; não é monitoramento acumulativo.

CREATE OR REPLACE TABLE
  `heroic-bucksaw-513517-p9.monitoring.metricas_pipeline`
AS

SELECT
    GENERATE_UUID() AS id_execucao,
    CURRENT_TIMESTAMP() AS data_execucao,
    'ENRIQUECIMENTO_DICIONARIO' AS etapa,

    3867999 AS registros_entrada,
    (
      SELECT COUNT(*)
      FROM `heroic-bucksaw-513517-p9.silver.alunos_enriquecidos`
    ) AS registros_saida,

    0.0 AS duracao_segundos,

    CASE
      WHEN (
        SELECT COUNT(*)
        FROM `heroic-bucksaw-513517-p9.silver.alunos_enriquecidos`
      ) = 3867999
      THEN 'SUCESSO'
      ELSE 'FALHA'
    END AS status,

    'Validação do enriquecimento pelo dicionário oficial'
      AS observacao;
