-- Código SQL recuperado do histórico do BigQuery (não reexecutado nesta revisão).
-- Job ID: job_cKyW4FwQuvby8IxGnb87OjL7Qjm- | Status no índice: EXECUTADO SEM ERRO.

CREATE OR REPLACE TABLE
  `heroic-bucksaw-513517-p9.gold.desempenho_municipal`
AS

WITH alunos_agregados AS (
    SELECT
        ano,
        id_municipio,

        COUNTIF(
            classificacao_alfabetizacao IN (
                'ALFABETIZADO',
                'NAO_ALFABETIZADO'
            )
        ) AS total_alunos_avaliados,

        COUNTIF(
            classificacao_alfabetizacao = 'ALFABETIZADO'
        ) AS total_alunos_alfabetizados,

        ROUND(
            SAFE_DIVIDE(
                COUNTIF(
                    classificacao_alfabetizacao = 'ALFABETIZADO'
                ),
                COUNTIF(
                    classificacao_alfabetizacao IN (
                        'ALFABETIZADO',
                        'NAO_ALFABETIZADO'
                    )
                )
            ) * 100,
            2
        ) AS percentual_alfabetizacao_calculado

    FROM
      `heroic-bucksaw-513517-p9.silver.alunos`

    WHERE
        rede = '3'
        AND id_municipio IS NOT NULL

    GROUP BY
        ano,
        id_municipio
),

metas AS (
    SELECT
        ano,
        id_municipio,
        taxa_alfabetizacao,
        meta_alfabetizacao_2030,
        percentual_participacao,
        nivel_alfabetizacao
    FROM
      `heroic-bucksaw-513517-p9.gold.indicadores_municipio`
    WHERE
        rede = 'Municipal'
)

SELECT
    a.ano,
    a.id_municipio,

    a.total_alunos_avaliados,
    a.total_alunos_alfabetizados,
    a.percentual_alfabetizacao_calculado,

    m.taxa_alfabetizacao AS taxa_oficial_alfabetizacao,
    m.meta_alfabetizacao_2030,
    m.percentual_participacao,
    m.nivel_alfabetizacao,

    CASE
        WHEN m.id_municipio IS NULL
            THEN 'SEM_META_MUNICIPAL'
        ELSE 'CORRESPONDENCIA_ENCONTRADA'
    END AS situacao_correspondencia,

    CURRENT_TIMESTAMP() AS data_processamento

FROM alunos_agregados a

LEFT JOIN metas m
    ON a.ano = m.ano
    AND a.id_municipio = m.id_municipio;
