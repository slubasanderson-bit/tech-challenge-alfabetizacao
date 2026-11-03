-- Usa o indicador nacional publicado na Base dos Dados.
-- Não confundir com o agregado calculado diretamente dos microdados.
ASSERT (
    SELECT COUNT(*) = 1
    FROM `__PROJECT_ID__.silver.meta_alfabetizacao_brasil`
    WHERE ano = 2024 AND rede = 'Pública'
) AS 'Registro nacional ausente ou duplicado';

CREATE OR REPLACE TABLE `__PROJECT_ID__.gold.comparacao_metas_brasil` AS
SELECT
    ano,
    rede,
    taxa_alfabetizacao AS taxa_resultado_2024,
    meta_alfabetizacao_2024 AS meta_2024,
    meta_alfabetizacao_2030 AS meta_2030,
    ROUND(taxa_alfabetizacao - meta_alfabetizacao_2024, 2) AS diferenca_meta_2024_pp,
    CASE
        WHEN taxa_alfabetizacao IS NULL OR meta_alfabetizacao_2024 IS NULL THEN 'INDISPONIVEL'
        WHEN taxa_alfabetizacao >= meta_alfabetizacao_2024 THEN 'ATINGIDA'
        ELSE 'NAO_ATINGIDA'
    END AS situacao_meta_2024
FROM `__PROJECT_ID__.silver.meta_alfabetizacao_brasil`
WHERE ano = 2024
  AND rede = 'Pública';
