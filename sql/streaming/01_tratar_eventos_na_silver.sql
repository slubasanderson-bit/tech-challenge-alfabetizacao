-- Código SQL recuperado do histórico do BigQuery (não reexecutado nesta revisão).
-- Job ID: job_eD9tx2dWYZIu9p2HUK26ujZNmZsy | Status no índice: EXECUTADO SEM ERRO.

CREATE OR REPLACE TABLE
`heroic-bucksaw-513517-p9.silver.eventos_streaming` AS

SELECT
    id_evento,
    id_aluno,
    CAST(id_municipio AS STRING) AS id_municipio,
    SAFE_CAST(ano AS INT64) AS ano,
    SAFE_CAST(alfabetizado AS INT64) AS alfabetizado,

    CASE
        WHEN alfabetizado = 1 THEN 'ALFABETIZADO'
        WHEN alfabetizado = 0 THEN 'NAO_ALFABETIZADO'
    END AS classificacao_alfabetizacao,

    SAFE_CAST(produzido_em AS TIMESTAMP) AS produzido_em,
    SAFE_CAST(recebido_em AS TIMESTAMP) AS recebido_em,
    SAFE_CAST(latencia_segundos AS FLOAT64) AS latencia_segundos,

    origem,
    SAFE_CAST(data_ingestao AS TIMESTAMP) AS data_ingestao,
    CURRENT_TIMESTAMP() AS data_processamento

FROM `heroic-bucksaw-513517-p9.bronze.eventos_streaming`

WHERE
    SAFE_CAST(alfabetizado AS INT64) IN (0, 1)
    AND id_evento IS NOT NULL
    AND id_aluno IS NOT NULL
    AND id_municipio IS NOT NULL

QUALIFY ROW_NUMBER() OVER (
    PARTITION BY id_evento
    ORDER BY recebido_em DESC
) = 1;
