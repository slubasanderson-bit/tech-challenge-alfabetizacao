-- Código SQL recuperado do histórico do BigQuery (não reexecutado nesta revisão).
-- Job ID: job_Ch0xn7BVeF7j6qJvMeIqJdR_dEey | Status no índice: EXECUTADO SEM ERRO.

CREATE OR REPLACE TABLE
  `heroic-bucksaw-513517-p9.gold.indicadores_uf`
AS
SELECT
    ano,
    sigla_uf,
    rede,
    taxa_alfabetizacao,
    meta_alfabetizacao_2024,
    meta_alfabetizacao_2025,
    meta_alfabetizacao_2026,
    meta_alfabetizacao_2027,
    meta_alfabetizacao_2028,
    meta_alfabetizacao_2029,
    meta_alfabetizacao_2030,
    percentual_participacao,

    ROUND(
      taxa_alfabetizacao - meta_alfabetizacao_2030,
      2
    ) AS diferenca_meta_2030,

    CASE
      WHEN taxa_alfabetizacao >= meta_alfabetizacao_2030
        THEN 'META_ATINGIDA'
      ELSE 'META_NAO_ATINGIDA'
    END AS situacao_meta_2030,

    CURRENT_TIMESTAMP() AS data_processamento

FROM
  `heroic-bucksaw-513517-p9.silver.meta_alfabetizacao_uf`;
