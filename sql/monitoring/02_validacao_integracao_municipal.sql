-- Código SQL recuperado do histórico do BigQuery (não reexecutado nesta revisão).
-- Job ID: job_JAye3gLu4zcPLZ-CE2TsQjZrkqAj | Status no índice: EXECUTADO SEM ERRO.

CREATE OR REPLACE TABLE
`heroic-bucksaw-513517-p9.monitoring.validacao_integracao_municipal` AS

WITH alunos AS (
    SELECT DISTINCT
        ano,
        id_municipio
    FROM `heroic-bucksaw-513517-p9.silver.alunos`
    WHERE
        rede = '3'
        AND id_municipio IS NOT NULL
),

metas AS (
    SELECT DISTINCT
        ano,
        id_municipio
    FROM `heroic-bucksaw-513517-p9.silver.meta_alfabetizacao_municipio`
    WHERE rede = 'Municipal'
),

comparacao AS (
    SELECT
        a.ano,
        a.id_municipio,
        CASE
            WHEN m.id_municipio IS NOT NULL THEN 1
            ELSE 0
        END AS correspondencia
    FROM alunos a
    LEFT JOIN metas m
        ON a.ano = m.ano
        AND a.id_municipio = m.id_municipio
)

SELECT
    CURRENT_TIMESTAMP() AS data_validacao,
    COUNT(*) AS total_chaves,
    SUM(correspondencia) AS chaves_correspondentes,
    COUNTIF(correspondencia = 0) AS chaves_sem_correspondencia,

    ROUND(
        SAFE_DIVIDE(SUM(correspondencia), COUNT(*)) * 100,
        2
    ) AS percentual_correspondencia,

    95.0 AS limite_minimo_percentual,

    CASE
        WHEN SAFE_DIVIDE(SUM(correspondencia), COUNT(*)) >= 0.95
            THEN 'APROVADO'
        ELSE 'REPROVADO'
    END AS status,

    'BLOQUEANTE' AS tipo_regra

FROM comparacao;
