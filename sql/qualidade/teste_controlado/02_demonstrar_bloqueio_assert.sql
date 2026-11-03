-- Código SQL recuperado do histórico do BigQuery (não reexecutado nesta revisão).
-- Job ID: job_56EQf0WtVe18-vS-gRIF9xxOFAIK | Status no índice: ERRO ESPERADO NO TESTE.
-- TESTE CONTROLADO: 01 insere uma amostra inválida; 02 deve falhar de propósito. Não executar na entrega normal.

ASSERT (
  SELECT COUNT(*) = 0
  FROM `heroic-bucksaw-513517-p9.monitoring.teste_falha_qualidade`
  WHERE tipo_regra = 'BLOQUEANTE'
    AND status = 'REPROVADO'
) AS 'PUBLICACAO BLOQUEADA: existem falhas criticas de qualidade';
