# Evidência adicional: validação bloqueante com falha controlada

Fonte: histórico de jobs do BigQuery, projeto `heroic-bucksaw-513517-p9`.

1. Job `job_wI_RDqE0JYT2dd2GsnohLVd4amep` — execução concluída sem erro: cria `monitoring.teste_falha_qualidade` com uma presença de valor `2`, fora dos códigos aceitos (`0` e `1`), e registra uma regra `BLOQUEANTE` com status `REPROVADO`.
2. Job `job_56EQf0WtVe18-vS-gRIF9xxOFAIK` — **consta como erro no índice histórico recuperado**: executa um `ASSERT` que só permite continuar quando não existem regras bloqueantes reprovadas. O resultado esperado era falhar e sinalizar `PUBLICACAO BLOQUEADA`.

Scripts correspondentes: `sql/qualidade/teste_controlado/01_criar_amostra_invalida.sql` e `02_demonstrar_bloqueio_assert.sql`.

A evidência foi extraída do histórico de execução; se desejar reforçá-la visualmente, um print do Job ID com status de erro esperado pode ser anexado separadamente. Não é necessário reexecutar o teste para produzir esse registro.
