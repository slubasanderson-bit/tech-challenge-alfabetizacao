# FinOps: o que foi medido e o que falta projetar

A escolha pelo BigQuery simplificou o projeto, mas cada consulta pode consumir recursos. Em vez de afirmar que a solução é "barata" sem conta, separei o que foi observado durante o desenvolvimento do que ainda precisa ser convertido em custo mensal.

## Medidas anotadas durante as execuções

| Operação | Quantidade observada | Observação |
|---|---:|---|
| Armazenamento lógico no BigQuery | aproximadamente 1,53 GiB | medição anterior; anexar print para comprovar |
| Criação da comparação municipal | 1,88 MB processados | informação do histórico do job |
| Três `ASSERT` da comparação municipal | 538,95 KB + 292,69 KB + 831,64 KB | total de 1.663,28 KB nas três verificações |
| Criação da comparação estadual | 6,6 KB | informação do histórico |
| Criação da comparação nacional | 126 B | informação do histórico |

Esses números descrevem **dados processados**, não necessariamente bytes faturados nem custo de uma execução. O custo depende da modalidade do BigQuery, das franquias disponíveis e da região. Também não há medição anexada para Cloud Storage ou outros serviços, caso tenham sido usados.

## Modelo para a projeção mensal

| Serviço | Unidade para cobrança | Quantidade mensal | Preço unitário vigente | Custo estimado |
|---|---|---|---|---|
| BigQuery — armazenamento | GiB-mês | confirmar média do mês | consultar tabela oficial | calcular |
| BigQuery — consultas | GiB/TiB faturáveis ou capacidade | medir + multiplicar pela cadência mensal | consultar modalidade adotada | calcular |
| Outros serviços efetivamente usados | conforme serviço | confirmar uso | consultar tabela oficial | calcular |

Cálculo: **custo projetado = quantidade mensal cobrável × tarifa aplicável**, após considerar as franquias e o modelo de cobrança. Antes de enviar, registrar o preço consultado, a data e a hipótese de frequência de execução (por exemplo, uma atualização batch mensal, se essa for realmente a política pretendida). Não usar o total de bytes processados como se fosse uma fatura.

## Cuidados que entraram no projeto

Os SQLs filtram ano, série e rede antes de comparar tabelas, e algumas tabelas foram criadas com clusterização. A Silver de alunos foi criada com particionamento pelo momento de processamento. São decisões úteis para leitura e organização, mas ainda não foram medidos ganhos específicos de desempenho de cada uma.

**Falta para a versão final:** evidência de cobrança/medição atual, tarifas vigentes e a estimativa mensal com números. Não há comprovação neste pacote de uso de Parquet ou compressão externa, então não atribuí essas tecnologias à solução.
