-- Indicador simples por município e ano (não ponderado).
-- Mantido para conferir contagens. Não usar como taxa oficial nacional.
CREATE OR REPLACE TABLE `__PROJECT_ID__.gold.indicadores_alfabetizacao_municipio` AS
WITH indicadores AS (
    SELECT
        ano,
        id_municipio,
        COUNT(*) AS total_registros,
        COUNTIF(classificacao_alfabetizacao IN ('ALFABETIZADO', 'NAO_ALFABETIZADO')) AS total_avaliados,
        COUNTIF(classificacao_alfabetizacao = 'ALFABETIZADO') AS total_alfabetizados,
        COUNTIF(classificacao_alfabetizacao = 'NAO_ALFABETIZADO') AS total_nao_alfabetizados,
        COUNTIF(classificacao_alfabetizacao IN ('NAO_AVALIADO_AUSENTE', 'NAO_AVALIADO_SEM_CADERNO')) AS total_nao_avaliados
    FROM `__PROJECT_ID__.silver.alunos_enriquecidos`
    WHERE ano IS NOT NULL AND id_municipio IS NOT NULL
    GROUP BY ano, id_municipio
)
SELECT
    *,
    ROUND(100 * SAFE_DIVIDE(total_alfabetizados, total_avaliados), 2) AS taxa_alfabetizacao_pct
FROM indicadores;
