-- Único SQL Silver que foi recuperado do histórico.
-- Cuidado: CREATE OR REPLACE substitui a tabela; não executar sem conferir a Bronze.
CREATE OR REPLACE TABLE `__PROJECT_ID__.silver.alunos`
PARTITION BY DATE(data_processamento)
CLUSTER BY ano, id_municipio AS
SELECT
    *,
    CASE
        WHEN presenca = '0' THEN 'NAO_AVALIADO_AUSENTE'
        WHEN presenca = '1' AND preenchimento_caderno = '0' THEN 'NAO_AVALIADO_SEM_CADERNO'
        WHEN presenca = '1' AND preenchimento_caderno = '1' AND alfabetizado = '0' THEN 'NAO_ALFABETIZADO'
        WHEN presenca = '1' AND preenchimento_caderno = '1' AND alfabetizado = '1' THEN 'ALFABETIZADO'
        ELSE 'REVISAR'
    END AS classificacao_alfabetizacao,
    CURRENT_TIMESTAMP() AS data_processamento
FROM `__PROJECT_ID__.bronze.alunos`;
-- Se a Bronze já possuir classificacao_alfabetizacao ou data_processamento,
-- SELECT * pode duplicar nomes de colunas; revisar o schema antes de usar.
