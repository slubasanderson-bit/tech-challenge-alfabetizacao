-- Agrega as contagens municipais dos microdados (taxa simples).
-- O nome 'brasil' indica o agregado da carga, não o resultado oficial do país.
CREATE OR REPLACE TABLE `__PROJECT_ID__.gold.indicadores_alfabetizacao_brasil` AS
WITH indicadores AS (
    SELECT
        ano,
        SUM(total_registros) AS total_registros,
        SUM(total_avaliados) AS total_avaliados,
        SUM(total_alfabetizados) AS total_alfabetizados,
        SUM(total_nao_alfabetizados) AS total_nao_alfabetizados,
        SUM(total_nao_avaliados) AS total_nao_avaliados,
        COUNT(*) AS total_municipios
    FROM `__PROJECT_ID__.gold.indicadores_alfabetizacao_municipio`
    GROUP BY ano
)
SELECT
    *,
    ROUND(100 * SAFE_DIVIDE(total_alfabetizados, total_avaliados), 2) AS taxa_alfabetizacao_pct
FROM indicadores;
