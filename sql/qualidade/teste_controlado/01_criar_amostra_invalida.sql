-- Código SQL recuperado do histórico do BigQuery (não reexecutado nesta revisão).
-- Job ID: job_wI_RDqE0JYT2dd2GsnohLVd4amep | Status no índice: EXECUTADO SEM ERRO.
-- TESTE CONTROLADO: 01 insere uma amostra inválida; 02 deve falhar de propósito. Não executar na entrega normal.

CREATE OR REPLACE TABLE
  `heroic-bucksaw-513517-p9.monitoring.teste_falha_qualidade`
AS
WITH dados_teste AS (
  SELECT
    '2024' AS ano,
    '1234567' AS id_municipio,
    '2' AS presenca,
    '1' AS alfabetizado
)
SELECT
  'TESTE_PRESENCA_INVALIDA' AS regra,
  'BLOQUEANTE' AS tipo_regra,
  COUNT(*) AS total_registros,
  COUNTIF(presenca NOT IN ('0', '1') OR presenca IS NULL)
    AS registros_com_problema,
  CASE
    WHEN COUNTIF(presenca NOT IN ('0', '1') OR presenca IS NULL) > 0
      THEN 'REPROVADO'
    ELSE 'APROVADO'
  END AS status
FROM dados_teste;
