-- Código SQL recuperado do histórico do BigQuery (não reexecutado nesta revisão).
-- Job ID: job_248JH3HR3rItbqJ2KSnLgugaHE48 | Status no índice: EXECUTADO SEM ERRO.

ASSERT (
    SELECT
        COUNTIF(status = 'REPROVADO') = 0
    FROM `heroic-bucksaw-513517-p9.monitoring.validacao_integracao_municipal`
    WHERE tipo_regra = 'BLOQUEANTE'
) AS 'PUBLICACAO BLOQUEADA: taxa de correspondencia abaixo do limite';
