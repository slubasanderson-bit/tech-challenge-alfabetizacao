-- Agrega a carga de microdados pelo prefixo do código do município.
-- Não substituir por essa taxa os indicadores estaduais publicados na fonte.
CREATE OR REPLACE TABLE `__PROJECT_ID__.gold.indicadores_alfabetizacao_uf` AS
WITH indicadores AS (
    SELECT
        ano,
        SUBSTR(id_municipio, 1, 2) AS codigo_uf,
        COUNT(*) AS total_municipios,
        SUM(total_registros) AS total_registros,
        SUM(total_avaliados) AS total_avaliados,
        SUM(total_alfabetizados) AS total_alfabetizados,
        SUM(total_nao_alfabetizados) AS total_nao_alfabetizados,
        SUM(total_nao_avaliados) AS total_nao_avaliados
    FROM `__PROJECT_ID__.gold.indicadores_alfabetizacao_municipio`
    GROUP BY ano, codigo_uf
)
SELECT
    *,
    ROUND(100 * SAFE_DIVIDE(total_alfabetizados, total_avaliados), 2) AS taxa_alfabetizacao_pct
FROM indicadores;
