-- Código 5 na tabela uf = Pública (Estadual e Municipal).
-- As metas usam o rótulo 'Pública'. Mantemos UF sem resultado como SEM_RESULTADO.
ASSERT (
    SELECT COUNT(*) = COUNT(DISTINCT sigla_uf)
    FROM `__PROJECT_ID__.silver.uf`
    WHERE ano = 2024 AND rede = '5' AND serie = '2'
) AS 'Duplicidades nos resultados estaduais';

ASSERT (
    SELECT COUNT(*) = COUNT(DISTINCT sigla_uf)
    FROM `__PROJECT_ID__.silver.meta_alfabetizacao_uf`
    WHERE ano = 2024 AND rede = 'Pública'
) AS 'Duplicidades nas metas estaduais';

CREATE OR REPLACE TABLE `__PROJECT_ID__.gold.comparacao_metas_estaduais` AS
SELECT
    m.ano,
    m.sigla_uf,
    r.taxa_alfabetizacao AS taxa_resultado_2024,
    m.meta_alfabetizacao_2024 AS meta_2024,
    m.meta_alfabetizacao_2030 AS meta_2030,
    ROUND(r.taxa_alfabetizacao - m.meta_alfabetizacao_2024, 2) AS diferenca_meta_2024_pp,
    CASE
        WHEN r.taxa_alfabetizacao IS NULL THEN 'SEM_RESULTADO'
        WHEN m.meta_alfabetizacao_2024 IS NULL THEN 'META_INDISPONIVEL'
        WHEN r.taxa_alfabetizacao >= m.meta_alfabetizacao_2024 THEN 'ATINGIDA'
        ELSE 'NAO_ATINGIDA'
    END AS situacao_meta_2024
FROM `__PROJECT_ID__.silver.meta_alfabetizacao_uf` m
LEFT JOIN `__PROJECT_ID__.silver.uf` r
  ON m.sigla_uf = r.sigla_uf
 AND m.ano = r.ano
 AND r.rede = '5'
 AND r.serie = '2'
WHERE m.ano = 2024
  AND m.rede = 'Pública';
