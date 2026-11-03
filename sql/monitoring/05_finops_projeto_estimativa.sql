-- Código SQL recuperado do histórico do BigQuery (não reexecutado nesta revisão).
-- Job ID: job_C-ochqw8fU-Gher3pNR78oZQasud | Status no índice: EXECUTADO SEM ERRO.
-- ATENÇÃO: valores medidos anteriormente e inseridos como constantes; não gera medições atuais.

CREATE OR REPLACE TABLE
`heroic-bucksaw-513517-p9.monitoring.finops_projeto` AS

SELECT
    'ARMAZENAMENTO' AS categoria,
    'Armazenamento lógico medido' AS indicador,
    1571.4224 AS quantidade,
    'MB' AS unidade,
    10.0 AS franquia_mensal,
    'GiB' AS unidade_franquia,
    0.0 AS custo_estimado_usd,
    'Volume medido abaixo da franquia de 10 GiB, considerando disponibilidade da franquia.'
        AS observacao

UNION ALL

SELECT
    'PROCESSAMENTO',
    'Volume estimado nas três consultas Dry Run',
    79.2612,
    'MiB',
    1024.0,
    'GiB',
    0.00047243,
    'Custo hipotético antes da franquia de 1 TiB, usando US$ 6,25 por TiB.'
;
