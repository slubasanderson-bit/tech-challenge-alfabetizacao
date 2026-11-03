-- Código SQL recuperado do histórico do BigQuery (não reexecutado nesta revisão).
-- Job ID: job_8n5Bils80ZGeN2EgD3jz_PRPpVJa | Status no índice: EXECUTADO SEM ERRO.

CREATE OR REPLACE TABLE
`heroic-bucksaw-513517-p9.gold.indicadores_streaming` AS

SELECT
    ano,
    id_municipio,

    COUNT(*) AS total_alunos_avaliados,

    COUNTIF(alfabetizado = 1)
        AS total_alfabetizados,

    COUNTIF(alfabetizado = 0)
        AS total_nao_alfabetizados,

    ROUND(
        SAFE_DIVIDE(
            COUNTIF(alfabetizado = 1),
            COUNT(*)
        ) * 100,
        2
    ) AS percentual_alfabetizacao,

    'simulado_streaming' AS origem,

    CURRENT_TIMESTAMP() AS data_processamento

FROM `heroic-bucksaw-513517-p9.silver.eventos_streaming`

GROUP BY
    ano,
    id_municipio;
