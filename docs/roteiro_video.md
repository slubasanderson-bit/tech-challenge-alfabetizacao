# Roteiro do vídeo executivo (até 5 minutos)

Use isto como guia, não como texto para ler palavra por palavra. O ideal é explicar as decisões com suas palavras enquanto mostra duas ou três telas reais do BigQuery. Não é necessário apresentar todos os comandos SQL.

## 1. Introdução — cerca de 35 segundos

"Neste Tech Challenge eu trabalhei com dados públicos sobre alfabetização no Brasil. A ideia foi reunir os registros de alunos, os indicadores por município e estado e as metas educacionais em uma estrutura que facilitasse a análise. O problema é que as tabelas têm recortes e códigos diferentes, então não basta juntar tudo e tirar uma média."

## 2. Como o projeto foi organizado — cerca de 1 minuto

"Usei o Google Cloud, principalmente o BigQuery, e organizei os dados em três camadas. Na Bronze ficam os registros recebidos, na Silver são feitos os tratamentos e a interpretação de códigos e, na Gold, ficam os indicadores e as comparações com metas. Separei também um dataset de monitoramento para registrar verificações e métricas."

**Mostrar:** lista dos datasets `bronze`, `silver`, `gold` e `monitoring` no console, depois a Gold com suas sete tabelas.

## 3. Qualidade e decisões — cerca de 1 minuto

"Uma das verificações mais importantes foi a correspondência entre resultados e metas municipais de 2024: 98,24% dos resultados encontraram uma meta cadastrada. Coloquei verificações antes de criar a tabela final para impedir chaves duplicadas e relações com menos de 95% de correspondência. Também mantive separadas as situações em que uma meta não estava cadastrada ou não tinha valor, em vez de chamar tudo de meta não atingida."

**Mostrar:** job `SUCCESS` com os `ASSERT` e, se disponível, uma execução que efetivamente falha em teste controlado.

## 4. Resultado principal — cerca de 1 minuto

"Entre os 5.232 municípios com comparação válida, 2.788 atingiram a meta de 2024 e 2.444 ficaram abaixo. No indicador nacional publicado para a rede pública, o resultado de 2024 foi 59,2%, enquanto a meta pactuada era 59,9%. Nos microdados, também calculei a taxa considerando o peso amostral, porque usar apenas a contagem de alunos pode distorcer o resultado."

**Mostrar:** tabela Gold de comparação municipal ou resultados salvos. Não comparar diretamente indicadores com recortes diferentes.

## 5. Limitações e uso futuro — cerca de 50 segundos

"Algumas UFs não apareceram na carga processada de microdados, e não consegui confirmar se essa ausência veio da fonte ou da ingestão. Também fiz testes com eventos simulados e registrei métricas, mas nem todo esse código está reunido no repositório. Essa é uma limitação importante. A base Gold, por outro lado, já serve para análises de desigualdade territorial e pode ser aproveitada mais adiante para modelos de previsão, tomando cuidado para não usar a própria variável que se quer prever como entrada."

## 6. Encerramento — cerca de 20 segundos

"O resultado foi uma estrutura analítica com dados organizados, verificações de qualidade e comparações de metas que podem ser conferidas no BigQuery. No repositório deixei os scripts disponíveis, os resultados e as limitações documentadas."

**Para a gravação:** use números idênticos aos do README. Só cite custos mensais se a tabela FinOps estiver concluída. O vídeo precisa ficar acessível por link e esse link deve aparecer no README.
