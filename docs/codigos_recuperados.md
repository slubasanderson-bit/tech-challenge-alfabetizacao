# Códigos encontrados no histórico do BigQuery

Os comandos deste diretório foram recuperados de jobs executados no projeto `heroic-bucksaw-513517-p9`. O ZIP original continha 46 arquivos SQL, incluindo consultas exploratórias, duplicações e comandos com erro. Aqui foram separados **23 scripts adicionais** que esclarecem a implementação realizada. Seus Job IDs estão em `docs/indice_jobs_recuperados.csv`.

## Por camada

- **Bronze:** script de carga inicial a partir de `basedosdados.br_inep_avaliacao_alfabetizacao`, criando seis tabelas (`alunos`, `municipio`, `uf`, `meta_alfabetizacao_municipio`, `meta_alfabetizacao_uf`, `dicionario`). O comando que criou a sétima tabela Bronze (`meta_alfabetizacao_brasil`) **não foi encontrado neste lote**.
- **Silver:** tratamentos das tabelas de município, UF e metas, além do enriquecimento de alunos pelo dicionário. O SQL `silver.alunos` já constava no repositório, por isso não foi duplicado neste pacote.
- **Streaming:** código SQL que lê eventos da Bronze, filtra inválidos, deduplica por `id_evento` na Silver e gera o agregado da Gold. **O produtor/receptor dos eventos, possivelmente implementado em Python/Colab, não foi recuperado**. Logo, esta documentação não demonstra como os eventos chegaram à Bronze.
- **Gold:** cinco scripts antigos adicionais (`indicadores_municipio`, `indicadores_uf`, `indicadores_brasil`, `desempenho_municipal`, `indicadores_streaming`). Eles complementam os sete scripts Gold já publicados, totalizando a documentação de 12 tabelas observadas no console.
- **Qualidade:** cálculo de regras, verificação bloqueante da correspondência municipal, e dois comandos de teste controlado que mostram a falha quando existe dado inválido.
- **Monitoring/FinOps:** criação da tabela de resultados de qualidade, validações de integração/dicionário, métricas de um processamento e estimativa de custos com números medidos anteriormente.

## O que este complemento não resolve por si só

1. A rotina original do produtor do streaming e os códigos de mensageria/recepção não estão no histórico SQL. É preciso recuperar o notebook/código Python original para demonstrar esse trecho e reproduzir o fluxo.
2. A carga Bronze encontrada usa `CREATE TABLE IF NOT EXISTS`; esse padrão faz a carga **somente na primeira criação** e não preserva novas versões da fonte. O requisito de histórico acumulativo não fica demonstrado por esse script.
3. O script `metricas_pipeline_snapshot.sql` usa `duracao_segundos = 0.0` e `CREATE OR REPLACE`: não mede duração real nem guarda sucessivas execuções. A tabela pode existir e ter dados, mas não comprova a observabilidade acumulativa exigida.
4. A tabela `finops_projeto` é alimentada com quantidades e preços colocados como constantes (representando medições anteriores). A consulta não mede custos automaticamente; não confundir estimativa com fatura.
5. O script `calcular_qualidade_snapshot.sql` substitui a tabela de resultados. Encontramos também uma tentativa histórica de `INSERT INTO` para acumular registros, mas ela consta como **job com erro**; não foi incluída como um procedimento validado.
6. O histórico recuperado contém um `ASSERT` de falha controlada com **job marcado como erro**, como esperado para um bloqueio. O `monitoring.teste_falha_qualidade` foi preparado pelo script anterior. É uma evidência específica da reação do processo diante de erro, mas não garante que todo o fluxo esteja automaticamente encadeado a essas validações.
7. Os SQLs originais contêm o ID concreto do projeto e vários recortes fixos de dados. Para execução em outro projeto é necessário adaptar referências, permissões, região, disponibilidade da fonte e criar os datasets.

## Ordem lógica das dependências (sem execução automática)

1. Bronze: carga inicial das entidades disponíveis.
2. Silver: cópia/tratamento das entidades; `silver.alunos` antes de `silver.alunos_enriquecidos`.
3. Monitoring/qualidade: calcular e validar regras antes da publicação das análises dependentes.
4. Gold: indicadores anteriores e os sete indicadores de comparação já publicados; observar dependências específicas entre as tabelas.
5. Streaming: depende de eventos já presentes na Bronze, processados na Silver, antes de agregados Gold.

**Este material é um registro do código executado, não um instalador de ponta a ponta.** Evite rodar tudo indiscriminadamente em produção ou no projeto atual; há instruções que sobrescrevem tabelas.
