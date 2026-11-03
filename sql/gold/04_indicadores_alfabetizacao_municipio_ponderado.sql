-- A taxa ponderada usa o peso do aluno e considera somente avaliados.
-- Separa município, ano, rede, série e origem para não misturar recortes.
CREATE OR REPLACE TABLE `__PROJECT_ID__.gold.indicadores_alfabetizacao_municipio_ponderado`
CLUSTER BY ano, id_municipio, rede AS
WITH indicadores AS (
    SELECT
        ano, id_municipio, rede, rede_descricao, serie, serie_descricao, origem,
        COUNT(*) AS total_registros,
        COUNTIF(classificacao_alfabetizacao IN ('ALFABETIZADO', 'NAO_ALFABETIZADO')) AS total_avaliados,
        COUNTIF(classificacao_alfabetizacao = 'ALFABETIZADO') AS total_alfabetizados,
        COUNTIF(classificacao_alfabetizacao = 'NAO_ALFABETIZADO') AS total_nao_alfabetizados,
        COUNTIF(classificacao_alfabetizacao IN ('NAO_AVALIADO_AUSENTE', 'NAO_AVALIADO_SEM_CADERNO')) AS total_nao_avaliados,
        COUNTIF(classificacao_alfabetizacao = 'REVISAR') AS total_revisar,
        SUM(IF(classificacao_alfabetizacao IN ('ALFABETIZADO', 'NAO_ALFABETIZADO'), peso_aluno, 0)) AS soma_pesos_avaliados,
        SUM(IF(classificacao_alfabetizacao = 'ALFABETIZADO', peso_aluno, 0)) AS soma_pesos_alfabetizados
    FROM `__PROJECT_ID__.silver.alunos_enriquecidos`
    WHERE origem = 'oficial_basedosdados'
      AND id_municipio IS NOT NULL
      AND ano IS NOT NULL
    GROUP BY ano, id_municipio, rede, rede_descricao, serie, serie_descricao, origem
)
SELECT
    *,
    ROUND(100 * SAFE_DIVIDE(total_alfabetizados, total_avaliados), 2) AS taxa_simples_pct,
    ROUND(100 * SAFE_DIVIDE(soma_pesos_alfabetizados, soma_pesos_avaliados), 2) AS taxa_alfabetizacao_ponderada_pct
FROM indicadores;
