-- Código SQL recuperado do histórico do BigQuery (não reexecutado nesta revisão).
-- Job ID: job_hqlXm0InvEirL78HrbVuGbtQi7CB | Status no índice: EXECUTADO SEM ERRO.

CREATE OR REPLACE TABLE
  `heroic-bucksaw-513517-p9.monitoring.validacao_dicionario`
AS

SELECT
    CURRENT_TIMESTAMP() AS data_validacao,
    'alunos_enriquecidos' AS tabela_analisada,
    regra,
    total_registros,
    registros_sem_descricao,

    ROUND(
        SAFE_DIVIDE(
            registros_sem_descricao,
            total_registros
        ) * 100,
        2
    ) AS percentual_problema,

    CASE
        WHEN registros_sem_descricao = 0 THEN 'APROVADO'
        ELSE 'REPROVADO'
    END AS status

FROM (
    SELECT
        'ALFABETIZACAO_SEM_DESCRICAO' AS regra,
        COUNT(*) AS total_registros,
        COUNTIF(alfabetizado_descricao IS NULL)
            AS registros_sem_descricao
    FROM `heroic-bucksaw-513517-p9.silver.alunos_enriquecidos`

    UNION ALL

    SELECT
        'PRESENCA_SEM_DESCRICAO',
        COUNT(*),
        COUNTIF(presenca_descricao IS NULL)
    FROM `heroic-bucksaw-513517-p9.silver.alunos_enriquecidos`

    UNION ALL

    SELECT
        'CADERNO_SEM_DESCRICAO',
        COUNT(*),
        COUNTIF(preenchimento_caderno_descricao IS NULL)
    FROM `heroic-bucksaw-513517-p9.silver.alunos_enriquecidos`

    UNION ALL

    SELECT
        'REDE_SEM_DESCRICAO',
        COUNT(*),
        COUNTIF(rede_descricao IS NULL)
    FROM `heroic-bucksaw-513517-p9.silver.alunos_enriquecidos`

    UNION ALL

    SELECT
        'SERIE_SEM_DESCRICAO',
        COUNT(*),
        COUNTIF(serie_descricao IS NULL)
    FROM `heroic-bucksaw-513517-p9.silver.alunos_enriquecidos`
);
