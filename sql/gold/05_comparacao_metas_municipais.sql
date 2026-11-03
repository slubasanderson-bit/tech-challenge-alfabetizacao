-- Recorte: 2024, rede municipal (código 3), 2º ano.
-- As metas usam o nome 'Municipal' no lugar do código 3.
-- Se as chaves duplicarem ou o join cair abaixo de 95%, a Gold não é publicada.
ASSERT (
    SELECT COUNT(*) = COUNT(DISTINCT id_municipio)
    FROM `__PROJECT_ID__.silver.municipio`
    WHERE ano = 2024 AND rede = '3' AND serie = '2'
) AS 'ERRO: municipios duplicados nos resultados';

ASSERT (
    SELECT COUNT(*) = COUNT(DISTINCT id_municipio)
    FROM `__PROJECT_ID__.silver.meta_alfabetizacao_municipio`
    WHERE ano = 2024 AND rede = 'Municipal'
) AS 'ERRO: municipios duplicados nas metas';

ASSERT (
    SELECT SAFE_DIVIDE(COUNTIF(m.id_municipio IS NOT NULL), COUNT(*)) >= 0.95
    FROM `__PROJECT_ID__.silver.municipio` r
    LEFT JOIN `__PROJECT_ID__.silver.meta_alfabetizacao_municipio` m
      ON r.id_municipio = m.id_municipio
     AND m.ano = 2024
     AND m.rede = 'Municipal'
    WHERE r.ano = 2024 AND r.rede = '3' AND r.serie = '2'
) AS 'ERRO: correspondencia inferior a 95%';

CREATE OR REPLACE TABLE `__PROJECT_ID__.gold.comparacao_metas_municipais`
CLUSTER BY id_municipio AS
SELECT
    r.ano, r.id_municipio, r.rede, r.serie,
    r.taxa_alfabetizacao AS taxa_resultado_2024,
    m.meta_alfabetizacao_2024 AS meta_2024,
    m.meta_alfabetizacao_2030 AS meta_2030,
    ROUND(r.taxa_alfabetizacao - m.meta_alfabetizacao_2024, 2) AS diferenca_meta_2024_pp,
    CASE
        WHEN m.id_municipio IS NULL THEN 'SEM_META_CADASTRADA'
        WHEN m.meta_alfabetizacao_2024 IS NULL THEN 'META_INDISPONIVEL'
        WHEN r.taxa_alfabetizacao >= m.meta_alfabetizacao_2024 THEN 'ATINGIDA'
        ELSE 'NAO_ATINGIDA'
    END AS situacao_meta_2024,
    r.origem AS origem_resultado,
    m.origem AS origem_meta
FROM `__PROJECT_ID__.silver.municipio` r
LEFT JOIN `__PROJECT_ID__.silver.meta_alfabetizacao_municipio` m
  ON r.id_municipio = m.id_municipio
 AND m.ano = 2024
 AND m.rede = 'Municipal'
WHERE r.ano = 2024
  AND r.rede = '3'
  AND r.serie = '2';
