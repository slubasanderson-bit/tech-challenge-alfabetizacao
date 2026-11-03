-- Código SQL recuperado do histórico do BigQuery (não reexecutado nesta revisão).
-- Job ID: job_rnj7Z1Kgvf9fCS-aqjuiQL_ovCNW | Status no índice: EXECUTADO SEM ERRO.
-- ATENÇÃO: esta versão usa CREATE OR REPLACE e não acumula execuções.

CREATE OR REPLACE TABLE
  `heroic-bucksaw-513517-p9.monitoring.resultados_qualidade`
AS

WITH validacoes AS (

  SELECT
    'ANO_NULO' AS regra,
    'BLOQUEANTE' AS tipo_regra,
    COUNT(*) AS total_registros,
    COUNTIF(ano IS NULL) AS problemas,
    'Verifica se existem anos sem preenchimento' AS descricao
  FROM `heroic-bucksaw-513517-p9.silver.alunos`

  UNION ALL

  SELECT
    'MUNICIPIO_NULO',
    'BLOQUEANTE',
    COUNT(*),
    COUNTIF(id_municipio IS NULL),
    'Verifica identificadores de municípios ausentes'
  FROM `heroic-bucksaw-513517-p9.silver.alunos`

  UNION ALL

  SELECT
    'PRESENCA_INVALIDA',
    'BLOQUEANTE',
    COUNT(*),
    COUNTIF(presenca NOT IN ('0', '1') OR presenca IS NULL),
    'Presença deve conter somente 0 ou 1'
  FROM `heroic-bucksaw-513517-p9.silver.alunos`

  UNION ALL

  SELECT
    'ALFABETIZACAO_INVALIDA',
    'BLOQUEANTE',
    COUNT(*),
    COUNTIF(alfabetizado NOT IN ('0', '1') OR alfabetizado IS NULL),
    'Alfabetização deve conter somente 0 ou 1'
  FROM `heroic-bucksaw-513517-p9.silver.alunos`

  UNION ALL

  SELECT
    'ALUNO_AUSENTE',
    'INFORMATIVA',
    COUNT(*),
    COUNTIF(presenca = '0'),
    'Registra alunos ausentes sem classificá-los como erros'
  FROM `heroic-bucksaw-513517-p9.silver.alunos`

  UNION ALL

  SELECT
    'PROFICIENCIA_OU_PESO_NULO',
    'BLOQUEANTE',
    COUNT(*),
    COUNTIF(
      preenchimento_caderno = '1'
      AND (proficiencia IS NULL OR peso_aluno IS NULL)
    ),
    'Alunos com caderno preenchido devem possuir proficiência e peso'
  FROM `heroic-bucksaw-513517-p9.silver.alunos`
)

SELECT
  GENERATE_UUID() AS id_execucao,
  CURRENT_TIMESTAMP() AS data_validacao,
  'silver.alunos' AS tabela_analisada,
  regra,
  tipo_regra,
  total_registros,
  problemas AS registros_com_problema,
  ROUND(
    SAFE_DIVIDE(problemas, total_registros) * 100,
    4
  ) AS percentual_problema,
  CASE
    WHEN problemas = 0 THEN 'APROVADO'
    WHEN tipo_regra = 'BLOQUEANTE' THEN 'REPROVADO'
    ELSE 'ALERTA'
  END AS status,
  descricao
FROM validacoes;
