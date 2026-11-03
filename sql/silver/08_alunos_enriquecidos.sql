-- Código SQL recuperado do histórico do BigQuery (não reexecutado nesta revisão).
-- Job ID: job_X1l4GuSudwVqYCLmjNyqxZPVImNA | Status no índice: EXECUTADO SEM ERRO.

CREATE OR REPLACE TABLE
  `heroic-bucksaw-513517-p9.silver.alunos_enriquecidos`
AS

SELECT
    a.*,

    d_alf.valor AS alfabetizado_descricao,
    d_pres.valor AS presenca_descricao,
    d_cad.valor AS preenchimento_caderno_descricao,
    d_rede.valor AS rede_descricao,
    d_serie.valor AS serie_descricao

FROM
  `heroic-bucksaw-513517-p9.silver.alunos` a

LEFT JOIN
  `heroic-bucksaw-513517-p9.silver.dicionario` d_alf
    ON d_alf.id_tabela = 'alunos'
    AND d_alf.nome_coluna = 'alfabetizado'
    AND d_alf.chave = a.alfabetizado

LEFT JOIN
  `heroic-bucksaw-513517-p9.silver.dicionario` d_pres
    ON d_pres.id_tabela = 'alunos'
    AND d_pres.nome_coluna = 'presenca'
    AND d_pres.chave = a.presenca

LEFT JOIN
  `heroic-bucksaw-513517-p9.silver.dicionario` d_cad
    ON d_cad.id_tabela = 'alunos'
    AND d_cad.nome_coluna = 'preenchimento_caderno'
    AND d_cad.chave = a.preenchimento_caderno

LEFT JOIN
  `heroic-bucksaw-513517-p9.silver.dicionario` d_rede
    ON d_rede.id_tabela = 'alunos'
    AND d_rede.nome_coluna = 'rede'
    AND d_rede.chave = a.rede

LEFT JOIN
  `heroic-bucksaw-513517-p9.silver.dicionario` d_serie
    ON d_serie.id_tabela = 'alunos'
    AND d_serie.nome_coluna = 'serie'
    AND d_serie.chave = a.serie;
